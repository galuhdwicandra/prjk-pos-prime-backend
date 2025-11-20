<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Customer\CustomerStoreRequest;
use App\Http\Requests\Customer\CustomerUpdateRequest;
use App\Models\Customer;
use App\Services\CustomerService;
use Illuminate\Http\Request;

class CustomersController extends Controller
{
    public function __construct(private readonly CustomerService $svc) {}

    public function index(Request $req)
    {
        $this->authorize('viewAny', Customer::class);
        $cabangId = $this->resolveCabangId($req);

        $data = $this->svc->list($cabangId, [
            'q'        => $req->query('q'),
            'stage'    => $req->query('stage'),
            'from'     => $req->query('from'),
            'to'       => $req->query('to'),
            'per_page' => $req->integer('per_page', 15),
        ]);

        return response()->json($data);
        // Note: if you use a Resource, adapt accordingly.
    }

    public function show(Request $req, Customer $customer)
    {
        $this->authorize('view', $customer);
        return response()->json($this->svc->detail($customer));
    }

    public function store(CustomerStoreRequest $req)
    {
        $cabangId = $this->resolveCabangId($req);
        $this->authorize('create', Customer::class);

        $customer = $this->svc->upsertByPhone($cabangId, $req->validated());
        return response()->json($customer, 201);
    }

    public function update(CustomerUpdateRequest $req, Customer $customer)
    {
        $this->authorize('update', $customer);

        $customer->fill($req->validated())->save();
        return response()->json($customer->refresh());
    }

    public function destroy(Request $req, Customer $customer)
    {
        $this->authorize('delete', $customer);
        $customer->delete(); // SOP says hard-delete OK unless you prefer soft delete
        return response()->json(['ok' => true]);
    }

    public function history(Request $req, Customer $customer)
    {
        $this->authorize('view', $customer);
        $limit = $req->integer('limit', 20);
        $detail = $this->svc->detail($customer, $limit);
        $detail['timelines'] = $customer->timelines()->orderByDesc('happened_at')->limit($limit)->get();
        return response()->json($detail);
    }

    public function setStage(Request $req, Customer $customer)
    {
        $this->authorize('update', $customer);
        $req->validate(['stage' => 'required|in:LEAD,ACTIVE,CHURN']);
        $updated = $this->svc->setStage($customer, $req->string('stage'));
        return response()->json($updated);
    }

    private function resolveCabangId(Request $req): int
    {
        $user = $req->user();
        // Kasir & Sales: wajib cabang user (branch-scoped)
        if ($user->hasRole(['kasir', 'sales'])) {
            if (!$user->cabang_id) {
                abort(422, 'User tidak memiliki cabang_id; hubungi admin.');
            }
            return (int) $user->cabang_id;
        }
        // Superadmin/Admin Cabang: boleh pilih via input, fallback ke cabang user bila ada
        $fromInput = $req->integer('cabang_id');
        if ($fromInput) {
            return $fromInput;
        }
        if ($user->cabang_id) {
            return (int) $user->cabang_id;
        }
        // Jika superadmin tanpa cabang & tanpa input: ini keputusan bisnis → izinkan 0/semua atau hard fail.
        abort(422, 'Mohon tentukan cabang_id.');
    }
}
