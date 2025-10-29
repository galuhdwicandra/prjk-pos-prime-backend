<?php

namespace App\Services;

use App\Models\{Account, FiscalPeriod, JournalEntry, JournalLine};
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class AccountingService
{
    /**
     * Create/Update Journal in DRAFT.
     */
    public function upsertDraft(array $payload): JournalEntry
    {
        return DB::transaction(function () use ($payload) {
            $periodYear  = (int) date('Y', strtotime($payload['journal_date']));
            $periodMonth = (int) date('n', strtotime($payload['journal_date']));

            // Guard periode CLOSED
            $fp = FiscalPeriod::query()
                ->where('cabang_id', $payload['cabang_id'])
                ->where('year', $periodYear)->where('month', $periodMonth)
                ->first();
            if ($fp && $fp->status === 'CLOSED') {
                throw new \DomainException('Periode telah ditutup.');
            }

            // Upsert header berdasar (cabang, number)
            $entry = JournalEntry::query()
                ->firstOrNew(['cabang_id' => $payload['cabang_id'], 'number' => $payload['number']]);
            $entry->fill([
                'journal_date' => $payload['journal_date'],
                'description'  => $payload['description'] ?? null,
                'status'       => 'DRAFT',
                'period_year'  => $periodYear,
                'period_month' => $periodMonth,
            ]);
            $entry->save();

            // Reset lines lalu isi ulang
            $entry->lines()->delete();

            $sumDebit = 0;
            $sumCredit = 0;
            foreach ($payload['lines'] as $i => $line) {
                /** @var Account $acc */
                $acc = Account::query()->whereKey($line['account_id'])->first();
                if (!$acc || !$acc->is_active) {
                    throw new \InvalidArgumentException("Akun tidak aktif/invalid pada baris #" . ($i + 1));
                }

                $debit  = (float) ($line['debit']  ?? 0);
                $credit = (float) ($line['credit'] ?? 0);
                if ($debit < 0 || $credit < 0) {
                    throw new \InvalidArgumentException("Nilai negatif tidak diperbolehkan (#" . ($i + 1) . ")");
                }

                $sumDebit  += $debit;
                $sumCredit += $credit;

                $entry->lines()->create([
                    'account_id' => $acc->id,
                    'cabang_id'  => $payload['cabang_id'],
                    'debit'      => $debit,
                    'credit'     => $credit,
                    'ref_type'   => $line['ref_type'] ?? null,
                    'ref_id'     => $line['ref_id'] ?? null,
                ]);
            }

            if (round($sumDebit, 2) !== round($sumCredit, 2)) {
                throw new \InvalidArgumentException('Jurnal tidak seimbang (Σ debit ≠ Σ credit).');
            }

            return $entry->refresh();
        });
    }

    /**
     * Post DRAFT → POSTED (idempotent by (cabang, number)).
     */
    public function post(JournalEntry $entry, ?string $key = null): JournalEntry
    {
        return DB::transaction(function () use ($entry, $key) {
            if ($entry->status === 'POSTED') {
                return $entry; // idempotent
            }

            // Guard periode
            $fp = FiscalPeriod::query()
                ->where('cabang_id', $entry->cabang_id)
                ->where('year', $entry->period_year)
                ->where('month', $entry->period_month)
                ->first();
            if ($fp && $fp->status === 'CLOSED') {
                throw new \DomainException('Periode telah ditutup.');
            }

            // Validasi double-entry
            $sum = $entry->lines()
                ->selectRaw('COALESCE(SUM(debit),0) as d, COALESCE(SUM(credit),0) as c')->first();
            if (round($sum->d, 2) !== round($sum->c, 2)) {
                throw new \InvalidArgumentException('Jurnal tidak seimbang.');
            }

            $entry->status = 'POSTED';
            $entry->save();

            // Audit
            DB::table('audit_logs')->insert([
                'actor_type' => 'USER',
                'actor_id'   => Auth::id(),
                'action'     => 'JOURNAL_POSTED',
                'model'      => 'JournalEntry',
                'model_id'   => $entry->id,
                'diff_json'  => json_encode(['number' => $entry->number, 'posted_at' => now()->toDateTimeString()]),
                'created_at' => now(),
                'updated_at' => now(),
                'occurred_at' => now(),
            ]);

            return $entry->refresh();
        });
    }

    public function openPeriod(int $cabangId, int $year, int $month): FiscalPeriod
    {
        return DB::transaction(function () use ($cabangId, $year, $month) {
            $fp = FiscalPeriod::firstOrCreate(
                ['cabang_id' => $cabangId, 'year' => $year, 'month' => $month],
                ['status' => 'OPEN']
            );
            if ($fp->status !== 'OPEN') {
                $fp->status = 'OPEN';
                $fp->save();
            }
            return $fp->refresh();
        });
    }

    public function closePeriod(int $cabangId, int $year, int $month): FiscalPeriod
    {
        return DB::transaction(function () use ($cabangId, $year, $month) {
            $fp = FiscalPeriod::firstOrCreate(
                ['cabang_id' => $cabangId, 'year' => $year, 'month' => $month],
                ['status' => 'OPEN']
            );
            $fp->status = 'CLOSED';
            $fp->save();
            return $fp->refresh();
        });
    }

    /** Reports */
    public function trialBalance(int $cabangId, int $year, int $month): array
    {
        // agregasi cepat per akun pada periode (termasuk saldo <= tanggal akhir)
        $rows = DB::table('journal_lines as jl')
            ->join('journal_entries as je', 'je.id', '=', 'jl.journal_id')
            ->join('accounts as a', 'a.id', '=', 'jl.account_id')
            ->where('jl.cabang_id', $cabangId)
            ->where('je.period_year', $year)
            ->where('je.period_month', $month)
            ->where('je.status', 'POSTED')
            ->groupBy('a.id', 'a.code', 'a.name', 'a.type', 'a.normal_balance')
            ->selectRaw('a.id,a.code,a.name,a.type,a.normal_balance, SUM(jl.debit) as debit, SUM(jl.credit) as credit')
            ->orderBy('a.code')
            ->get()->all();

        return $rows;
    }

    public function generalLedger(int $cabangId, int $accountId, int $year, int $month): array
    {
        $rows = DB::table('journal_lines as jl')
            ->join('journal_entries as je', 'je.id', '=', 'jl.journal_id')
            ->where('jl.cabang_id', $cabangId)
            ->where('jl.account_id', $accountId)
            ->where('je.period_year', $year)
            ->where('je.period_month', $month)
            ->where('je.status', 'POSTED')
            ->orderBy('je.journal_date')
            ->select('je.number', 'je.journal_date', 'jl.debit', 'jl.credit', 'jl.ref_type', 'jl.ref_id')
            ->get()->all();
        return $rows;
    }

    public function profitLoss(int $cabangId, int $year, int $month): array
    {
        $rows = DB::table('journal_lines as jl')
            ->join('journal_entries as je', 'je.id', '=', 'jl.journal_id')
            ->join('accounts as a', 'a.id', '=', 'jl.account_id')
            ->where('jl.cabang_id', $cabangId)
            ->where('je.period_year', $year)
            ->where('je.period_month', $month)
            ->where('je.status', 'POSTED')
            ->whereIn('a.type', ['Revenue', 'Expense'])
            ->groupBy('a.type')
            ->selectRaw("a.type, SUM(jl.debit) as debit, SUM(jl.credit) as credit")
            ->get()->keyBy('type')->all();

        return $rows;
    }

    public function balanceSheet(int $cabangId, int $year, int $month): array
    {
        $rows = DB::table('journal_lines as jl')
            ->join('journal_entries as je', 'je.id', '=', 'jl.journal_id')
            ->join('accounts as a', 'a.id', '=', 'jl.account_id')
            ->where('jl.cabang_id', $cabangId)
            ->where('je.period_year', $year)
            ->where('je.period_month', $month)
            ->where('je.status', 'POSTED')
            ->whereIn('a.type', ['Asset', 'Liability', 'Equity'])
            ->groupBy('a.type')
            ->selectRaw("a.type, SUM(jl.debit) as debit, SUM(jl.credit) as credit")
            ->get()->keyBy('type')->all();

        return $rows;
    }
}
