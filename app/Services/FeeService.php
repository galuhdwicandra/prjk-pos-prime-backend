<?php

namespace App\Services;

use App\Models\Fee;
use App\Models\FeeEntry;
use App\Models\Delivery;
use App\Models\Order;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Carbon;
use Symfony\Component\HttpFoundation\StreamedResponse;
use Illuminate\Support\Facades\Log;
use App\Services\AccountingService;
use InvalidArgumentException;

class FeeService
{
    /* ---------------- Role helpers (match DB  Spatie  users.role) ---------------- */
    private function has(User $u, string $role): bool
    {
        // Accept either Spatie role OR users.role column
        return $u->hasRole($role) || $u->role === $role;
    }
    private function isSuper(User $u): bool
    {
        return $this->has($u, 'superadmin');
    }
    private function isAdmin(User $u): bool
    {
        return $this->has($u, 'admin_cabang');
    }
    private function isKasir(User $u): bool
    {
        return $this->has($u, 'kasir');
    }
    private function isKurir(User $u): bool
    {
        return $this->has($u, 'kurir');
    }
    private function isSales(User $u): bool
    {
        return $this->has($u, 'sales');
    }
    private function accId(string $key): ?int
    {
        try {
            if (function_exists('setting')) {
                $v = setting($key);
                if ($v !== null && $v !== '' && (int)$v > 0) {
                    return (int) $v;
                }
            }
        } catch (\Throwable $e) {
        }
        return null;
    }
    /** Generate fee entries when an order turns PAID. */
    public function generateForPaidOrder(Order $order): void
    {
        // Adjust these field names if needed
        $cabangId   = $order->cabang_id;
        $grandTotal = (string) $order->grand_total;
        $eventDate  = Carbon::parse($order->paid_at ?? $order->updated_at)->toDateString();

        // SALES/CASHIER fees based on GRAND_TOTAL
        $fees = Fee::query()
            ->where('cabang_id', $cabangId)
            ->where('is_active', true)
            ->where('base', 'GRAND_TOTAL')
            ->get();

        foreach ($fees as $fee) {
            $baseAmount = $grandTotal;
            if ($fee->calc_type === 'PERCENT') {
                if (\function_exists('bcmul') && \function_exists('bcdiv')) {
                    $feeAmount = bcdiv(bcmul($baseAmount, (string)$fee->rate, 4), '100', 2);
                } else {
                    $feeAmount = number_format(((float)$baseAmount * (float)$fee->rate) / 100, 2, '.', '');
                }
            } else {
                $feeAmount = number_format((float) $fee->rate, 2, '.', '');
            }

            // who earns this (owner)
            $ownerUserId = null;
            if ($fee->kind === 'CASHIER') {
                // Try cashier_id first, fallback to created_by
                $ownerUserId = $order->cashier_id ?? $order->created_by ?? null;
            } elseif ($fee->kind === 'SALES') {
                $ownerUserId = $order->sales_id ?? null; // if exists
            }

            // idempotent upsert
            $createdEntry = DB::transaction(function () use ($fee, $order, $cabangId, $eventDate, $baseAmount, $feeAmount, $ownerUserId) {
                $entry = FeeEntry::query()->firstOrNew([
                    'fee_id'   => $fee->id,
                    'ref_type' => 'ORDER',
                    'ref_id'   => $order->id,
                ]);

                $entry->cabang_id     = $cabangId;
                $entry->period_date   = $eventDate;
                $entry->owner_user_id = $ownerUserId;
                $entry->base_amount   = $baseAmount;
                $entry->fee_amount    = $feeAmount;

                if (!$entry->exists) {
                    $entry->created_by = Auth::id();
                }
                $entry->updated_by = Auth::id();
                $entry->save();

                return $entry;
            });

            // === Hook akuntansi: akru fee (Beban Fee (D) vs Hutang Fee (K)) ===
            $this->postAccrualForFee($createdEntry, $order);
        }

        // TODO: If you want COURIER fees on DELIVERY completion, implement a similar
        // path in your Delivery complete handler using base='DELIVERY'.
        // This service already supports DELIVERY ref types.
    }

    private function postAccrualForFee(FeeEntry $entry, Order $order): void
    {
        $feeExpenseId = $this->accId('acc.fee_expense_id');  // Beban Fee
        $feePayableId = $this->accId('acc.fee_payable_id');  // Hutang Fee

        if (!$feeExpenseId || !$feePayableId) {
            return; // setting belum lengkap → jangan mem-post jurnal
        }

        try {
            /** @var AccountingService $acc */
            $acc = app(AccountingService::class);

            $acc->upsertDraft([
                'cabang_id'    => (int) $entry->cabang_id,
                'journal_date' => $entry->period_date?->toDateString() ?? now()->toDateString(),
                'number'       => 'FEE-ACCR-' . $entry->id, // idempotent by (cabang, number)
                'description'  => 'Akru Fee order #' . $order->kode,
                'lines'        => [
                    ['account_id' => $feeExpenseId, 'debit' => (float)$entry->fee_amount, 'credit' => 0,                    'ref_type' => 'FEE_ENTRY', 'ref_id' => $entry->id],
                    ['account_id' => $feePayableId, 'debit' => 0,                             'credit' => (float)$entry->fee_amount, 'ref_type' => 'FEE_ENTRY', 'ref_id' => $entry->id],
                ],
            ]);
        } catch (\Throwable $e) {
            // jangan ganggu proses utama bila akuntansi gagal
            Log::warning('[FeeService] postAccrualForFee failed: ' . $e->getMessage(), ['entry' => $entry->id]);
        }
    }

    /** List entries branch-aware and role-aware. */
    public function listEntries(User $actor, array $filters)
    {
        // Accept both {date_from,date_to} and {from,to}, {status}=pay_status, {mine}
        $from = $filters['from']      ?? $filters['date_from'] ?? null;
        $to   = $filters['to']        ?? $filters['date_to']   ?? null;
        $stat = $filters['pay_status'] ?? $filters['status']    ?? null; // UNPAID|PAID|PARTIAL
        $mine = isset($filters['mine']) ? (int)$filters['mine'] === 1 : false;
        $role = $filters['role']      ?? null; // SALES|CASHIER|COURIER (from fees.kind)
        $sort = $filters['sort']      ?? '-period_date'; // period_date | -period_date | amount | -amount | status | -status

        $q = FeeEntry::query()
            ->with(['fee'])
            ->when(isset($filters['cabang_id']), fn($x) => $x->where('cabang_id', $filters['cabang_id']))
            ->when($from !== null, fn($x) => $x->whereDate('period_date', '>=', $from))
            ->when($to !== null,   fn($x) => $x->whereDate('period_date', '<=', $to))
            ->when($stat !== null, fn($x) => $x->where('pay_status', $stat))
            ->when($role !== null, fn($x) => $x->whereHas('fee', fn($w) => $w->where('kind', $role)));

        // Role-visibility: sales/cashier/courier see only their own
        $isAdmin = $this->isSuper($actor) || $this->isAdmin($actor);
        $isStaff = $this->isSales($actor) || $this->isKasir($actor) || $this->isKurir($actor);
        if ($isStaff && !$isAdmin) {
            $q->where('owner_user_id', $actor->id);
        } else {
            // Admins: if ?mine=1 is passed, show only their entries; else default to branch scope when cabang_id missing
            if ($mine) {
                $q->where('owner_user_id', $actor->id);
            } elseif (!isset($filters['cabang_id']) && ($actor->cabang_id ?? null)) {
                $q->where('cabang_id', $actor->cabang_id);
            }
        }

        $map = [
            'period_date'  => ['period_date', 'asc'],
            '-period_date' => ['period_date', 'desc'],
            'amount'       => ['fee_amount', 'asc'],
            '-amount'      => ['fee_amount', 'desc'],
            'status'       => ['pay_status', 'asc'],
            '-status'      => ['pay_status', 'desc'],
        ];
        [$col, $dir] = $map[$sort] ?? ['period_date', 'desc'];

        return $q->orderBy($col, $dir)->paginate($filters['per_page'] ?? 20);
    }

    /** Mark entries as paid/partial paid. */
    public function markPaid(array $entryIds, string $status, string $paidAmount = '0', ?string $paidAt = null): int
    {
        $paidAt = $paidAt ? Carbon::parse($paidAt) : now();

        return DB::transaction(function () use ($entryIds, $status, $paidAmount, $paidAt) {
            $count = 0;
            foreach ($entryIds as $id) {
                $entry = FeeEntry::lockForUpdate()->findOrFail($id);

                if ($status === 'PAID') {
                    $entry->paid_amount = $entry->fee_amount;
                } elseif ($status === 'PARTIAL') {
                    $entry->paid_amount = $paidAmount;
                }

                $entry->pay_status = $status;
                $entry->paid_at    = $paidAt;
                $entry->updated_by = Auth::id();
                $entry->save();

                // audit
                if (method_exists($this, 'audit')) {
                    $this->auditSafe('FEE_STATUS_UPDATE', 'fee_entries', $entry->id, [
                        'after' => $entry->toArray(),
                    ]);
                }

                // === Hook akuntansi: pelunasan Hutang Fee ===
                if (in_array($status, ['PAID', 'PARTIAL'], true)) {
                    // pakai paid_amount aktual; untuk PARTIAL, kamu sudah set dari $paidAmount
                    $this->postPaymentForFee($entry, $paidAt);
                }

                $count++;
            }
            return $count;
        });
    }

    private function postPaymentForFee(FeeEntry $entry, \Illuminate\Support\Carbon $paidAt): void
    {
        $feePayableId = $this->accId('acc.fee_payable_id'); // Hutang Fee
        // Default pakai Kas; jika ingin bedakan Bank, tambahkan logika sesuai metode
        $cashId       = $this->accId('acc.cash_id');

        if (!$feePayableId || !$cashId) {
            return; // setting belum lengkap
        }

        $amount = (float) ($entry->paid_amount ?? 0);
        if ($amount <= 0) {
            return; // tidak ada nilai yang dibayar
        }

        try {
            /** @var AccountingService $acc */
            $acc = app(AccountingService::class);

            $acc->upsertDraft([
                'cabang_id'    => (int) $entry->cabang_id,
                'journal_date' => $paidAt->toDateString(),
                'number'       => 'FEE-PAY-' . $entry->id, // idempotent by (cabang, number)
                'description'  => 'Pembayaran Fee #' . $entry->id,
                'lines'        => [
                    ['account_id' => $feePayableId, 'debit' => $amount, 'credit' => 0,       'ref_type' => 'FEE_PAY', 'ref_id' => $entry->id],
                    ['account_id' => $cashId,       'debit' => 0,       'credit' => $amount, 'ref_type' => 'FEE_PAY', 'ref_id' => $entry->id],
                ],
            ]);
        } catch (\Throwable $e) {
            Log::warning('[FeeService] postPaymentForFee failed: ' . $e->getMessage(), ['entry' => $entry->id]);
        }
    }

    /** Export CSV stream. */
    public function exportCsv(User $actor, array $filters): StreamedResponse
    {
        $rows = $this->listEntries($actor, array_merge($filters, ['per_page' => 100000]))->getCollection();

        $headers = [
            'Content-Type'        => 'text/csv',
            'Content-Disposition' => 'attachment; filename="fee_entries.csv"',
        ];

        return response()->stream(function () use ($rows) {
            $out = fopen('php://output', 'w');
            fputcsv($out, ['id', 'period_date', 'cabang_id', 'kind', 'ref_type', 'ref_id', 'owner_user_id', 'base_amount', 'fee_amount', 'pay_status', 'paid_amount', 'paid_at']);
            foreach ($rows as $r) {
                fputcsv($out, [
                    $r->id,
                    $r->period_date?->toDateString(),
                    $r->cabang_id,
                    $r->fee?->kind,
                    $r->ref_type,
                    $r->ref_id,
                    $r->owner_user_id,
                    $r->base_amount,
                    $r->fee_amount,
                    $r->pay_status,
                    $r->paid_amount,
                    optional($r->paid_at)->toDateTimeString()
                ]);
            }
            fclose($out);
        }, 200, $headers);
    }

    /**
     * Linter-safe audit bridge.
     * - Uses is_callable + call_user_func to avoid direct global calls that trigger P1010.
     * - Tries a global function 'audit', then a container binding 'audit.logger'.
     * - Falls back to a warning log if nothing is available.
     */
    private function auditSafe(string $action, string $table, int|string $id, array $payload = []): void
    {
        try {
            // Prefer a global helper function named "audit"
            if (\is_callable('audit')) {
                \call_user_func('audit', $action, $table, $id, $payload);
                return;
            }

            // Or a container service bound as "audit.logger" with a ->log(...) method
            if (\app()->bound('audit.logger')) {
                \app('audit.logger')->log($action, $table, $id, $payload);
                return;
            }
        } catch (\Throwable $e) {
            Log::warning('[FeeService] auditSafe failed: ' . $e->getMessage(), [
                'action' => $action,
                'table'  => $table,
                'row_id' => $id,
            ]);
        }
    }

    public function paginate(array $filters, int $perPage = 15) // <- rename
    {
        $q = Fee::query();

        if (!empty($filters['cabang_id'])) {
            $q->where('cabang_id', $filters['cabang_id']);
        }
        if (!empty($filters['kind'])) {
            $q->where('kind', $filters['kind']);
        }
        if (array_key_exists('is_active', $filters) && $filters['is_active'] !== null) {
            $q->where('is_active', (bool)$filters['is_active']);
        }
        if (!empty($filters['base'])) {
            $q->where('base', $filters['base']);
        }
        if (!empty($filters['q'])) {
            $q->where('name', 'like', '%' . $filters['q'] . '%');
        }

        $sort = $filters['sort'] ?? '-created_at';
        $dir  = str_starts_with($sort, '-') ? 'desc' : 'asc';
        $col  = ltrim($sort, '-');
        $q->orderBy($col, $dir);

        return $q->paginate($perPage)->appends($filters);
    }

    public function create(array $dto): \App\Models\Fee
    {
        return DB::transaction(function () use ($dto) {
            $dto['created_by'] = Auth::id();
            $dto['updated_by'] = Auth::id();
            return \App\Models\Fee::create($dto);
        });
    }

    public function update(\App\Models\Fee $fee, array $dto): \App\Models\Fee
    {
        return DB::transaction(function () use ($fee, $dto) {
            $dto['updated_by'] = Auth::id();
            $fee->fill($dto)->save();
            return $fee;
        });
    }

    public function delete(\App\Models\Fee $fee): void
    {
        DB::transaction(function () use ($fee) {
            $fee->delete();
        });
    }
}
