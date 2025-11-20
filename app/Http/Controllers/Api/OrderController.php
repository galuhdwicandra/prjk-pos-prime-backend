<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\OrderSetCashPositionRequest;
use App\Http\Requests\Orders\IndexOrdersRequest;
use App\Http\Requests\OrderStoreRequest;
use App\Http\Requests\OrderUpdateRequest;
use App\Http\Requests\PaymentStoreRequest;
use App\Http\Requests\OrderCancelRequest;
use App\Models\Order;
use App\Services\CheckoutService;
use App\Services\QuoteService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class OrderController extends Controller
{
    public function __construct(
        private QuoteService $quote,
        private CheckoutService $checkout
    ) {}

    // GET /api/v1/orders  (list by cabang user; gunakan Policy via scope/Resource Policy)
    public function index(IndexOrdersRequest $req)
    {
        Gate::authorize('viewAny', Order::class);

        $actor = $req->user();
        $v = $req->validated();

        $sort = $v['sort'] ?? 'ordered_at';
        $dir  = $v['dir']  ?? 'desc';
        if (is_string($sort)) {
            if (str_starts_with($sort, '-')) {
                $sort = ltrim($sort, '-');
                $dir = 'desc';
            } elseif (str_starts_with($sort, '+')) {
                $sort = ltrim($sort, '+');
                $dir = 'asc';
            }
        }
        // Kolom yang boleh di-sort (sesuaikan bila perlu)
        $allowedSorts = ['ordered_at', 'kode', 'grand_total', 'status', 'created_at', 'cash_position'];
        if (!in_array($sort, $allowedSorts, true)) {
            $sort = 'ordered_at';
        }
        $dir = strtolower($dir) === 'asc' ? 'asc' : 'desc';

        $q = Order::query()
            ->with(['items', 'payments'])
            // auto-branch scoping for non-central users
            ->when(method_exists($actor, 'isCentral') && !$actor->isCentral(), fn($qq) => $qq->where('cabang_id', $actor->cabang_id))
            // manual filters (still allowed)
            ->when(!empty($v['cabang_id']), fn($qq, $cid) => $qq->where('cabang_id', $cid))
            ->when(!empty($v['status']), fn($qq, $st) => $qq->where('status', (string)$st))
            ->when(!empty($v['cash_position']), fn($qq, $cp) => $qq->where('cash_position', (string)$cp))
            ->when(!empty($v['q']), fn($qq, $kw) => $qq->where(function ($w) use ($kw) {
                $w->where('kode', 'like', "%{$kw}%")->orWhere('note', 'like', "%{$kw}%");
            }))
            ->when(!empty($v['start_date']), fn($qq, $d) => $qq->whereDate('ordered_at', '>=', $d))
            ->when(!empty($v['end_date']), fn($qq, $d) => $qq->whereDate('ordered_at', '<=', $d))
            ->orderBy($sort, $dir);

        return response()->json($q->paginate($v['per_page'] ?? 10));
    }
    // GET /api/v1/orders/{order}
    public function show(Order $order)
    {
        Gate::authorize('view', $order);
        return response()->json($order->load(['items', 'payments']));
    }

    // POST /api/v1/cart/quote  (hitung total dari items saja - tanpa simpan)
    public function quote(Request $req)
    {
        Gate::authorize('create', Order::class);

        Log::debug('AUTH DEBUG', [
            'user' => $req->user()?->only(['id', 'name', 'email', 'cabang_id']),
            'roles' => method_exists($req->user(), 'getRoleNames') ? $req->user()->getRoleNames() : [],
            'can_create_order' => $req->user()?->can('create', Order::class),
        ]);

        $data = $req->validate([
            'items' => ['required', 'array', 'min:1'],
            'items.*.variant_id' => ['required', 'integer', 'min:1'],
            'items.*.qty' => ['required', 'numeric', 'gt:0'],
            'items.*.discount' => ['nullable', 'numeric', 'min:0'],
            'items.*.price_hint' => ['nullable', 'numeric', 'min:0'],
        ]);

        $result = $this->quote->quoteItems($data['items']);
        return response()->json($result);
    }

    // POST /api/v1/checkout  (buat order + optional immediate payment)
    public function checkout(OrderStoreRequest $req)
    {
        Gate::authorize('create', Order::class);

        $payload = $req->validated();
        $cashierId = (int) $req->user()->id;

        $order = $this->checkout->checkout($payload, $cashierId);
        return response()->json($order->load(['items', 'payments']), Response::HTTP_CREATED);
    }

    // PUT /api/v1/orders/{order}  (edit item pada DRAFT/UNPAID)
    public function update(OrderUpdateRequest $req, Order $order)
    {
        Gate::authorize('update', $order);

        if (!$order->isEditable()) {
            return response()->json(['message' => 'Order tidak dapat diedit.'], 422);
        }

        $payload = $req->validated();

        return DB::transaction(function () use ($order, $payload) {
            $before = [
                'items'  => $order->items()->get(['variant_id', 'name_snapshot as name', 'price', 'discount', 'qty', 'line_total'])->toArray(),
                'totals' => $order->only(['subtotal', 'discount', 'tax', 'service_fee', 'grand_total', 'paid_total']),
                'status' => $order->status,
            ];

            $q = $this->quote->quoteItems($payload['items']);

            // simplest safe path: replace all items
            $order->items()->delete();
            foreach ($q['items'] as $line) {
                $order->items()->create($line + ['order_id' => $order->id]);
            }

            // recalc totals
            $order->fill($q['totals'])->save();

            $after = [
                'items'  => $order->items()->get(['variant_id', 'name_snapshot as name', 'price', 'discount', 'qty', 'line_total'])->toArray(),
                'totals' => $order->only(['subtotal', 'discount', 'tax', 'service_fee', 'grand_total', 'paid_total']),
                'status' => $order->status,
            ];

            $settlement = null;
            if ($order->status === 'PAID' && (float)$order->grand_total !== (float)$order->paid_total) {
                $settlement = [
                    'needed'  => $order->grand_total - $order->paid_total,
                    'message' => 'Total changed after payment; settlement required.',
                ];
            }

            \App\Models\OrderChangeLog::create([
                'order_id'   => $order->id,
                'actor_id'   => Auth::id(),
                'action'     => 'ITEM_EDIT',
                'diff_json'  => ['before' => $before, 'after' => $after, 'settlement' => $settlement],
                'note'       => $payload['note'] ?? null,
                'occurred_at' => now(),
            ]);

            return response()->json($order->fresh(['items', 'payments']));
        });
    }

    // POST /api/v1/orders/{order}/payments  (tambah pembayaran/split tender)
    public function addPayment(PaymentStoreRequest $req, Order $order)
    {
        Gate::authorize('addPayment', $order);

        $data = $req->validated();
        $order = $this->checkout->addPayment($order, $data);
        return response()->json($order->load(['items', 'payments']));
    }

    // POST /api/v1/orders/{order}/cancel
    public function cancel(OrderCancelRequest $req, Order $order)
    {
        Gate::authorize('cancel', $order);

        if ($order->isPaid()) {
            // kebijakan: hanya AdminCabang/Superadmin di policy yg lolos; di sini force VOID
            $order->status = 'VOID';
            $order->note = trim(($order->note ? $order->note . "\n" : '') . 'CANCEL: ' . $req->string('reason'));
            $order->save();
        } else {
            $order->status = 'VOID';
            $order->note = trim(($order->note ? $order->note . "\n" : '') . 'CANCEL: ' . $req->string('reason'));
            $order->save();
            // (opsional) hapus payments pending
        }

        return response()->json($order->fresh(['items', 'payments']));
    }

    public function setCashPosition(OrderSetCashPositionRequest $req, Order $order)
    {
        Gate::authorize('setCashPosition', $order);

        $v = $req->validated();

        return DB::transaction(function () use ($order, $v) {
            $before = $order->cash_position;

            $order->cash_position = $v['cash_position']; // CUSTOMER | CASHIER | SALES | ADMIN
            $order->save();

            // Audit ringkas (opsional, gunakan tabel log yang sudah ada)
            if (class_exists(\App\Models\OrderChangeLog::class)) {
                \App\Models\OrderChangeLog::create([
                    'order_id'    => $order->id,
                    'actor_id'    => Auth::id(),
                    'action'      => 'SET_CASH_POSITION',
                    'diff_json'   => ['before' => $before, 'after' => $order->cash_position],
                    'occurred_at' => now(),
                ]);
            }

            return response()->json($order->fresh(['items', 'payments']));
        });
    }

    // GET /api/v1/orders/{order}/print  -> HTML struk (58/80mm), tanpa file blade
    public function print(Order $order)
    {
        Gate::authorize('print', $order);

        $order->load(['items', 'payments', 'cabang', 'gudang', 'cashier']);
        $html = $this->renderReceiptHtml($order);

        try {
            \App\Models\OrderChangeLog::create([
                'order_id'    => $order->id,
                'actor_id'    => Auth::id(),
                'action'      => 'REPRINT',
                'diff_json'   => ['format' => 58], // bisa integer
                'occurred_at' => now(),
            ]);
        } catch (\Throwable $e) {
            Log::warning('Order reprint log failed', [
                'order_id' => $order->id,
                'error'    => $e->getMessage(),
            ]);
        }

        if (class_exists(\App\Models\Receipt::class)) {
            \App\Models\Receipt::create([
                'order_id'      => $order->id,
                'print_format'  => 58,            // <— integer
                'html_snapshot' => $html,
                'printed_at'    => now(),
                'printed_by'    => Auth::id(),    // <— opsional bagus
            ]);
        }

        return response($html, 200)->header('Content-Type', 'text/html; charset=UTF-8');
    }

    // ===== Helpers =====

    protected function renderReceiptHtml(Order $order): string
    {
        // Pastikan relasi sudah diload: items, payments, cabang, gudang, cashier
        $css = <<<CSS
    <style>
    *{box-sizing:border-box}
    body{font-family:ui-monospace,Menlo,Consolas,monospace;font-size:12px;margin:0;padding:0;color:#111}
    .wrap{width:58mm;max-width:58mm;margin:0 auto;padding:6px}
    h1,h2,h3,p{margin:0;padding:0}
    .center{text-align:center}
    .right{text-align:right}
    .muted{color:#555}
    .row{display:flex;justify-content:space-between;gap:8px}
    .hr{border-top:1px dashed #333;margin:6px 0}
    table{width:100%;border-collapse:collapse}
    td{vertical-align:top;padding:2px 0}
    .small{font-size:11px}
    .tot td{padding-top:4px}
    .tot .lbl{width:60%}
    .tot .val{width:40%;text-align:right}
    </style>
    CSS;

        // Baris item
        $lines = '';
        foreach ($order->items as $it) {
            $name = e($it->name_snapshot);
            $qty  = rtrim(rtrim(number_format((float)$it->qty, 2, '.', ''), '0'), '.');
            $price = number_format((float)$it->price, 2, '.', '');
            $disc = (float)$it->discount > 0 ? " (-" . number_format((float)$it->discount, 2, '.', '') . ")" : "";
            $lineTotal = number_format((float)$it->line_total, 2, '.', '');
            $lines .= "<tr><td colspan='2'>{$name}</td></tr>";
            $lines .= "<tr><td class='small'>{$qty} x {$price}{$disc}</td><td class='right'>{$lineTotal}</td></tr>";
        }

        // Hitung paid (SUCCESS saja), sisa, dan kembalian
        $paidSuccess = (float) $order->payments->where('status', 'SUCCESS')->sum('amount');
        $grand       = (float) $order->grand_total;
        $remaining   = max(0, $grand - $paidSuccess);   // Sisa Bayar
        $change      = max(0, $paidSuccess - $grand);   // Kembalian (hanya kas)
        $paidStr     = number_format($paidSuccess, 2, '.', '');
        $remainingStr = number_format($remaining, 2, '.', '');
        $changeStr   = number_format($change, 2, '.', '');

        // Meta header
        $metaTop = sprintf(
            '<div class="small muted">%s • %s</div>',
            e(optional($order->cabang)->nama ?? 'Cabang'),
            e(optional($order->gudang)->nama ?? 'Gudang')
        );
        $cashierName = e(optional($order->cashier)->name ?? '—'); // FIX: jangan pakai {e(...)} di heredoc

        // Badge status
        $statusBadge = $order->status === 'PAID' ? 'PAID' : ($order->status === 'VOID' ? 'VOID' : $order->status);

        // Tabel totals (selalu tampil Subtotal..GrandTotal + Paid)
        $totalsRows = '';
        $totalsRows .= sprintf(
            '<tr><td class="lbl">Subtotal</td><td class="val">%s</td></tr>',
            number_format((float)$order->subtotal, 2, '.', '')
        );
        $totalsRows .= sprintf(
            '<tr><td class="lbl">Discount</td><td class="val">%s</td></tr>',
            number_format((float)$order->discount, 2, '.', '')
        );
        $totalsRows .= sprintf(
            '<tr><td class="lbl">Service</td><td class="val">%s</td></tr>',
            number_format((float)$order->service_fee, 2, '.', '')
        );
        $totalsRows .= sprintf(
            '<tr><td class="lbl">Tax</td><td class="val">%s</td></tr>',
            number_format((float)$order->tax, 2, '.', '')
        );
        $totalsRows .= sprintf(
            '<tr><td class="lbl"><b>Grand Total</b></td><td class="val"><b>%s</b></td></tr>',
            number_format($grand, 2, '.', '')
        );
        $totalsRows .= sprintf('<tr><td class="lbl">Paid</td><td class="val">%s</td></tr>', $paidStr);

        // Tampilkan Sisa Bayar jika masih kurang
        if ($remaining > 0) {
            $totalsRows .= sprintf('<tr><td class="lbl"><b>Sisa Bayar</b></td><td class="val"><b>%s</b></td></tr>', $remainingStr);
        }

        // Tampilkan Change hanya jika ada kembalian
        if ($change > 0) {
            $totalsRows .= sprintf('<tr><td class="lbl">Change</td><td class="val">%s</td></tr>', $changeStr);
        }

        // (Opsional) Tampilkan ringkas DP jika paidSuccess > 0 namun belum lunas
        if ($paidSuccess > 0 && $remaining > 0) {
            $totalsRows .= sprintf('<tr><td class="lbl small muted">DP</td><td class="val small muted">%s</td></tr>', $paidStr);
        }

        $totals = "<table class=\"tot\">{$totalsRows}</table>";

        $orderedAt = $order->ordered_at ? e($order->ordered_at->format('Y-m-d H:i')) : '—';
        $kode = e($order->kode ?? '—');

        $html = <<<HTML
    <!doctype html><html><head><meta charset="utf-8">$css</head>
    <body onload="setTimeout(()=>{window.print&&window.print()},10)">
      <div class="wrap">
        <div class="center">
          <h2>POS PRIME</h2>
          {$metaTop}
          <div class="small">No: <b>{$kode}</b> • {$orderedAt}</div>
          <div class="small">Kasir: {$cashierName}</div>
          <div class="hr"></div>
        </div>

        <table>$lines</table>
        <div class="hr"></div>

        {$totals}
        <div class="hr"></div>

        <div class="center small">Status: <b>{$statusBadge}</b></div>
        <div class="center small muted">Terima kasih 🙏</div>
      </div>
    </body></html>
    HTML;

        return $html;
    }
}
