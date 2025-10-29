<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\FeeStoreRequest;
use App\Http\Requests\FeeUpdateRequest;
use App\Http\Resources\FeeResource;
use App\Models\Fee;
use App\Services\FeeService;
use Illuminate\Http\Request;

class FeeController extends Controller
{
    /** @var FeeService */
    protected FeeService $service;

    public function __construct(FeeService $service)
    {
        $this->service = $service;
    }

    public function index(Request $request)
    {
        $this->authorize('viewAny', Fee::class);

        $filters = [
            'cabang_id' => $request->integer('cabang_id'),
            'kind'      => $request->string('kind')->toString() ?: null,
            'base'      => $request->string('base')->toString() ?: null,
            'is_active' => $request->has('is_active') ? $request->boolean('is_active') : null,
            'q'         => $request->string('q')->toString() ?: null,
            'sort'      => $request->string('sort')->toString() ?: null,
        ];

        $perPage   = min(max($request->integer('per_page', 15), 5), 100);
        $paginator = $this->service->paginate($filters, $perPage);

        return FeeResource::collection($paginator)->additional([
            'meta' => [
                'current_page' => $paginator->currentPage(),
                'per_page'     => $paginator->perPage(),
                'total'        => $paginator->total(),
                'last_page'    => $paginator->lastPage(),
            ],
        ]);
    }

    public function show(Fee $fee)
    {
        $this->authorize('view', $fee);
        return new FeeResource($fee);
    }

    public function store(FeeStoreRequest $request)
    {
        $this->authorize('create', Fee::class);
        $fee = $this->service->create($request->validated());
        return (new FeeResource($fee))
            ->additional(['message' => 'Fee created'])
            ->response()
            ->setStatusCode(201);
    }

    public function update(FeeUpdateRequest $request, Fee $fee)
    {
        $this->authorize('update', $fee);
        $fee = $this->service->update($fee, $request->validated());
        return (new FeeResource($fee))
            ->additional(['message' => 'Fee updated']);
    }

    public function destroy(Fee $fee)
    {
        $this->authorize('delete', $fee);
        $this->service->delete($fee);
        return response()->json(['message' => 'Fee deleted']);
    }
}
