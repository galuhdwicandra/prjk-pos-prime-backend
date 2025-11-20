<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\OrderSetCashPositionRequest;
use App\Http\Requests\Orders\IndexOrdersRequest;
use App\Http\Requests\Orders\UpdateOrderItemsRequest;
use App\Http\Requests\Orders\ReprintReceiptRequest;
use App\Http\Requests\Orders\ResendWARequest;
use App\Models\Order;
use App\Services\OrderService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;

class OrdersController extends Controller
{
    public function __construct(private OrderService $service) {}

    public function index(IndexOrdersRequest $req)
    {
        $this->authorize('viewAny', Order::class);
        $user = $req->user();
        $paginator = $this->service->list(
            $req->validated(),
            $user->role === 'superadmin' ? null : $user->cabang_id
        );
        // Jika $paginator instanceof LengthAwarePaginator, kembalikan langsung agar shape sesuai harapan frontend
        return response()->json($paginator);
    }

    public function show(Request $req, Order $order)
    {
        $this->authorize('view', $order);
        return response()->json(['data' => $order->load(['items', 'payments'])]);
    }

    public function updateItems(UpdateOrderItemsRequest $req, Order $order)
    {
        $this->authorize('update', $order);
        $updated = $this->service->updateItems($order, $req->validated(), $req->user()->id);
        return response()->json(['message' => 'Order updated', 'data' => $updated]);
    }

    public function reprint(ReprintReceiptRequest $req, Order $order)
    {
        $this->authorize('reprint', $order);
        $payload = $this->service->reprintReceipt($order, $req->validated()['format'] ?? null, $req->user()->id);
        return response()->json(['message' => 'Receipt generated', 'data' => $payload]);
    }

    public function setCashPosition(OrderSetCashPositionRequest $req, Order $order)
    {
        $this->authorize('setCashPosition', $order);

        $v = $req->validated();

        return DB::transaction(function () use ($order, $v) {
            $before = $order->cash_position;
            $order->cash_position = $v['cash_position']; // CUSTOMER | CASHIER | SALES | ADMIN
            $order->save();

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

    public function resendWA(ResendWARequest $req, Order $order)
    {
        $this->authorize('resendWA', $order);
        $payload = $this->service->resendWA(
            $order,
            $req->validated()['phone'],
            $req->validated()['message'] ?? null,
            $req->user()->id
        );
        return response()->json(['message' => 'WA link created', 'data' => $payload]);
    }
}
