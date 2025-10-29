<?php

namespace App\Services;

use App\Models\Customer;
use App\Models\CustomerTimeline;
use App\Models\Order;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

class CustomerService
{
    /** Idempotent create-or-get by phone within a branch. */
    public function upsertByPhone(int $cabangId, array $dto): Customer
    {
        // expected keys: nama, phone, email?, alamat?, catatan?
        return DB::transaction(function () use ($cabangId, $dto) {
            $phone = trim($dto['phone'] ?? '');
            if ($phone === '') {
                throw new \InvalidArgumentException('Phone is required for customer upsert.');
            }

            $existing = Customer::where('cabang_id', $cabangId)
                ->where('phone', $phone)
                ->lockForUpdate()
                ->first();

            if ($existing) {
                // optional: update simple fields if provided
                $patch = array_filter([
                    'nama'   => $dto['nama']   ?? null,
                    'email'  => $dto['email']  ?? null,
                    'alamat' => $dto['alamat'] ?? null,
                    'catatan' => $dto['catatan'] ?? null,
                ], fn($v) => !is_null($v));
                if ($patch) {
                    $existing->fill($patch)->save();
                    $this->audit('CUSTOMER_UPDATE_AUTO', 'customers', $existing->id, ['after' => $patch]);
                }
                return $existing;
            }

            $customer = new Customer([
                'cabang_id' => $cabangId,
                'nama'      => $dto['nama'] ?? 'Customer',
                'phone'     => $phone,
                'email'     => $dto['email']  ?? null,
                'alamat'    => $dto['alamat'] ?? null,
                'catatan'   => $dto['catatan'] ?? null,
                'stage'     => 'ACTIVE',
            ]);
            $customer->save();

            $this->audit('CUSTOMER_CREATE', 'customers', $customer->id, ['after' => $customer->toArray()]);

            // timeline: created
            CustomerTimeline::create([
                'customer_id' => $customer->id,
                'event_type'  => 'NOTE',
                'title'       => 'Customer created',
                'meta'        => ['source' => 'POS'],
                'happened_at' => now(),
            ]);

            return $customer;
        });
    }

    /** Listing with search + optional stage and date filters, branch-scoped. */
    public function list(int $cabangId, array $filter = [])
    {
        $q = Customer::query()->forCabang($cabangId);

        if (!empty($filter['q'])) {
            $term = '%' . str_replace(' ', '%', $filter['q']) . '%';
            $q->where(function ($w) use ($term) {
                $w->where('nama', 'ILIKE', $term)
                    ->orWhere('phone', 'ILIKE', $term)
                    ->orWhere('email', 'ILIKE', $term);
            });
        }

        if (!empty($filter['stage'])) {
            $q->where('stage', $filter['stage']);
        }

        if (!empty($filter['from']) && !empty($filter['to'])) {
            $from = Carbon::parse($filter['from'])->startOfDay();
            $to   = Carbon::parse($filter['to'])->endOfDay();
            // Include customers with no orders by falling back to created_at
            // PostgreSQL-safe: COALESCE(last_order_at, created_at)
            $q->whereRaw(
                '(COALESCE(last_order_at, created_at) BETWEEN ? AND ?)',
                [$from, $to]
            );
        }

        return $q->orderByDesc('last_order_at')->paginate($filter['per_page'] ?? 15);
    }

    /** Detailed customer with purchase summary and latest orders (optional). */
    public function detail(Customer $customer, int $limitOrders = 10): array
    {
        $orders = Order::where('customer_id', $customer->id)
            ->orderByDesc('ordered_at')
            ->limit($limitOrders)
            ->get(['id', 'kode', 'grand_total', 'status', 'ordered_at', 'paid_at']);

        return [
            'customer' => $customer,
            'orders'   => $orders,
        ];
    }

    /** Append timeline entry (ORDER/PAYMENT/STAGE/NOTE). */
    public function addTimeline(Customer $customer, string $type, ?string $title, ?string $note, array $meta = []): void
    {
        CustomerTimeline::create([
            'customer_id' => $customer->id,
            'event_type'  => $type,
            'title'       => $title,
            'note'        => $note,
            'meta'        => $meta,
            'happened_at' => now(),
        ]);
    }

    /** Update stage and log to timeline. */
    public function setStage(Customer $customer, string $stage): Customer
    {
        DB::transaction(function () use ($customer, $stage) {
            $before = $customer->stage;
            $customer->stage = $stage;
            $customer->save();

            $this->audit('CUSTOMER_STAGE', 'customers', $customer->id, [
                'before' => ['stage' => $before],
                'after'  => ['stage' => $stage],
            ]);

            $this->addTimeline($customer, 'STAGE', 'Stage updated', null, [
                'from' => $before,
                'to'   => $stage,
            ]);
        });

        return $customer->refresh();
    }

    /** Sync aggregates after an order is paid/finalized. */
    public function syncAggregatesAfterOrder(int $customerId): void
    {
        DB::transaction(function () use ($customerId) {
            $customer = Customer::lockForUpdate()->findOrFail($customerId);

            $agg = DB::table('orders')
                ->selectRaw('COUNT(*)::bigint as total_orders, COALESCE(SUM(grand_total),0)::numeric as total_spent, MAX(ordered_at) as last_order_at')
                ->where('customer_id', $customerId)
                ->whereIn('status', ['FINAL', 'PAID', 'SUCCESS']) // align to your order statuses
                ->first();

            $customer->total_orders = (int)($agg->total_orders ?? 0);
            $customer->total_spent  = $agg->total_spent ?? 0;
            $customer->last_order_at = $agg->last_order_at;
            $customer->save();
        });
    }

    private function audit(string $action, string $table, int $id, array $payload = []): void
    {
        // Plug into your real audit trail (per SOP).
        if (function_exists('logger')) {
            logger()->info('[AUDIT] ' . $action, ['table' => $table, 'id' => $id, 'payload' => $payload]);
        }
    }
}
