<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\{CashMoveStoreRequest, CashMoveApproveRequest, CashMoveRejectRequest, CashHolderStoreRequest};
use App\Models\{CashHolder, CashMove};
use App\Services\CashService;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class CashController extends Controller
{
    public function __construct(private CashService $svc) {}

    // GET /api/v1/cash/holders
    public function holders(Request $r): JsonResponse
    {
        $this->authorize('viewAny', CashHolder::class);
        $q = CashHolder::query()
            ->when($r->filled('cabang_id'), fn($qq) => $qq->where('cabang_id', $r->integer('cabang_id')));
        // scope by branch unless superadmin handled in global scopes/Policies (kept simple here)
        return response()->json($q->orderBy('name')->paginate((int)$r->input('per_page', 15)));
    }

    public function storeHolder(CashHolderStoreRequest $req): JsonResponse
    {
        $this->authorize('create', CashHolder::class);
        $data = $req->validated();
        $holder = new CashHolder([
            'cabang_id' => $data['cabang_id'],
            'name'      => $data['name'],
            'balance'   => $data['opening_balance'] ?? 0,
        ]);
        $holder->save();
        return response()->json($holder, 201);
    }

    // GET /api/v1/cash/moves
    public function moves(Request $r): JsonResponse
    {
        $q = CashMove::query()
            ->with(['from', 'to', 'submitter', 'approver'])
            ->when($r->filled('status'), fn($qq) => $qq->where('status', $r->string('status')))
            ->orderByDesc('id');
        $this->authorize('viewAny', CashMove::class);
        return response()->json($q->paginate((int)$r->input('per_page', 15)));
    }

    // POST /api/v1/cash/moves (submit)
    public function store(CashMoveStoreRequest $req): JsonResponse
    {
        $this->authorize('create', CashMove::class);
        $move = $this->svc->submitMove($req->validated(), $req->user()->id);
        return response()->json($move, 201);
    }

    // POST /api/v1/cash/moves/{move}/approve
    public function approve(CashMoveApproveRequest $req, CashMove $move): JsonResponse
    {
        $this->authorize('approve', $move);
        $approved = $this->svc->approveMove($move, $req->input('approved_at'), $req->user()->id);
        return response()->json($approved);
    }

    // POST /api/v1/cash/moves/{move}/reject
    public function reject(CashMoveRejectRequest $req, CashMove $move): JsonResponse
    {
        $this->authorize('reject', $move);
        $rejected = $this->svc->rejectMove($move, $req->string('reason')->toString(), $req->user()->id);
        return response()->json($rejected);
    }

    // DELETE /api/v1/cash/moves/{move}
    public function destroy(Request $req, CashMove $move): JsonResponse
    {
        $this->authorize('delete', $move);
        $move->delete();
        return response()->json(['message' => 'Deleted']);
    }
}
