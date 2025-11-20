<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreProductRequest;
use App\Http\Requests\UpdateProductRequest;
use App\Models\Product;
use App\Services\Products\ProductService;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function __construct(private ProductService $svc) {}

    public function index(Request $request)
    {
        $this->authorize('viewAny', Product::class);

        $term = $request->query('q', $request->query('search'));

        $items = $this->svc->list(
            search: $term,
            perPage: (int) $request->query('per_page', 24)
        );

        return response()->json($items);
    }

    public function store(StoreProductRequest $request)
    {
        $this->authorize('create', Product::class);

        $product = $this->svc->create($request->validated());

        return response()->json([
            'message' => 'Product created',
            'data' => $product,
        ], 201);
    }

    public function show(Product $product)
    {
        $this->authorize('view', $product);
        // ✅ include primaryMedia as well for clients that prefer it
        return response()->json(
            $product->load(['variants', 'media', 'primaryMedia:id,product_id,path,is_primary,sort_order'])
        );
    }

    public function update(UpdateProductRequest $request, Product $product)
    {
        $this->authorize('update', $product);

        $updated = $this->svc->update($product, $request->validated());

        return response()->json([
            'message' => 'Product updated',
            'data' => $updated,
        ]);
    }

    public function destroy(Product $product)
    {
        $this->authorize('delete', $product);

        $this->svc->delete($product);

        return response()->json(['message' => 'Product deleted']);
    }
}
