<?php

namespace App\Services;

use App\Models\{CashMove, CashHolder, CashSession, CashTransaction, Payment};
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;

class CashService
{
    // Submit a move (draft->submitted), idempotent on idempotency_key
    public function submitMove(array $payload, int $actorId): CashMove
    {
        return DB::transaction(function () use ($payload, $actorId) {
            $key = $payload['idempotency_key'] ?? null;
            if ($key && ($existing = CashMove::where('idempotency_key', $key)->first())) {
                return $existing;
            }
            $move = new CashMove([
                'from_holder_id' => $payload['from_holder_id'],
                'to_holder_id'   => $payload['to_holder_id'],
                'amount'         => $payload['amount'],
                'note'           => $payload['note'] ?? null,
                'moved_at'       => Carbon::parse($payload['moved_at']),
                'status'         => 'SUBMITTED',
                'submitted_by'   => $actorId,
                'idempotency_key' => $key,
            ]);
            $move->save();
            // audit
            $this->audit('SUBMIT', 'cash_moves', $move->id, ['after' => $move->toArray()]);
            return $move;
        });
    }

    // Approve: adjust balances atomically
    public function approveMove(CashMove $move, ?string $approvedAt, int $approverId): CashMove
    {
        return DB::transaction(function () use ($move, $approvedAt, $approverId) {
            $move->refresh();
            if ($move->status === 'APPROVED') {
                return $move;
            }
            if ($move->status !== 'SUBMITTED') {
                throw new \RuntimeException('Move must be SUBMITTED');
            }

            $from = CashHolder::lockForUpdate()->findOrFail($move->from_holder_id);
            $to   = CashHolder::lockForUpdate()->findOrFail($move->to_holder_id);
            if ($from->balance < $move->amount) {
                throw new \RuntimeException('Insufficient balance');
            }

            $fromBefore = $from->balance;
            $toBefore   = $to->balance;
            // precise to 2 decimals without BCMath
            $from->balance = (string) round(((float) $from->balance) - (float) $move->amount, 2);
            $to->balance   = (string) round(((float) $to->balance)   + (float) $move->amount, 2);

            $from->save();
            $to->save();

            $move->status = 'APPROVED';
            $move->approved_by = $approverId;
            $move->approved_at = $approvedAt ? Carbon::parse($approvedAt) : now();
            $move->save();

            $this->audit('APPROVE', 'cash_moves', $move->id, [
                'before' => ['from.balance' => $fromBefore, 'to.balance' => $toBefore, 'status' => 'SUBMITTED'],
                'after' => ['from.balance' => $from->balance, 'to.balance' => $to->balance, 'status' => 'APPROVED'],
            ]);

            // === ACCOUNTING HOOK (versi afterCommit, lebih aman) ===
            DB::afterCommit(function () use ($from, $to, $move) {
                try {
                    if (Auth::user()?->hasAnyRole(['superadmin', 'admin_cabang'])) {
                        /** @var \App\Services\AccountingService $acc */
                        $acc = app(\App\Services\AccountingService::class);

                        $cabangId  = $from->cabang_id ?? $to->cabang_id;
                        $cashAccId = (int) setting('acc.cash_id');   // Kas
                        $bankAccId = (int) setting('acc.bank_id');   // Bank

                        // contoh sederhana: treat move ini sebagai setoran Kas -> Bank
                        if ($cashAccId && $bankAccId) {
                            $acc->upsertDraft([
                                'cabang_id'    => (int) $cabangId,
                                'journal_date' => optional($move->approved_at)->toDateString() ?? now()->toDateString(),
                                'number'       => 'CASH-MOVE-' . $move->id, // unik per cabang (sesuai migrasi)
                                'description'  => 'Cash move #' . $move->id . ' (' . ($from->name ?? 'from') . ' → ' . ($to->name ?? 'to') . ')',
                                'lines'        => [
                                    ['account_id' => $bankAccId, 'debit' => (float) $move->amount, 'credit' => 0, 'ref_type' => 'CASH_MOVE', 'ref_id' => $move->id],
                                    ['account_id' => $cashAccId, 'debit' => 0, 'credit' => (float) $move->amount, 'ref_type' => 'CASH_MOVE', 'ref_id' => $move->id],
                                ],
                            ]);
                        }
                    }
                } catch (\Throwable $e) {
                    report($e);
                }
            });
            // === END ACCOUNTING HOOK ===

            return $move;
        });
    }

    public function rejectMove(CashMove $move, string $reason, int $approverId): CashMove
    {
        return DB::transaction(function () use ($move, $reason, $approverId) {
            $move->refresh();
            if ($move->status !== 'SUBMITTED') {
                throw new \RuntimeException('Move must be SUBMITTED');
            }
            $move->status = 'REJECTED';
            $move->approved_by = $approverId;
            $move->rejected_at = now();
            $move->reject_reason = $reason;
            $move->save();
            $this->audit('REJECT', 'cash_moves', $move->id, ['after' => $move->only(['status', 'reject_reason'])]);
            return $move;
        });
    }

    public function mirrorPaymentToHolder(int $holderId, float $amount, int $paymentId, string $note = ''): void
    {
        DB::transaction(function () use ($holderId, $amount, $paymentId, $note) {
            // Cek idempoten: jika sudah pernah mirror untuk payment ini, abaikan
            $exists = DB::table('audit_logs')
                ->where('action', 'CASH_MIRROR')
                ->where('model', 'payments')
                ->where('model_id', $paymentId)
                ->exists();
            if ($exists) {
                return;
            }

            /** @var \App\Models\CashHolder $holder */
            $holder = CashHolder::lockForUpdate()->findOrFail($holderId);
            $before = (string) $holder->balance;
            $holder->balance = number_format(
                round(((float) $holder->balance) + (float) $amount, 2),
                2,
                '.',
                ''
            );
            $holder->save();

            // Audit log sebagai jejak & kunci idempoten
            DB::table('audit_logs')->insert([
                'actor_type' => 'USER',
                'actor_id'   => Auth::id(),
                'action'     => 'CASH_MIRROR',
                'model'      => 'payments',
                'model_id'   => $paymentId,
                'diff_json'  => json_encode([
                    'holder_id' => $holderId,
                    'amount'    => $amount,
                    'note'      => $note,
                    'before'    => $before,
                    'after'     => $holder->balance,
                ]),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        });
    }

    public function getOrOpenSessionForHolder(int $holderId): CashSession
    {
        return DB::transaction(function () use ($holderId) {
            /** @var \App\Models\CashSession|null $open */
            $open = CashSession::lockForUpdate()
                ->where('holder_id', $holderId)
                ->where('status', 'OPEN')
                ->latest('id')
                ->first();

            if ($open) {
                return $open;
            }

            $session = new CashSession([
                'holder_id' => $holderId,
                'status'    => 'OPEN',
                'opened_at' => now(),
                'opened_by' => Auth::id(),
            ]);
            $session->save();

            // audit
            $this->audit('OPEN_SESSION', 'cash_sessions', $session->id, [
                'after' => $session->toArray(),
            ]);

            return $session;
        });
    }

    // Mirror payment (CASH) to active cash session
    public function mirrorPaymentToSession(CashSession $session, float $amount, string $refType, int $refId, ?string $note = null, ?int $holderId = null): CashTransaction
    {
        return DB::transaction(function () use ($session, $amount, $refType, $refId, $note, $holderId) {
            $tx = new CashTransaction([
                'session_id'  => $session->id,
                'type'        => 'IN',
                'amount'      => $amount,
                'source'      => 'ORDER',
                'ref_type'    => $refType,
                'ref_id'      => $refId,
                'note'        => $note,
                'occurred_at' => now(),
            ]);
            $tx->save();
            $this->audit('LOG_CASH', 'cash_transactions', $tx->id, ['after' => $tx->toArray()]);

            if ($holderId) {
                /** @var \App\Models\CashHolder $holder */
                $holder = \App\Models\CashHolder::lockForUpdate()->findOrFail($holderId);
                $before = $holder->balance;
                $holder->balance = number_format(
                    round(((float)$holder->balance) + (float)$amount, 2),
                    2,
                    '.',
                    ''
                );
                $holder->save();
                $this->audit('CASH_IN_HOLDER', 'cash_holders', $holder->id, [
                    'before' => ['balance' => $before],
                    'after' => ['balance' => $holder->balance],
                    'ref'   => ['type' => $refType, 'id' => $refId],
                ]);
            }
            return $tx;
        });
    }

    private function audit(string $action, string $model, int $modelId, array $diff): void
    {
        DB::table('audit_logs')->insert([
            'actor_type' => 'USER',
            'actor_id'   => Auth::id(),
            'action'     => $action,
            'model'      => $model,
            'model_id'   => $modelId,
            'diff_json'  => json_encode($diff),
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }
}
