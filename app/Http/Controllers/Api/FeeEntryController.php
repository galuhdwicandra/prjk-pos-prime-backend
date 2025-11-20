<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\FeeEntryIndexRequest;
use App\Http\Requests\FeeEntryPayRequest;
use App\Models\FeeEntry;
use App\Services\FeeService;
use Illuminate\Http\Request;

class FeeEntryController extends Controller
{
    public function __construct(private FeeService $fees) {}

    public function index(FeeEntryIndexRequest $req)
    {
        $this->authorize('viewAny', FeeEntry::class);
        $data = $this->fees->listEntries($req->user(), $req->validated());
        return response()->json($data);
    }

    public function export(FeeEntryIndexRequest $req)
    {
        $this->authorize('export', FeeEntry::class);
        return $this->fees->exportCsv($req->user(), $req->validated());
    }

    public function pay(FeeEntryPayRequest $req)
    {
        $entryIds = $req->validated('entry_ids');
        $status   = $req->validated('status');
        $paidAmt  = (string) ($req->validated()['paid_amount'] ?? '0');
        $paidAt   = $req->validated()['paid_at'] ?? null;

        // policy per-entry (simple check using first entry)
        $first = FeeEntry::findOrFail($entryIds[0]);
        $this->authorize('updateStatus', $first);

        $count = $this->fees->markPaid($entryIds, $status, $paidAmt, $paidAt);
        return response()->json(['updated' => $count]);
    }
}
