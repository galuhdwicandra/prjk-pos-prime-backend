<?php

namespace App\Http\Controllers\Api; // keep this to match your folder casing

use App\Http\Controllers\Controller;
use App\Http\Requests\SettingQueryRequest;
use App\Http\Requests\SettingUpsertRequest;
use App\Http\Requests\SettingBulkUpsertRequest;
use App\Http\Requests\ExportRequest;
use App\Http\Requests\ImportRequest;
use App\Models\Setting;
use App\Services\SettingService;

class SettingsController extends Controller
{
    public function __construct(private SettingService $svc) {}

    /** GET /api/v1/settings */
    public function index(SettingQueryRequest $req)
    {
        $this->authorize('viewAny', Setting::class);

        $v = $req->validated();
        $scope   = $v['scope']    ?? null;                 // 'GLOBAL' | 'BRANCH' | 'USER' | null
        $scopeId = $v['scope_id'] ?? null;                 // int|null
        $keys    = $v['keys']     ?? null;                 // array<string>|null

        $data = $this->svc->export($scope, $scopeId, $keys);

        return response()->json([
            'data' => $data,
            'meta' => [],
            'message' => 'OK',
            'errors' => null,
        ]);
    }

    /** POST /api/v1/settings/upsert */
    public function upsert(SettingUpsertRequest $req)
    {
        $this->authorize('create', Setting::class);

        $v = $req->validated();
        $setting = $this->svc->upsert(
            $v['scope'],
            $v['scope_id'] ?? null,
            $v['key'],
            $v['value'] // array
        );

        // confirm user is allowed to update this particular row (branch scoping)
        $this->authorize('update', $setting);

        return response()->json([
            'data' => $setting,
            'meta' => [],
            'message' => 'Saved',
            'errors' => null,
        ]);
    }

    /** POST /api/v1/settings/bulk-upsert */
    public function bulkUpsert(SettingBulkUpsertRequest $req)
    {
        $this->authorize('create', Setting::class);

        $v = $req->validated();
        $count = $this->svc->bulkUpsert($v['items']);

        return response()->json([
            'data' => ['count' => $count],
            'meta' => [],
            'message' => 'Saved',
            'errors' => null,
        ]);
    }

    /** DELETE /api/v1/settings/{setting} */
    public function destroy(Setting $setting)
    {
        $this->authorize('delete', $setting);

        $this->svc->delete($setting);

        return response()->json([
            'data' => null,
            'meta' => [],
            'message' => 'Deleted',
            'errors' => null,
        ]);
    }

    /** GET /api/v1/settings/export */
    public function export(ExportRequest $req)
    {
        $this->authorize('export', Setting::class);

        $v = $req->validated();
        $scope   = $v['scope']    ?? null;
        $scopeId = $v['scope_id'] ?? null;
        $keys    = $v['keys']     ?? null;

        $items = $this->svc->export($scope, $scopeId, $keys);

        return response()->json([
            'data' => ['items' => $items],
            'meta' => ['format' => 'json'],
            'message' => 'OK',
            'errors' => null,
        ]);
    }

    /** POST /api/v1/settings/import */
    public function import(ImportRequest $req)
    {
        $this->authorize('import', Setting::class);

        $v = $req->validated();
        $result = $this->svc->import(
            $v['items'],
            $v['mode'] ?? 'merge' // replace | merge | skip
        );

        return response()->json([
            'data' => $result,
            'meta' => [],
            'message' => 'Imported',
            'errors' => null,
        ]);
    }
}
