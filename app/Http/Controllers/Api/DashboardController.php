<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Dashboard\CommonQuery;
use App\Services\DashboardService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class DashboardController extends Controller
{
    public function __construct(private DashboardService $svc) {}

    private function ok($data, $meta = [], $message = 'OK')
    {
        return response()->json([
            'data' => $data,
            'meta' => $meta,
            'message' => $message,
            'errors' => (object) [],
        ]);
    }

    public function kpis(CommonQuery $rq)
    {
        Gate::authorize('view', 'dashboard');
        [$from, $to] = $rq->dateRange();
        $cabangId = $rq->branchIdOrUser(); // still reading "branch_id" from query param
        $out = $this->svc->kpis($cabangId, $from, $to);

        $this->auditView('dashboard.kpis', ['cabang_id' => $cabangId, 'from' => $from, 'to' => $to]);
        return $this->ok($out, ['from' => $from->toDateTimeString(), 'to' => $to->toDateTimeString()]);
    }

    public function chart7d(Request $rq)
    {
        Gate::authorize('view', 'dashboard');
        $cabangId = $rq->integer('cabang_id')
            ?: $rq->integer('branch_id')
            ?: ($rq->user()->cabang_id ?? null);
        $out = $this->svc->chart7d($cabangId);

        $this->auditView('dashboard.chart7d', ['cabang_id' => $cabangId]);
        return $this->ok($out);
    }

    public function topProducts(CommonQuery $rq)
    {
        Gate::authorize('view', 'dashboard');
        $cabangId = $rq->branchIdOrUser();
        $limit = (int) ($rq->integer('limit') ?? 5);
        $out = $this->svc->topProducts($cabangId, $limit);

        $this->auditView('dashboard.topProducts', ['cabang_id' => $cabangId, 'limit' => $limit]);
        return $this->ok($out, ['limit' => $limit]);
    }

    public function lowStock(CommonQuery $rq)
    {
        Gate::authorize('view', 'dashboard');
        $cabangId = $rq->branchIdOrUser();
        $threshold = $rq->input('threshold') !== null ? (float) $rq->input('threshold') : null;
        $out = $this->svc->lowStock($cabangId, $threshold);

        $this->auditView('dashboard.lowStock', ['cabang_id' => $cabangId, 'threshold' => $threshold]);
        return $this->ok($out, ['threshold' => $threshold]);
    }

    public function quickActions(Request $rq)
    {
        Gate::authorize('view', 'dashboard');
        $cabangId = $rq->integer('branch_id') ?: ($rq->user()->cabang_id ?? null);
        $out = $this->svc->quickActions($cabangId);

        $this->auditView('dashboard.quickActions', ['cabang_id' => $cabangId]);
        return $this->ok($out);
    }

    private function auditView(string $action, array $meta = []): void
    {
        try {
            DB::table('audit_logs')->insert([
                'actor_type' => 'USER',
                'actor_id'   => Auth::id(),
                'action'     => strtoupper($action),
                'model'      => 'dashboard',
                'model_id'   => 0,
                'diff_json'  => json_encode($meta),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        } catch (\Throwable $e) {
            // ignore audit failures for reads
        }
    }
}
