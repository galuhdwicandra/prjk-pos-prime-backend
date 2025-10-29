<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreVariantRequest;
use App\Http\Requests\UpdateVariantRequest;
use App\Models\Product;
use App\Models\ProductVariant;
use App\Services\Products\ProductService;
use Illuminate\Http\Request;

class ProductVariantController extends Controller
{
    public function __construct(private ProductService $svc) {}

    public function search(Request $req)
    {
        // Pastikan policy Anda punya ability 'viewAny' untuk ProductVariant
        $this->authorize('viewAny', ProductVariant::class);

        // Validasi ringan
        $validated = $req->validate([
            'q'            => ['nullable', 'string', 'max:100'],
            'warehouse_id' => ['nullable', 'integer', 'min:1'],
            'per_page'     => ['nullable', 'integer', 'min:1', 'max:50'],
        ]);

        $term        = trim((string)($validated['q'] ?? ''));
        $warehouseId = $validated['warehouse_id'] ?? null;
        $perPage     = (int)($validated['per_page'] ?? 10);

        $query = ProductVariant::query()
            ->with(['product:id,nama,is_active'])          // untuk tampilkan nama produk
            ->where('is_active', true)
            ->whereHas('product', fn($q) => $q->where('is_active', true));

        // Pencarian fleksibel: sku / size / type / nama produk
        if ($term !== '') {
            $like = '%' . str_replace(['%', '_'], ['\%', '\_'], $term) . '%';
            $query->where(function ($w) use ($like) {
                $w->where('sku', 'like', $like)
                    ->orWhere('size', 'like', $like)
                    ->orWhere('type', 'like', $like)
                    ->orWhereHas('product', fn($p) => $p->where('nama', 'like', $like));
            });
        }

        // Filter gudang opsional: hanya varian yang punya stok di gudang tsb
        if (!empty($warehouseId)) {
            $query->whereExists(function ($sub) use ($warehouseId) {
                $sub->from('variant_stocks')
                    ->whereColumn('variant_stocks.product_variant_id', 'product_variants.id')
                    ->where('variant_stocks.gudang_id', $warehouseId);
            });
        }

        $paginator = $query->orderByDesc('id')->paginate($perPage);

        // Bentuk data seperti yang UI harapkan
        $data = $paginator->getCollection()->map(function (ProductVariant $v) {
            $namaProduk = $v->product->nama ?? '';
            return [
                'id'        => $v->id,
                'sku'       => $v->sku,
                'harga'     => (float) $v->harga,
                'nama'      => $namaProduk,
                'full_name' => trim($namaProduk . ' ' . $v->size . ' ' . $v->type),
                // 'barcode' => $v->barcode ?? null, // aktifkan jika ada kolom barcode
            ];
        });

        return response()->json([
            'data'         => $data,
            'current_page' => $paginator->currentPage(),
            'per_page'     => $paginator->perPage(),
            'total'        => $paginator->total(),
            'last_page'    => $paginator->lastPage(),
        ]);
    }

    // List varian by product
    public function index(Product $product)
    {
        $this->authorize('view', $product);

        $items = $product->variants()->orderByDesc('id')->get();

        return response()->json([
            'data' => $items,
        ]);
    }

    // Create varian
    public function store(StoreVariantRequest $request, Product $product)
    {
        $this->authorize('update', $product);

        $variant = $this->svc->createVariant($product, $request->validated());

        return response()->json([
            'message' => 'Variant created',
            'data' => $variant,
        ], 201);
    }

    // Show varian
    public function show(Product $product, ProductVariant $variant)
    {
        $this->authorize('view', $product);
        $this->authorize('view', $variant);

        // Opsional: validasi varian milik product
        abort_unless($variant->product_id === $product->id, 404);

        return response()->json($variant);
    }

    // Update varian
    public function update(UpdateVariantRequest $request, Product $product, ProductVariant $variant)
    {
        $this->authorize('update', $product);
        $this->authorize('update', $variant);
        abort_unless($variant->product_id === $product->id, 404);

        $updated = $this->svc->updateVariant($variant, $request->validated());

        return response()->json([
            'message' => 'Variant updated',
            'data' => $updated,
        ]);
    }

    // Delete varian
    public function destroy(Product $product, ProductVariant $variant)
    {
        $this->authorize('update', $product);
        $this->authorize('delete', $variant);
        abort_unless($variant->product_id === $product->id, 404);

        $this->svc->deleteVariant($variant);

        return response()->json(['message' => 'Variant deleted']);
    }
}
