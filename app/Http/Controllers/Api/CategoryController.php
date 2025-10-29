<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Category\IndexCategoryRequest;
use App\Http\Requests\Category\StoreCategoryRequest;
use App\Http\Requests\Category\UpdateCategoryRequest;
use App\Models\Category;
use App\Services\CategoryService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    public function __construct(private CategoryService $service) {}

    public function index(IndexCategoryRequest $request): JsonResponse
    {
        $this->authorize('viewAny', Category::class);

        [$col, $dir] = $request->sort();
        $paginator = $this->service->paginate([
            'q'        => $request->input('q'),
            'is_active'=> $request->input('is_active'),
            'per_page' => $request->perPage(),
            'sort'     => [$col, $dir],
        ]);

        return response()->json([
            'success' => true,
            'data'    => $paginator->items(),
            'meta'    => [
                'current_page' => $paginator->currentPage(),
                'per_page'     => $paginator->perPage(),
                'total'        => $paginator->total(),
                'last_page'    => $paginator->lastPage(),
            ],
        ]);
    }

    public function store(StoreCategoryRequest $request): JsonResponse
    {
        $this->authorize('create', Category::class);

        $category = $this->service->create($request->payload());

        return response()->json([
            'success' => true,
            'data'    => $category,
            'message' => 'Kategori berhasil dibuat',
        ], 201);
    }

    public function show(Request $request, Category $category): JsonResponse
    {
        $this->authorize('view', $category);

        return response()->json([
            'success' => true,
            'data'    => $category, // bisa ->loadCount('products') nanti
        ]);
    }

    public function update(UpdateCategoryRequest $request, Category $category): JsonResponse
    {
        $this->authorize('update', $category);

        $category = $this->service->update($category, $request->payload());

        return response()->json([
            'success' => true,
            'data'    => $category,
            'message' => 'Kategori berhasil diupdate',
        ]);
    }

    public function destroy(Request $request, Category $category): JsonResponse
    {
        $this->authorize('delete', $category);

        // Catatan: ketika relasi produk sudah aktif, service akan cegah hapus jika masih dipakai (sesuai UI-UX “Kategori yang sudah memiliki produk tidak bisa dihapus”).
        $this->service->delete($category); // hard delete sesuai SOP

        return response()->json([
            'success' => true,
            'message' => 'Kategori berhasil dihapus',
        ]);
    }
}
