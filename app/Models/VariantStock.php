<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class VariantStock extends Model
{
    protected $fillable = [
        'cabang_id',
        'gudang_id',
        'product_variant_id',
        'qty',
        'min_stok',
    ];

    protected $casts = [
        'qty' => 'integer',
        'min_stok' => 'integer',
    ];

    // RELATIONS
    public function cabang()
    {
        return $this->belongsTo(Cabang::class, 'cabang_id');
    }

    public function gudang()
    {
        return $this->belongsTo(Gudang::class, 'gudang_id');
    }

    public function variant()
    {
        return $this->belongsTo(ProductVariant::class, 'product_variant_id');
    }

    // SCOPES
    public function scopeOfCabang($q, $cabangId)
    {
        return $q->where('cabang_id', $cabangId);
    }

    public function scopeLowStock($q)
    {
        return $q->whereColumn('qty', '<', 'min_stok');
    }

    public function getIsLowStockAttribute(): bool
    {
        return $this->qty < $this->min_stok;
    }
}
