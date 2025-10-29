<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\VariantStockStoreRequest;
use App\Http\Requests\VariantStockAdjustRequest;
use App\Http\Requests\VariantStockUpdateRequest;
use App\Models\VariantStock;
use App\Services\VariantStockService;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class VariantStockController extends Controller
{
    public function __construct(private VariantStockService $service)
    {
        // pastikan pakai sanctum di route group
    }

    /**
     * GET /api/v1/stocks
     * Query: cabang_id?, gudang_id?, product_variant_id?, low=1?
     */
    public function index(Request $request)
    {
        $this->authorize('viewAny', VariantStock::class);

        $q = VariantStock::query()->with(['gudang','variant','cabang']);

        if ($request->filled('cabang_id')) {
            $q->where('cabang_id', (int)$request->integer('cabang_id'));
        }
        if ($request->filled('gudang_id')) {
            $q->where('gudang_id', (int)$request->integer('gudang_id'));
        }
        if ($request->filled('product_variant_id')) {
            $q->where('product_variant_id', (int)$request->integer('product_variant_id'));
        }
        if ($request->boolean('low')) {
            $q->whereColumn('qty', '<', 'min_stok');
        }

        $perPage = max(1, (int)$request->integer('per_page', 10));
        $data = $q->orderBy('id','desc')->paginate($perPage);

        // tambah flag is_low_stock per item
        $data->getCollection()->transform(function ($row) {
            $row->is_low_stock = $row->qty < $row->min_stok;
            return $row;
        });

        return response()->json($data);
    }

    /**
     * GET /api/v1/stocks/{id}
     */
    public function show(VariantStock $stock)
    {
        $this->authorize('view', $stock);
        $stock->load(['gudang','variant','cabang']);
        $stock->is_low_stock = $stock->qty < $stock->min_stok;

        return response()->json([
            'data' => $stock
        ]);
    }

    /**
     * POST /api/v1/stocks  (set stok awal / upsert unik)
     */
    public function store(VariantStockStoreRequest $request)
    {
        $this->authorize('create', VariantStock::class);

        $stock = $this->service->setInitialStock(
            gudangId: (int)$request->integer('gudang_id'),
            variantId: (int)$request->integer('product_variant_id'),
            qty: (int)$request->integer('qty'),
            minStok: $request->has('min_stok') ? (int)$request->integer('min_stok') : null
        );

        $stock->is_low_stock = $stock->qty < $stock->min_stok;

        return response()->json([
            'message' => 'Stok awal diset.',
            'data' => $stock
        ], Response::HTTP_CREATED);
    }

    /**
     * PATCH /api/v1/stocks/{stock}  (ubah min_stok saja)
     */
    public function update(VariantStockUpdateRequest $request, VariantStock $stock)
    {
        $this->authorize('update', $stock);

        $updated = $this->service->updateMinStok($stock, (int)$request->integer('min_stok'));
        $updated->is_low_stock = $updated->qty < $updated->min_stok;

        return response()->json([
            'message' => 'Threshold low-stock diperbarui.',
            'data' => $updated
        ]);
    }

    /**
     * POST /api/v1/stocks/{stock}/adjust  (tambah/kurang stok manual)
     */
    public function adjust(VariantStockAdjustRequest $request, VariantStock $stock)
    {
        $this->authorize('adjust', $stock);

        $updated = $this->service->adjust(
            stock: $stock,
            type: $request->input('type'),
            amount: (int)$request->integer('amount'),
            note: $request->input('note')
        );
        $updated->is_low_stock = $updated->qty < $updated->min_stok;

        return response()->json([
            'message' => 'Stok berhasil disesuaikan.',
            'data' => $updated
        ]);
    }

    /**
     * DELETE /api/v1/stocks/{stock}
     */
    public function destroy(VariantStock $stock)
    {
        $this->authorize('delete', $stock);
        $stock->delete();

        return response()->json([
            'message' => 'Data stok dihapus.'
        ]);
    }
}
