<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\AccountingService;
use Illuminate\Http\Request;

class AccountingReportController extends Controller
{
    public function __construct(private readonly AccountingService $svc) {}

    public function trialBalance(Request $r)
    {
        $this->authorize('viewAny', \App\Models\JournalEntry::class);
        $rows = $this->svc->trialBalance($r->integer('cabang_id'), $r->integer('year'), $r->integer('month'));
        return response()->json(['data' => $rows, 'meta' => [], 'message' => 'OK', 'errors' => []]);
    }

    public function generalLedger(Request $r)
    {
        $this->authorize('viewAny', \App\Models\JournalEntry::class);
        $rows = $this->svc->generalLedger($r->integer('cabang_id'), $r->integer('account_id'), $r->integer('year'), $r->integer('month'));
        return response()->json(['data' => $rows, 'meta' => [], 'message' => 'OK', 'errors' => []]);
    }

    public function profitLoss(Request $r)
    {
        $this->authorize('viewAny', \App\Models\JournalEntry::class);
        $rows = $this->svc->profitLoss($r->integer('cabang_id'), $r->integer('year'), $r->integer('month'));
        return response()->json(['data' => $rows, 'meta' => [], 'message' => 'OK', 'errors' => []]);
    }

    public function balanceSheet(Request $r)
    {
        $this->authorize('viewAny', \App\Models\JournalEntry::class);
        $rows = $this->svc->balanceSheet($r->integer('cabang_id'), $r->integer('year'), $r->integer('month'));
        return response()->json(['data' => $rows, 'meta' => [], 'message' => 'OK', 'errors' => []]);
    }
}
