<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\GudangStoreRequest;
use App\Http\Requests\GudangUpdateRequest;
use App\Models\Gudang;
use App\Services\GudangService;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class GudangController extends Controller
{
    public function __construct(private GudangService $service) {}

    public function index(Request $request): JsonResponse
    {
        $this->authorize('viewAny', Gudang::class);

        $q        = $request->string('q')->toString();
        $cabangId = $request->input('cabang_id');
        $isActive = $request->has('is_active') ? filter_var($request->input('is_active'), FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE) : null;
        $perPage  = (int)($request->input('per_page', 10));
        $sort     = $request->input('sort', '-id');

        $query = $this->service->queryIndexForUser($request->user())
            ->when($q !== '', fn($qr) => $qr->where('nama', 'like', "%{$q}%"))
            ->when($cabangId, fn($qr) => $qr->where('cabang_id', $cabangId))
            ->when(!is_null($isActive), fn($qr) => $qr->where('is_active', $isActive));

        if (is_string($sort) && $sort !== '') {
            $direction = str_starts_with($sort, '-') ? 'desc' : 'asc';
            $field = ltrim($sort, '-');
            in_array($field, ['id','cabang_id','nama','is_default','is_active','created_at']) || $field = 'id';
            $query->orderBy($field, $direction);
        }

        $paginator = $query->paginate($perPage);
        return response()->json([
            'success' => true,
            'data' => $paginator->items(),
            'meta' => [
                'current_page' => $paginator->currentPage(),
                'per_page'     => $paginator->perPage(),
                'total'        => $paginator->total(),
                'last_page'    => $paginator->lastPage(),
            ],
        ]);
    }

    public function store(GudangStoreRequest $request): JsonResponse
    {
        $this->authorize('create', Gudang::class);
        $gudang = $this->service->create($request->validated(), $request->user());
        return response()->json([
            'success' => true,
            'data' => $gudang,
        ], 201);
    }

    public function show(Request $request, Gudang $gudang): JsonResponse
    {
        $this->authorize('view', $gudang);
        return response()->json([
            'success' => true,
            'data' => $gudang->load('cabang'),
        ]);
    }

    public function update(GudangUpdateRequest $request, Gudang $gudang): JsonResponse
    {
        $this->authorize('update', $gudang);
        $gudang = $this->service->update($gudang, $request->validated(), $request->user());
        return response()->json([
            'success' => true,
            'data' => $gudang,
        ]);
    }

    public function destroy(Request $request, Gudang $gudang): JsonResponse
    {
        $this->authorize('delete', $gudang);
        $this->service->delete($gudang, $request->user());
        return response()->json([
            'success' => true,
        ], 204);
    }
}
