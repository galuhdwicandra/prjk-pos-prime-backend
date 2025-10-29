<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\Order;
use App\Models\OrderItem;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Carbon\Carbon;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class OrderService
{
    /**
     * List orders + filter by cabang/status/date/search
     */
    public function list(array $filter, ?int $userCabangId = null): LengthAwarePaginator
    {
        $q = Order::query()
            ->with(['items', 'payments'])
            ->when($userCabangId, fn($qq) => $qq->where('cabang_id', $userCabangId))
            ->when($filter['cabang_id'] ?? null, fn($qq, $v) => $qq->where('cabang_id', $v))
            ->when($filter['status'] ?? null, fn($qq, $v) => $qq->where('status', $v))
            ->when($filter['date_from'] ?? null, fn($qq, $v) => $qq->whereDate('ordered_at', '>=', $v))
            ->when($filter['date_to'] ?? null, fn($qq, $v) => $qq->whereDate('ordered_at', '<=', $v))
            ->when($filter['search'] ?? null, function ($qq, $v) {
                $like = "%{$v}%";
                $qq->where(function ($w) use ($like) {
                    $w->where('kode', 'like', $like)
                        ->orWhere('note', 'like', $like);
                });
            })
            ->orderByDesc('ordered_at');

        $perPage = (int)($filter['per_page'] ?? 10);
        return $q->paginate($perPage);
    }

    /**
     * Update items (add/update/remove) + recalc totals + audit diff.
     * Only for DRAFT/UNPAID by default (policy enforces).
     */
    public function updateItems(Order $order, array $payload, int $actorId): Order
    {
        return DB::transaction(function () use ($order, $payload, $actorId) {
            $before = $this->snapshot($order);

            // Remove items
            foreach (($payload['remove_item_ids'] ?? []) as $rid) {
                OrderItem::where('order_id', $order->id)->where('id', $rid)->delete();
            }

            // Upsert items
            foreach ($payload['items'] as $row) {
                // normalize numeric fields
                $price    = (float)($row['price'] ?? 0);
                $discount = (float)($row['discount'] ?? 0);
                $qty      = (float)($row['qty'] ?? 0);
                $line     = ($price - $discount) * $qty;

                if (!empty($row['id'])) {
                    // UPDATE existing row: do NOT null-out variant_id/name unless explicitly sent
                    /** @var \App\Models\OrderItem|null $existing */
                    $existing = OrderItem::where('order_id', $order->id)
                        ->where('id', $row['id'])
                        ->firstOrFail();

                    $update = [
                        'price'      => $price,
                        'discount'   => $discount,
                        'qty'        => $qty,
                        'line_total' => $line,
                    ];

                    // only set variant_id if present in payload
                    if (array_key_exists('variant_id', $row) && $row['variant_id'] !== null) {
                        $update['variant_id'] = (int)$row['variant_id'];
                    }

                    // only set name_snapshot if provided (avoid writing empty string if your column is NOT NULL)
                    if (isset($row['name']) && trim((string)$row['name']) !== '') {
                        $update['name_snapshot'] = (string)$row['name'];
                    }

                    $existing->update($update);
                } else {
                    // INSERT new row: variant_id REQUIRED
                    // (Your FormRequest already enforces required_without:id; here we assert)
                    if (empty($row['variant_id'])) {
                        throw new \InvalidArgumentException('variant_id is required for new items.');
                    }

                    OrderItem::create([
                        'order_id'      => $order->id,
                        'variant_id'    => (int)$row['variant_id'],
                        'name_snapshot' => (string)($row['name'] ?? ''), // ensure non-null; prefer real name if available
                        'price'         => $price,
                        'discount'      => $discount,
                        'qty'           => $qty,
                        'line_total'    => $line,
                    ]);
                }
            }

            // Recalculate totals
            $sum = OrderItem::where('order_id', $order->id)
                ->selectRaw('SUM(line_total) as subtotal')
                ->first();
            $order->subtotal = (float)($sum->subtotal ?? 0);
            // discount/tax/service_fee dipertahankan (jika ada logic lain, atur di sini)
            $order->grand_total = $order->subtotal - (float)$order->discount + (float)$order->tax + (float)$order->service_fee;
            $order->save();

            $after = $this->snapshot($order);
            $this->audit('ORDER_ITEMS_UPDATED', $order, [
                'before' => $before,
                'after'  => $after,
                'note'   => $payload['note'] ?? null,
            ], $actorId);

            return $order->load(['items', 'payments']);
        });
    }

    /**
     * Generate receipt HTML snapshot (server-side) & return printable payload.
     */
    public function reprintReceipt(Order $order, ?string $format, int $actorId): array
    {
        $format = $format ?: '58'; // '58' or '80'
        $order->load('items', 'payments');

        // Render HTML inline (no Blade file needed)
        $html = $this->renderReceiptHtml($order, $format);

        $this->audit('ORDER_RECEIPT_REPRINTED', $order, [
            'format'     => $format,
            'printed_at' => now()->toDateTimeString(),
        ], $actorId);

        return [
            'format' => $format,
            'html'   => $html,
            'wa_link' => $this->makeWaLink($order),
        ];
    }

    /**
     * Build WhatsApp link (manual share, sesuai flow PDF).
     */
    public function resendWA(Order $order, string $phone, ?string $message, int $actorId): array
    {
        $defaultMsg = $this->defaultWaMessage($order);
        $text = trim($message ?: $defaultMsg);
        $wa = 'https://wa.me/' . ltrim($phone, '+0') . '?text=' . urlencode($text);

        $this->audit('ORDER_WA_RESEND', $order, [
            'phone' => $phone,
            'message' => $text,
        ], $actorId);

        return ['wa_url' => $wa];
    }

    /** Helpers */
    protected function snapshot(Order $o): array
    {
        $o->loadMissing('items', 'payments');
        return [
            'order' => Arr::only($o->toArray(), [
                'id',
                'kode',
                'status',
                'subtotal',
                'discount',
                'tax',
                'service_fee',
                'grand_total',
                'paid_total'
            ]),
            'items' => $o->items->map(fn($i) => Arr::only($i->toArray(), [
                'id',
                'variant_id',
                'name_snapshot',
                'price',
                'discount',
                'qty',
                'line_total'
            ]))->all(),
        ];
    }

    protected function defaultWaMessage(Order $o): string
    {
        return "Terima kasih telah berbelanja.\n" .
            "Kode: {$o->kode}\nTotal: Rp " . $this->nf($o->grand_total, 0) .
            "\nTanggal: " . $o->ordered_at;
    }

    protected function makeWaLink(Order $o): string
    {
        $msg = $this->defaultWaMessage($o);
        return 'https://wa.me/?text=' . urlencode($msg);
    }

    private function nf($value, int $decimals = 0): string
    {
        $n = is_numeric($value) ? (float)$value : 0.0;
        return number_format($n, $decimals, ',', '.');
    }

    private function nfDot($value, int $decimals = 2): string
    {
        // untuk format dengan titik desimal (mis. Qty 2 desimal), lalu trim trailing .0
        $n = is_numeric($value) ? (float)$value : 0.0;
        return rtrim(rtrim(number_format($n, $decimals, '.', ''), '0'), '.');
    }

    protected function audit(string $action, Order $order, array $diff, int $actorId): void
    {
        // Tabel audit_logs ada di ERD dan Flow (disarankan).
        // Jika model AuditLog sudah ada, panggil di sini. Jika belum, bisa simpan via DB::table(...).
        if (!Schema::hasTable('audit_logs')) {
            return;
        }

        DB::table('audit_logs')->insert([
            'actor_type' => 'USER',
            'actor_id'   => $actorId,
            'action'     => $action,
            'model'      => 'Order',
            'model_id'   => $order->id,
            'diff_json'  => json_encode($diff, JSON_UNESCAPED_UNICODE),
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }

    protected function renderReceiptHtml(Order $order, string $format = '58'): string
    {
        // common printable widths: 58mm ≈ 384px, 80mm ≈ 576px
        $widthPx = $format === '80' ? 576 : 384;

        $kode   = e($order->kode);
        $date   = e(optional($order->ordered_at)->format('Y-m-d H:i') ?? (string)$order->ordered_at);
        $cabang = e((string)($order->cabang->nama ?? $order->cabang_id));
        $status = e((string)$order->status);

        $rows = '';
        foreach ($order->items as $it) {
            $name  = e($it->name_snapshot ?: '');
            $qty   = (float)$it->qty;            // ensure float
            $price = (float)$it->price;          // ensure float
            $disc  = (float)$it->discount;       // ensure float
            $line  = (float)$it->line_total;     // ensure float

            $rows .= '
            <tr>
            <td class="name">' . $name . '</td>
            <td class="qty">' . $this->nfDot($qty, 2) . '</td>
            <td class="price">Rp ' . $this->nf(($price - $disc), 0) . '</td>
            <td class="line">Rp ' . $this->nf($line, 0) . '</td>
            </tr>';
        }

        $subtotal   = $this->nf($order->subtotal, 0);
        $discount   = $this->nf($order->discount, 0);
        $tax        = $this->nf($order->tax, 0);
        $serviceFee = $this->nf($order->service_fee, 0);
        $grandTotal = $this->nf($order->grand_total, 0);
        $paidTotal  = $this->nf($order->paid_total, 0);
        $change     = $this->nf(max(0, (float)$order->paid_total - (float)$order->grand_total), 0);

        return <<<HTML
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Receipt {$kode}</title>
<style>
  * { box-sizing: border-box; }
  body { font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace; }
  .paper { width: {$widthPx}px; margin: 0 auto; padding: 8px; }
  h1, h2, h3, p { margin: 0; padding: 0; }
  .center { text-align: center; }
  .muted { opacity: .8; font-size: 12px; }
  hr { border: 0; border-top: 1px dashed #000; margin: 6px 0; }
  table { width: 100%; border-collapse: collapse; font-size: 12px; }
  th, td { padding: 2px 0; vertical-align: top; }
  td.qty { text-align: right; width: 38px; }
  td.price { text-align: right; width: 90px; }
  td.line { text-align: right; width: 110px; }
  td.name { width: calc(100% - 238px); }
  .totals td { padding: 2px 0; }
  .totals td.label { text-align: right; }
  .bold { font-weight: 700; }
  .footer { margin-top: 8px; }
  @media print {
    .paper { width: {$widthPx}px; }
  }
</style>
</head>
<body>
  <div class="paper">
    <div class="center">
      <h3>POS Prime</h3>
      <div class="muted">Cabang: {$cabang}</div>
    </div>
    <hr />
    <table>
      <tr><td><span class="bold">Kode</span></td><td>: {$kode}</td></tr>
      <tr><td><span class="bold">Tanggal</span></td><td>: {$date}</td></tr>
      <tr><td><span class="bold">Status</span></td><td>: {$status}</td></tr>
    </table>
    <hr />
    <table>
      <thead>
        <tr><th class="name">Item</th><th class="qty">Qty</th><th class="price">Harga</th><th class="line">Total</th></tr>
      </thead>
      <tbody>
        {$rows}
      </tbody>
    </table>
    <hr />
    <table class="totals">
      <tr><td class="label" colspan="3">Subtotal</td><td class="line">Rp {$subtotal}</td></tr>
      <tr><td class="label" colspan="3">Diskon</td><td class="line">Rp {$discount}</td></tr>
      <tr><td class="label" colspan="3">Pajak</td><td class="line">Rp {$tax}</td></tr>
      <tr><td class="label" colspan="3">Biaya Layanan</td><td class="line">Rp {$serviceFee}</td></tr>
      <tr><td class="label bold" colspan="3">Grand Total</td><td class="line bold">Rp {$grandTotal}</td></tr>
      <tr><td class="label" colspan="3">Dibayar</td><td class="line">Rp {$paidTotal}</td></tr>
      <tr><td class="label" colspan="3">Kembali</td><td class="line">Rp {$change}</td></tr>
    </table>
    <hr />
    <div class="center footer">
      <div>Terima kasih 🙏</div>
      <div class="muted">Simpan struk ini sebagai bukti transaksi</div>
    </div>
  </div>
</body>
</html>
HTML;
    }
}
