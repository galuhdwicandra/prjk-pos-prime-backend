<?php

namespace App\Services;

use App\Services\VariantStockService;

class SalesInventoryService
{
    public function __construct(private VariantStockService $stockService) {}

    public function deductOnPaid(int $gudangId, int $variantId, float $qty, ?string $note = null): void
    {
        // turunkan ke integer jika stok integral di tabel kamu
        $amount = (int) ceil($qty);
        // gunakan adjust('decrease') agar tidak minus
        $stock = \App\Models\VariantStock::query()
            ->where('gudang_id', $gudangId)
            ->where('product_variant_id', $variantId)
            ->firstOrFail();

        $this->stockService->adjust($stock, 'decrease', $amount, $note ?? 'SALE');
        // (lanjutan ideal): tulis StockMove direction=OUT reason=SALE (lihat ERD) :contentReference[oaicite:12]{index=12}
    }
}
