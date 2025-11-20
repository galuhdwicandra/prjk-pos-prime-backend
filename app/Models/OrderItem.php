<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class OrderItem extends Model
{
    protected $fillable = [
        'order_id',
        'variant_id',
        'name_snapshot',
        'price',
        'discount',
        'qty',
        'line_total'
    ];

    protected $casts = [
        'price'      => 'float',
        'discount'   => 'float',
        'qty'        => 'float',
        'line_total' => 'float',
    ];

    // ⬇⬇ tambahkan agar muncul di JSON response
    protected $appends = ['name', 'note'];

    // alias "name" → ke name_snapshot
    public function getNameAttribute(): ?string
    {
        return $this->attributes['name_snapshot'] ?? null;
    }

    // sistem tidak punya kolom note di order_items → default null
    public function getNoteAttribute(): ?string
    {
        return null;
    }

    public function order(): BelongsTo
    {
        return $this->belongsTo(Order::class);
    }

    public function variant(): BelongsTo
    {
        return $this->belongsTo(ProductVariant::class, 'variant_id');
    }
}
