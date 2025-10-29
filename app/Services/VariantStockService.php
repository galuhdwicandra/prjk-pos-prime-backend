<?php

namespace App\Services;

use App\Models\VariantStock;
use App\Models\Gudang;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\ModelNotFoundException;

class VariantStockService
{
    /**
     * Set stok awal (upsert unik per gudang+variant).
     * @param int $gudangId
     * @param int $variantId
     * @param int $qty
     * @param int|null $minStok
     * @return VariantStock
     */
    public function setInitialStock(int $gudangId, int $variantId, int $qty, ?int $minStok = null): VariantStock
    {
        return DB::transaction(function () use ($gudangId, $variantId, $qty, $minStok) {
            $gudang = Gudang::query()->with('cabang')->findOrFail($gudangId);
            /** @var VariantStock $stock */
            $stock = VariantStock::query()->firstOrNew([
                'gudang_id' => $gudang->id,
                'product_variant_id' => $variantId,
            ]);

            $stock->cabang_id = $gudang->cabang_id;
            $stock->qty       = (int)$qty;
            if ($minStok !== null) $stock->min_stok = (int)$minStok;
            $stock->save();

            // (Optional) dispatch event: VariantStockInitialized
            return $stock->refresh();
        });
    }

    /**
     * Penyesuaian manual stok.
     * @param VariantStock $stock
     * @param 'increase'|'decrease' $type
     * @param int $amount
     * @param string|null $note
     * @return VariantStock
     */
    public function adjust(VariantStock $stock, string $type, int $amount, ?string $note = null): VariantStock
    {
        return DB::transaction(function () use ($stock, $type, $amount, $note) {
            $stock->lockForUpdate(); // hindari race condition
            if ($type === 'increase') {
                $stock->qty += $amount;
            } else {
                // cegah negatif
                if ($stock->qty < $amount) {
                    throw new \RuntimeException('Stok tidak mencukupi untuk dikurangi.');
                }
                $stock->qty -= $amount;
            }
            $stock->save();

            // (Optional) audit log penyesuaian menggunakan $note
            return $stock->refresh();
        });
    }

    /**
     * Update threshold low-stock.
     */
    public function updateMinStok(VariantStock $stock, int $minStok): VariantStock
    {
        $stock->min_stok = $minStok;
        $stock->save();
        return $stock->refresh();
    }

    /**
     * Konsistensi: pastikan 1 baris per (gudang, variant) dan cabang sinkron.
     * Bisa dipanggil sebagai maintenance/command bila perlu.
     */
    public function ensureUniquenessAndSync(VariantStock $stock): void
    {
        $duplicate = VariantStock::query()
            ->where('id', '!=', $stock->id)
            ->where('gudang_id', $stock->gudang_id)
            ->where('product_variant_id', $stock->product_variant_id)
            ->exists();

        if ($duplicate) {
            throw new \RuntimeException('Data stok duplikat untuk gudang & varian yang sama.');
        }
    }
}
