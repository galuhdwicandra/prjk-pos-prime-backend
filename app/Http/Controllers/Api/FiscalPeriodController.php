<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\PeriodCloseRequest;
use App\Models\FiscalPeriod;
use App\Policies\FiscalPeriodPolicy;
use App\Services\AccountingService;
use Illuminate\Http\Request;

class FiscalPeriodController extends Controller
{
    public function __construct(private readonly AccountingService $svc) {}

    public function index(Request $r)
    {
        $this->authorize('viewAny', FiscalPeriod::class);
        $q = FiscalPeriod::query()
            ->when($r->filled('cabang_id'), fn($x) => $x->where('cabang_id', $r->integer('cabang_id')))
            ->orderByDesc('year')->orderByDesc('month');
        return response()->json(['data' => $q->get(), 'meta' => [], 'message' => 'OK', 'errors' => []]);
    }

    public function open(PeriodCloseRequest $req)
    {
        $this->authorize('open', FiscalPeriod::class);
        $fp = $this->svc->openPeriod($req->integer('cabang_id'), $req->integer('year'), $req->integer('month'));
        return response()->json(['data' => $fp, 'meta' => [], 'message' => 'OPEN', 'errors' => []]);
    }

    public function close(PeriodCloseRequest $req)
    {
        // authorize on class; additional guard happens in service
        $this->authorize('open', FiscalPeriod::class);
        $fp = $this->svc->closePeriod($req->integer('cabang_id'), $req->integer('year'), $req->integer('month'));
        return response()->json(['data' => $fp, 'meta' => [], 'message' => 'CLOSED', 'errors' => []]);
    }
}
