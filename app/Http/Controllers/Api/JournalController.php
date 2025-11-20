<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\{JournalStoreRequest, JournalUpdateRequest, JournalPostRequest};
use App\Models\JournalEntry;
use App\Services\AccountingService;
use Illuminate\Http\Request;

class JournalController extends Controller
{
    public function __construct(private readonly AccountingService $svc) {}

    public function index(Request $r)
    {
        $this->authorize('viewAny', JournalEntry::class);
        $q = JournalEntry::query()
            ->when($r->filled('cabang_id'), fn($x) => $x->where('cabang_id', $r->integer('cabang_id')))
            ->when($r->filled('status'), fn($x) => $x->where('status', $r->string('status')))
            ->when($r->filled('from'), fn($x) => $x->whereDate('journal_date', '>=', $r->date('from')))
            ->when($r->filled('to'), fn($x) => $x->whereDate('journal_date', '<=', $r->date('to')))
            ->orderByDesc('journal_date')->orderBy('number');

        return response()->json(['data' => $q->paginate(20), 'meta' => [], 'message' => 'OK', 'errors' => []]);
        // catatan: bisa ditambah filter by account_id via join journal_lines bila diperlukan
    }

    public function store(JournalStoreRequest $req)
    {
        $this->authorize('create', JournalEntry::class);
        $entry = $this->svc->upsertDraft($req->validated());
        return response()->json(['data' => $entry->load('lines'), 'meta' => [], 'message' => 'Saved DRAFT', 'errors' => []], 201);
    }

    public function update(JournalUpdateRequest $req, JournalEntry $journal)
    {
        $this->authorize('update', $journal);
        $payload = array_merge(['cabang_id' => $journal->cabang_id, 'number' => $journal->number], $req->validated());
        $payload['journal_date'] = $req->validated()['journal_date'] ?? $journal->journal_date;
        $entry = $this->svc->upsertDraft($payload);
        return response()->json(['data' => $entry->load('lines'), 'meta' => [], 'message' => 'Updated DRAFT', 'errors' => []]);
    }

    public function post(JournalPostRequest $req, JournalEntry $journal)
    {
        $this->authorize('post', $journal);
        $entry = $this->svc->post($journal, $req->string('idempotency_key')->toString());
        return response()->json(['data' => $entry->load('lines'), 'meta' => [], 'message' => 'POSTED', 'errors' => []]);
    }

    public function destroy(JournalEntry $journal)
    {
        $this->authorize('delete', $journal);
        $journal->delete();
        return response()->json(['data' => null, 'meta' => [], 'message' => 'Deleted', 'errors' => []]);
    }
}
