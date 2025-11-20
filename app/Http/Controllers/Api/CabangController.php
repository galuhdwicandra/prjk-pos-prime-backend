<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\CabangStoreRequest;
use App\Http\Requests\CabangUpdateRequest;
use App\Models\Cabang;
use App\Services\CabangService;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class CabangController extends Controller
{
    public function __construct(private CabangService $service) {}

    public function index(Request $request): JsonResponse
    {
        $this->authorize('viewAny', Cabang::class);

        $q        = $request->string('q')->toString();
        $kota     = $request->string('kota')->toString();
        $isActive = $request->has('is_active') ? filter_var($request->input('is_active'), FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE) : null;
        $perPage  = (int)($request->input('per_page', 10));
        $sort     = $request->input('sort', '-id'); // default: terbaru

        $query = $this->service->queryIndexForUser($request->user())
            ->when($q !== '', fn($qr) => $qr->where(function($w) use ($q) {
                $w->where('nama', 'like', "%{$q}%")
                  ->orWhere('kota', 'like', "%{$q}%")
                  ->orWhere('alamat', 'like', "%{$q}%");
            }))
            ->when($kota !== '', fn($qr) => $qr->where('kota', $kota))
            ->when(!is_null($isActive), fn($qr) => $qr->where('is_active', $isActive));

        // Sorting: "field" atau "-field" (desc)
        if (is_string($sort) && $sort !== '') {
            $direction = str_starts_with($sort, '-') ? 'desc' : 'asc';
            $field = ltrim($sort, '-');
            in_array($field, ['id','nama','kota','is_active','created_at']) || $field = 'id';
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

    public function store(CabangStoreRequest $request): JsonResponse
    {
        $this->authorize('create', Cabang::class);
        $cabang = $this->service->create($request->validated());
        return response()->json([
            'success' => true,
            'data' => $cabang,
        ], 201);
    }

    public function show(Request $request, Cabang $cabang): JsonResponse
    {
        $this->authorize('view', $cabang);
        return response()->json([
            'success' => true,
            'data' => $cabang->load('gudangs'),
        ]);
    }

    public function update(CabangUpdateRequest $request, Cabang $cabang): JsonResponse
    {
        $this->authorize('update', $cabang);
        $cabang = $this->service->update($cabang, $request->validated());
        return response()->json([
            'success' => true,
            'data' => $cabang,
        ]);
    }

    public function destroy(Request $request, Cabang $cabang): JsonResponse
    {
        $this->authorize('delete', $cabang);
        $this->service->delete($cabang);
        return response()->json([
            'success' => true,
        ], 204);
    }
}
