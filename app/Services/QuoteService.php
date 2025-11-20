<?php

namespace App\Services;

use App\Models\ProductVariant;

class QuoteService
{
    // ✅ Not readonly, not promoted, no defaults in signature
    private float $taxPercent;
    private float $servicePercent;

    public function __construct()
    {
        // ✅ Single assignment (legal in PHP 8.2+)
        $this->taxPercent     = (float) config('pos.tax_percent', env('POS_TAX_PERCENT', 0));
        $this->servicePercent = (float) config('pos.service_percent', env('POS_SERVICE_PERCENT', 0));
    }

    /**
     * @param array<int, array{variant_id:int, qty:float, discount?:float, price_hint?:float}> $items
     * @return array{items:array<int, array>, totals: array}
     */
    public function quoteItems(array $items): array
    {
        $resultItems   = [];
        $subtotal      = 0.0;
        $discountTotal = 0.0;

        foreach ($items as $row) {
            $variant = ProductVariant::query()
                ->with('product')
                ->where('is_active', true)
                ->whereHas('product', fn ($q) => $q->where('is_active', true))
                ->findOrFail((int) $row['variant_id']);

            $qty       = max(0.0, (float) $row['qty']);
            $unitPrice = (float) $variant->harga;
            $disc      = isset($row['discount']) ? max(0.0, (float) $row['discount']) : 0.0;

            $effectiveUnit = max(0.0, $unitPrice - $disc);
            $line          = $effectiveUnit * $qty;

            $resultItems[] = [
                'variant_id'    => $variant->id,
                'name_snapshot' => $variant->product->nama.' - '.$variant->nama,
                'price'         => round($unitPrice, 2),
                'discount'      => round($disc, 2),
                'qty'           => $qty,
                'line_total'    => round($line, 2),
            ];

            $subtotal      += ($unitPrice * $qty);
            $discountTotal += ($disc * $qty);
        }

        $net     = max(0.0, $subtotal - $discountTotal);
        $service = round($net * ($this->servicePercent / 100), 2);
        $tax     = round(($net + $service) * ($this->taxPercent / 100), 2);
        $grand   = round($net + $service + $tax, 2);

        return [
            'items'  => $resultItems,
            'totals' => [
                'subtotal'     => round($subtotal, 2),
                'discount'     => round($discountTotal, 2),
                'service_fee'  => $service,
                'tax'          => $tax,
                'grand_total'  => $grand,
            ],
        ];
    }
}
