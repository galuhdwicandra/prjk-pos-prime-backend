<?php

namespace App\Services;

use App\Models\Setting;
use App\Models\AuditLog;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Carbon;

class SettingService
{
    /** Read settings with hierarchical fallback: USER -> BRANCH -> GLOBAL (if requested that way). */
    public function get(string $key, ?int $branchId = null, ?int $userId = null): ?array
    {
        // Simple direct lookups; advanced fallback can be added when integrating with other modules.
        if ($userId) {
            $row = Setting::query()->where(['scope' => 'USER', 'scope_id' => $userId, 'key' => $key])->first();
            if ($row) return $row->value_json;
        }
        if ($branchId) {
            $row = Setting::query()->where(['scope' => 'BRANCH', 'scope_id' => $branchId, 'key' => $key])->first();
            if ($row) return $row->value_json;
        }
        $row = Setting::query()->where(['scope' => 'GLOBAL', 'key' => $key])->first();
        return $row?->value_json;
    }

    /** Upsert a single setting; idempotent by (scope,scope_id,key). Writes audit diff. */
    public function upsert(string $scope, ?int $scopeId, string $key, array $value): Setting
    {
        return DB::transaction(function () use ($scope, $scopeId, $key, $value) {
            $before = Setting::query()->where(compact('scope'))->when($scopeId, fn($q) => $q->where('scope_id', $scopeId))
                ->where('key', $key)->first();

            $setting = Setting::updateOrCreate(
                ['scope' => $scope, 'scope_id' => $scopeId, 'key' => $key],
                ['value_json' => $value]
            );

            $this->audit('UPSERT', $setting, $before?->value_json, $value);
            return $setting;
        });
    }

    /** Bulk upsert multiple items. */
    public function bulkUpsert(array $items): int
    {
        $count = 0;
        DB::transaction(function () use (&$count, $items) {
            foreach ($items as $it) {
                $this->upsert($it['scope'], $it['scope_id'] ?? null, $it['key'], $it['value']);
                $count++;
            }
        });
        return $count;
    }

    /** Delete a setting; audited. */
    public function delete(Setting $setting): void
    {
        DB::transaction(function () use ($setting) {
            $before = $setting->value_json;
            $setting->delete();
            $this->audit('DELETE', $setting, $before, null);
        });
    }

    /** Export settings by filter. */
    public function export(?string $scope, ?int $scopeId, ?array $keys = null): array
    {
        $q = Setting::query();
        if ($scope) $q->where('scope', $scope);
        if ($scopeId) $q->where('scope_id', $scopeId);
        if ($keys) $q->whereIn('key', $keys);

        return $q->orderBy('scope')->orderBy('scope_id')->orderBy('key')
            ->get(['scope', 'scope_id', 'key', 'value_json'])
            ->toArray();
    }

    /** Import items with mode: replace|merge|skip. Returns [imported, skipped]. */
    public function import(array $items, string $mode = 'merge'): array
    {
        $imported = 0;
        $skipped = 0;
        DB::transaction(function () use (&$imported, &$skipped, $items, $mode) {
            foreach ($items as $it) {
                $existing = Setting::query()->where([
                    'scope' => $it['scope'],
                    'scope_id' => $it['scope_id'] ?? null,
                    'key' => $it['key'],
                ])->first();

                if (!$existing) {
                    $this->upsert($it['scope'], $it['scope_id'] ?? null, $it['key'], $it['value']);
                    $imported++;
                    continue;
                }

                if ($mode === 'skip') {
                    $skipped++;
                    continue;
                }
                if ($mode === 'replace') {
                    $this->upsert($it['scope'], $it['scope_id'] ?? null, $it['key'], $it['value']);
                    $imported++;
                    continue;
                }
                // merge (array recursive; value is array)
                $merged = array_replace_recursive($existing->value_json ?? [], $it['value'] ?? []);
                $this->upsert($it['scope'], $it['scope_id'] ?? null, $it['key'], $merged);
                $imported++;
            }
        });
        return compact('imported', 'skipped');
    }

    private function audit(string $action, Setting $setting, $before, $after): void
    {
        AuditLog::create([
            'actor_type' => 'USER',
            'actor_id'   => Auth::id(),
            'action'     => $action,
            'model'      => 'Setting',
            'model_id'   => $setting->id,
            'diff_json'  => ['before' => $before, 'after' => $after],
            'occurred_at' => Carbon::now(),
        ]);
    }
}
