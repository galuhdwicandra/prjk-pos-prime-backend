<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use App\Models\Payment;
use App\Models\Order;
use Carbon\Carbon;

class PaymentWebhookController extends Controller
{
    public function invoice(Request $req)
    {
        // Validasi token sederhana (Xendit mengirim X-Callback-Token bila diaktifkan)
        $expected = (string) env('XENDIT_CALLBACK_TOKEN');
        $token = (string) $req->header('X-Callback-Token', '');

        if ($expected !== '' && !hash_equals($expected, $token)) {
            abort(403, 'Invalid callback token');
        }

        $payload = $req->all();
        $status  = strtoupper((string)($payload['status'] ?? ''));
        $extId   = (string)($payload['external_id'] ?? '');

        if ($extId === '') {
            throw ValidationException::withMessages(['external_id' => 'Missing external_id']);
        }

        return DB::transaction(function () use ($status, $extId, $payload) {
            /** @var Payment|null $payment */
            $payment = Payment::lockForUpdate()
                ->where('method', 'XENDIT')
                ->where('ref_no', $extId)
                ->first();

            if (!$payment) {
                abort(404, 'Payment not found');
            }

            /** @var Order $order */
            $order = Order::lockForUpdate()->findOrFail($payment->order_id);

            if ($status === 'PAID') {
                $payment->status   = 'SUCCESS';
                $payment->paid_at  = Carbon::now();
                $payment->payload_json = $payload;
                $payment->save();

                // akumulasi ke order
                $order->paid_total = (float) $order->paid_total + (float) $payment->amount;
                if ($order->paid_total >= $order->grand_total) {
                    $order->status = 'PAID';
                    $order->paid_at = Carbon::now();
                } else {
                    $order->status = 'UNPAID';
                }
                $order->save();
            } elseif (in_array($status, ['EXPIRED', 'VOID', 'FAILED'], true)) {
                $payment->status   = $status === 'FAILED' ? 'FAILED' : 'FAILED';
                $payment->payload_json = $payload;
                $payment->save();
            }

            return response()->json(['ok' => true]);
        });
    }
}
