<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductVariant extends Model
{
    protected $fillable = [
        'product_id',
        'size',
        'type',
        'tester',
        'sku',
        'harga',
        'is_active',
    ];

    protected $casts = [
        'harga' => 'decimal:2',
        'is_active' => 'boolean',
    ];

    public function product()
    {
        return $this->belongsTo(Product::class);
    }

    // Placeholder relasi stok per gudang (M5)
    // public function stocks() { ... }

    /** Scope aktif */
    public function scopeActive($q)
    {
        return $q->where('is_active', true);
    }
}
