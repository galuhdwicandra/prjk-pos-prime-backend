<?php

namespace App\Services;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Carbon;

class DashboardService
{
    private int $ttl;

    public function __construct()
    {
        $this->ttl = (int) env('DASHBOARD_TTL_SECONDS', 60);
    }

    public function kpis(?int $cabangId, Carbon $from, Carbon $to): array
    {
        $key = "dash:kpi:c{$cabangId}:{$from->toDateString()}-{$to->toDateString()}";

        return Cache::store(config('cache.default'))->remember($key, $this->ttl, function () use ($cabangId, $from, $to) {
            $orders = DB::table('orders')
                ->when($cabangId, fn($q) => $q->where('cabang_id', $cabangId))
                ->whereBetween('ordered_at', [$from, $to]);

            $paidOrders = (clone $orders)->where('status', 'PAID');

            $ordersCount = (clone $orders)->count();
            $paidCount   = (clone $paidOrders)->count();
            $revenue     = (clone $paidOrders)->sum('grand_total');

            $avgTicket   = $paidCount > 0 ? (float) ($revenue / $paidCount) : 0.0;
            $paidRate    = $ordersCount > 0 ? round(($paidCount / $ordersCount) * 100, 2) : 0.0;

            // Reconcile against payments (SUCCESS) in same period and cabang
            $paidViaPayments = DB::table('payments')
                ->join('orders', 'payments.order_id', '=', 'orders.id')
                ->when($cabangId, fn($q) => $q->where('orders.cabang_id', $cabangId))
                ->where('payments.status', 'SUCCESS')
                ->whereBetween('payments.paid_at', [$from, $to])
                ->sum('payments.amount');

            $diff = (float) $revenue - (float) $paidViaPayments;
            $isConsistent = abs($diff) < 0.01;

            return [
                'orders_total' => (int) $ordersCount,
                'orders_paid'  => (int) $paidCount,
                'revenue'      => (float) $revenue,
                'avg_ticket'   => (float) $avgTicket,
                'paid_rate_pct' => (float) $paidRate,
                'validation'   => [
                    'paid_amount_sum' => (float) $paidViaPayments,
                    'orders_vs_payments_diff' => (float) $diff,
                    'is_consistent' => $isConsistent,
                ],
            ];
        });
    }

    public function chart7d(?int $cabangId): array
    {
        $to = now()->endOfDay();
        $from = now()->subDays(6)->startOfDay();
        $key = "dash:chart7d:c{$cabangId}:{$from->toDateString()}";

        return Cache::store(config('cache.default'))->remember($key, $this->ttl, function () use ($cabangId, $from, $to) {
            $rows = DB::table('orders')
                ->selectRaw("DATE(ordered_at) as d, COUNT(*) as cnt, SUM(CASE WHEN status='PAID' THEN grand_total ELSE 0 END) as revenue")
                ->when($cabangId, fn($q) => $q->where('cabang_id', $cabangId))
                ->whereBetween('ordered_at', [$from, $to])
                ->groupBy('d')
                ->orderBy('d')
                ->get();

            $map = $rows->keyBy('d');
            $days = [];
            for ($i = 0; $i < 7; $i++) {
                $day = now()->subDays(6 - $i)->toDateString();
                $days[] = [
                    'date' => $day,
                    'orders' => (int) ($map[$day]->cnt ?? 0),
                    'revenue' => (float) ($map[$day]->revenue ?? 0),
                ];
            }
            return $days;
        });
    }

    public function topProducts(?int $cabangId, int $limit = 5): array
    {
        $key = "dash:top:c{$cabangId}:l{$limit}";

        return Cache::store(config('cache.default'))->remember($key, $this->ttl, function () use ($cabangId, $limit) {
            $rows = DB::table('order_items as oi')
                ->join('orders as o', 'oi.order_id', '=', 'o.id')
                ->when($cabangId, fn($q) => $q->where('o.cabang_id', $cabangId))
                ->where('o.status', 'PAID')
                ->groupBy('oi.variant_id', 'oi.name_snapshot')
                ->selectRaw('oi.variant_id, oi.name_snapshot as name, SUM(oi.qty) as qty, SUM(oi.line_total) as revenue')
                ->orderByDesc('qty')
                ->limit($limit)
                ->get();

            return $rows->map(fn($r) => [
                'variant_id' => (int) $r->variant_id,
                'name' => $r->name,
                'qty' => (float) $r->qty,
                'revenue' => (float) $r->revenue,
            ])->all();
        });
    }

    public function lowStock(?int $cabangId, ?float $threshold = null): array
    {
        $key = "dash:low:c{$cabangId}:t" . ($threshold ?? 'min');

        return Cache::store(config('cache.default'))->remember($key, $this->ttl, function () use ($cabangId, $threshold) {
            // Use variant_stocks + product_variants + products
            $query = DB::table('variant_stocks as vs')
                ->join('product_variants as pv', 'vs.product_variant_id', '=', 'pv.id')
                ->join('products as p', 'pv.product_id', '=', 'p.id')
                ->when($cabangId, fn($q) => $q->where('vs.cabang_id', $cabangId))
                ->selectRaw('vs.gudang_id, vs.product_variant_id, pv.sku, p.nama as product_name, vs.qty, vs.min_stok');

            if ($threshold !== null) {
                $query->where('vs.qty', '<=', $threshold);
            } else {
                $query->whereColumn('vs.qty', '<=', 'vs.min_stok');
            }

            $rows = $query->orderBy('vs.qty')->limit(50)->get();

            return $rows->map(fn($r) => [
                'gudang_id'    => (int) $r->gudang_id,
                'variant_id'   => (int) $r->product_variant_id,
                'sku'          => $r->sku,
                'name'         => $r->product_name,
                'qty_on_hand'  => (float) $r->qty,
                'min_stock'    => (float) $r->min_stok,
            ])->all();
        });
    }

    public function quickActions(?int $cabangId): array
    {
        $low = $this->lowStock($cabangId, null);
        $actions = [];

        if (!empty($low)) {
            $actions[] = [
                'type' => 'LOW_STOCK',
                'label' => 'Replenish low stock items',
                'payload' => [
                    'count' => count($low),
                    'first_sku' => $low[0]['sku'] ?? null,
                ],
            ];
        }

        $chart = $this->chart7d($cabangId);
        $y = collect($chart)->firstWhere('date', now()->subDay()->toDateString());
        if ($y && $y['orders'] > 0 && $y['revenue'] == 0.0) {
            $actions[] = [
                'type' => 'PAYMENT_CHECK',
                'label' => 'Investigate payments with PENDING/FAILED status',
            ];
        }

        return $actions;
    }
}
