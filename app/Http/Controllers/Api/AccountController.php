<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\{AccountStoreRequest, AccountUpdateRequest};
use App\Models\Account;
use Illuminate\Http\Request;

class AccountController extends Controller
{
    public function index(Request $r)
    {
        $this->authorize('viewAny', Account::class);
        $q = Account::query()
            ->when($r->filled('cabang_id'), fn($x) => $x->where('cabang_id', $r->integer('cabang_id')))
            ->when($r->boolean('only_active', false), fn($x) => $x->where('is_active', true))
            ->orderBy('code');
        return response()->json(['data' => $q->get(), 'meta' => [], 'message' => 'OK', 'errors' => []]);
    }

    public function store(AccountStoreRequest $req)
    {
        $this->authorize('create', Account::class);
        $acc = Account::create($req->validated());
        return response()->json(['data' => $acc, 'meta' => [], 'message' => 'Created', 'errors' => []], 201);
    }

    public function update(AccountUpdateRequest $req, Account $account)
    {
        $this->authorize('update', $account);
        $account->update($req->validated());
        return response()->json(['data' => $account->refresh(), 'meta' => [], 'message' => 'Updated', 'errors' => []]);
    }

    public function destroy(Account $account)
    {
        $this->authorize('delete', $account);
        $account->delete();
        return response()->json(['data' => null, 'meta' => [], 'message' => 'Deleted', 'errors' => []]);
    }
}
