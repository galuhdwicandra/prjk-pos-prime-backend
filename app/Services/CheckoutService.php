<?php

namespace App\Services;

use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Payment;
use App\Models\Customer;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Carbon;
use InvalidArgumentException;
use App\Services\FeeService;
use App\Services\AccountingService;
use Illuminate\Support\Facades\Config;

class CheckoutService
{
    public function __construct(
        private QuoteService $quote,
        private SalesInventoryService $salesInv,
        private FeeService $fees,
    ) {}

    /**
     * One-shot checkout:
     * - Bisa tanpa payment (PENDING) -> order UNPAID
     * - Bisa DP (amount < grand_total)
     * - Bisa Full (amount >= grand_total)
     *
     * @param array $payload  // { items:[...], cabang_id, gudang_id, ... , payment?:{method,amount,status?,ref_no?,paid_at?,payload_json?} }
     * @param int $cashierId
     * @return Order
     */
    public function checkout(array $payload, int $cashierId): Order
    {
        return DB::transaction(function () use ($payload, $cashierId) {

            $items = $payload['items'] ?? [];
            if (empty($items)) {
                throw new InvalidArgumentException('Keranjang kosong.');
            }

            // Hitung quote dari item
            $q = $this->quote->quoteItems($items); // expect ['items'=>..., 'totals'=>['subtotal','discount','tax','service_fee','grand_total']]

            // Buat order
            $order = new Order();
            $order->kode       = $payload['kode'] ?? $this->generateCode((int)$payload['cabang_id']);
            $order->cabang_id  = (int)$payload['cabang_id'];
            $order->gudang_id  = (int)$payload['gudang_id'];
            $order->cashier_id = $cashierId;
            $order->customer_id = $payload['customer_id'] ?? null;
            $order->note        = $payload['note'] ?? null;

            $order->cash_position = $payload['cash_position'] ?? null;

            $customerPayload = $payload['customer'] ?? null;

            if (is_array($customerPayload)) {
                // pakai data dari payload (yang sudah diprefill dari pilihan customer)
                $order->customer_name    = $customerPayload['nama']   ?? null;
                $order->customer_phone   = $customerPayload['phone']  ?? null;
                $order->customer_address = $customerPayload['alamat'] ?? null;
            } elseif (!empty($payload['customer_id'])) {
                // fallback: kalau payload.customer tidak dikirim, ambil dari master Customer
                if ($c = Customer::find((int) $payload['customer_id'])) {
                    $order->customer_name    = $c->nama ?? null;
                    $order->customer_phone   = $c->phone ?? null;
                    $order->customer_address = $c->alamat ?? null;
                }
            }

            $order->ordered_at  = isset($payload['ordered_at']) ? Carbon::parse($payload['ordered_at']) : now();
            $order->status      = 'UNPAID';

            // totals
            $order->fill($q['totals']);  // set subtotal/discount/tax/service_fee/grand_total
            $order->paid_total = 0;
            $order->save();

            // Items
            foreach ($q['items'] as $line) {
                OrderItem::query()->create([
                    'order_id'      => $order->id,
                    'variant_id'    => $line['variant_id'],
                    'name_snapshot' => $line['name_snapshot'],
                    'price'         => $line['price'],
                    'discount'      => $line['discount'],
                    'qty'           => $line['qty'],
                    'line_total'    => $line['line_total'],
                ]);
            }

            // Payment opsional (PENDING kalau tidak dikirim)
            if (!empty($payload['payment'])) {
                $this->recordPayment($order, $payload['payment']);
            }

            $this->recomputeAndMaybeClose($order);

            return $order->fresh(['items', 'payments']);
        });
    }

    /**
     * Tambah pembayaran (split tender / pelunasan).
     * Melarang overpay melebihi sisa tagihan.
     */
    public function addPayment(Order $order, array $payment): Order
    {
        return DB::transaction(function () use ($order, $payment) {

            // Sisa tagihan sebelum tambah
            $paidSuccess = (float) $order->payments()->where('status', 'SUCCESS')->sum('amount');
            $remaining   = max(0.0, (float)$order->grand_total - $paidSuccess);

            $amount = (float)($payment['amount'] ?? 0);
            if ($amount <= 0) {
                throw new InvalidArgumentException('Nominal bayar harus lebih dari 0.');
            }
            if ($amount > $remaining) {
                throw new InvalidArgumentException('Nominal bayar melebihi sisa tagihan.');
            }

            $this->recordPayment($order, $payment);
            $this->recomputeAndMaybeClose($order);

            return $order->fresh(['items', 'payments']);
        });
    }

    /**
     * Simpan payment ke DB dengan default status per metode:
     * - CASH / QRIS => SUCCESS (bayar langsung)
     * - TRANSFER    => PENDING (default), bisa di-override via $p['status']
     *
     * Recalculate paid_total dari SUCCESS payments (lebih aman).
     */
    private function recordPayment(Order $order, array $p): void
    {
        $method = strtoupper((string)($p['method'] ?? ''));
        if (!in_array($method, ['CASH', 'TRANSFER', 'QRIS', 'XENDIT'], true)) {
            throw new InvalidArgumentException('Metode pembayaran tidak didukung.');
        }

        $amount = (float)($p['amount'] ?? 0);
        if ($amount <= 0) {
            throw new InvalidArgumentException('Nominal bayar harus lebih dari 0.');
        }

        // Default status
        $defaultStatus = match ($method) {
            'CASH', 'QRIS'      => 'SUCCESS',
            'TRANSFER', 'XENDIT' => 'PENDING',
            default             => 'PENDING',
        };
        $status = strtoupper((string)($p['status'] ?? $defaultStatus));
        if (!in_array($status, ['PENDING', 'SUCCESS', 'FAILED', 'REFUND'], true)) {
            throw new InvalidArgumentException('Status pembayaran tidak valid.');
        }

        // Cegah overpay di checkout juga (pakai sisa current)
        $paidSuccess = (float) $order->payments()->where('status', 'SUCCESS')->sum('amount');
        $remaining   = max(0.0, (float)$order->grand_total - $paidSuccess);
        if ($amount > $remaining) {
            throw new InvalidArgumentException('Nominal bayar melebihi sisa tagihan.');
        }

        // === KHUSUS XENDIT: buat invoice & ambil ref/URL ===
        $inv = null;
        if ($method === 'XENDIT') {
            /** @var \App\Services\XenditService $xendit */
            $xendit = app(\App\Services\XenditService::class);
            $inv = $xendit->createInvoice([
                'external_id' => 'ORD-' . $order->kode . '-' . now()->timestamp,
                'amount'      => (int) $amount,
                'description' => 'Pembayaran Order ' . $order->kode,
            ]);
        }

        $pay = new Payment();
        $pay->order_id     = $order->id;
        $pay->method       = $method;
        $pay->amount       = round($amount, 2);
        $pay->status       = $status;
        $pay->ref_no       = $method === 'XENDIT'
            ? ($inv['ref_no'] ?? null)
            : ($p['ref_no'] ?? null);
        $pay->payload_json = $method === 'XENDIT'
            ? array_filter([
                'checkout_url' => $inv['checkout_url'] ?? null,
                'xendit'       => $inv['raw'] ?? null,
            ])
            : ($p['payload_json'] ?? null);
        // paid_at hanya diisi saat SUCCESS; jika PENDING biarkan null
        $pay->paid_at      = ($status === 'SUCCESS')
            ? (isset($p['paid_at']) ? Carbon::parse($p['paid_at']) : now())
            : null;
        $pay->save();

        // Recompute paid_total from SUCCESS payments
        $order->paid_total = (float) $order->payments()
            ->where('status', 'SUCCESS')
            ->sum('amount');
        $order->save();

        if ($pay->method === 'CASH' && $pay->status === 'SUCCESS') {
            $holderId = null;
            if (!empty($pay->payload_json)) {
                $raw = is_string($pay->payload_json)
                    ? json_decode($pay->payload_json, true)
                    : $pay->payload_json;
                $holderId = $raw['holder_id'] ?? null;
            }

            if ($holderId) {
                /** @var \App\Services\CashService $cash */
                $cash = app(\App\Services\CashService::class);

                // Ambil/siapkan session aktif untuk holder tsb lalu catat transaksi + update saldo
                $cash->mirrorPaymentToHolder(
                    holderId: (int) $holderId,
                    amount: (float) $pay->amount,
                    paymentId: (int) $pay->id,
                    note: 'ORDER#' . $order->kode
                );
            }
        }
        if ($pay->status === 'SUCCESS') {
            $this->postAccountingForPayment($order, $pay);
        }
    }

    /**
     * Jika sudah lunas → tandai PAID  kurangi stok sekali (saat transisi ke PAID saja).
     */
    private function recomputeAndMaybeClose(Order $order): void
    {
        // Order sudah memiliki paid_total terbaru
        if ($order->paid_total >= $order->grand_total && $order->status !== 'PAID') {

            // Tentukan paid_at dari payment SUCCESS terbaru (fallback now)
            $lastPaidAt = $order->payments()
                ->where('status', 'SUCCESS')
                ->latest('paid_at')
                ->value('paid_at');

            $order->status  = 'PAID';
            $order->paid_at = $lastPaidAt ?: now();    // <— penting untuk period_date fee
            $order->save();

            // Kurangi stok di gudang per item (hanya sekali, saat transisi ke PAID)
            $items = $order->items()->get(['variant_id', 'qty']);
            foreach ($items as $it) {
                $this->salesInv->deductOnPaid(
                    gudangId: (int)$order->gudang_id,
                    variantId: (int)$it->variant_id,
                    qty: (float)$it->qty,
                    note: 'SALE#' . $order->kode
                );
            }

            // === NEW: generate fee entries berdasarkan rules aktif cabang ===
            $this->fees->generateForPaidOrder($order);
        }
    }

    /**
     * Resolve account mapping dari konfigurasi/setting.
     * Ganti implementasi ini agar membaca dari Settings modul milikmu (mis. table settings).
     * Key yang dipakai di sini: acc.cash_id, acc.bank_id, acc.sales_id.
     */
    private function resolveAccountId(string $key): int
    {
        // Coba baca dari helper global `setting()` jika ada
        $id = null;

        if (\function_exists('setting')) {
            /** @noinspection PhpFullyQualifiedNameUsageInspection */
            $id = \setting($key); // <— penting: leading backslash agar bukan App\Services\setting
        }

        // Fallback ke config (mis. config/accounting.php), atau mapping key sederhana
        if ($id === null) {
            // opsi 1: langsung pakai key yang sama bila kamu simpan di config('acc.*')
            $id = Config::get($key);

            // opsi 2 (opsional): map ke namespace config lain
            if ($id === null) {
                $map = [
                    'acc.cash_id'        => 'accounting.cash_id',
                    'acc.bank_id'        => 'accounting.bank_id',
                    'acc.sales_id'       => 'accounting.sales_id',
                    'acc.fee_expense_id' => 'accounting.fee_expense_id',
                    'acc.fee_payable_id' => 'accounting.fee_payable_id',
                ];
                $id = Config::get($map[$key] ?? $key);
            }
        }

        if (is_array($id)) {
            $id = $id['id'] ?? null;
        }
        // --- Pastikan integer valid ---
        $id = ($id !== null) ? (int) $id : 0;
        if ($id <= 0) {
            throw new \RuntimeException("Mapping akun '$key' belum dikonfigurasi.");
        }
        return $id;
    }

    /**
     * Buat DRAFT jurnal untuk pembayaran order yang sukses.
     * Skema default (cash-basis):
     *   - CASH/QRIS  : Debit Kas,   Kredit Pendapatan
     *   - TRANSFER   : Debit Bank,  Kredit Pendapatan
     * Ref: ORDER_PAYMENT (ref_id = payment.id)
     */
    private function postAccountingForPayment(Order $order, Payment $pay): void
    {
        /** @var AccountingService $acc */
        $acc = app(AccountingService::class);

        $isBank = in_array(strtoupper($pay->method), ['TRANSFER', 'XENDIT'], true);

        $cashId  = $this->resolveAccountId('acc.cash_id');   // Kas
        $bankId  = $this->resolveAccountId('acc.bank_id');   // Bank
        $salesId = $this->resolveAccountId('acc.sales_id');  // Pendapatan

        $debitAccountId = $isBank ? $bankId : $cashId;

        $acc->upsertDraft([
            'cabang_id'    => (int) $order->cabang_id,
            'journal_date' => $pay->paid_at?->toDateString() ?? now()->toDateString(),
            'number'       => 'PAY-' . $order->kode . '-' . $pay->id,
            'description'  => 'Pembayaran Order ' . $order->kode . ' (' . $pay->method . ')',
            'lines'        => [
                [
                    'account_id' => $debitAccountId,
                    'debit'      => (float) $pay->amount,
                    'credit'     => 0.0,
                    'ref_type'   => 'ORDER_PAYMENT',
                    'ref_id'     => (int) $pay->id,
                ],
                [
                    'account_id' => $salesId,
                    'debit'      => 0.0,
                    'credit'     => (float) $pay->amount,
                    'ref_type'   => 'ORDER_PAYMENT',
                    'ref_id'     => (int) $pay->id,
                ],
            ],
        ]);
    }

    private function generateCode(int $cabangId): string
    {
        // Placeholder: hubungkan ke modul "Kode Counter Per Cabang"
        return 'PRM-' . str_pad((string)now()->timestamp, 10, '0', STR_PAD_LEFT) . '-C' . $cabangId;
    }
}
