<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\{BelongsTo, HasMany};

class Order extends Model
{
    protected $fillable = [
        'kode',
        'cabang_id',
        'gudang_id',
        'cashier_id',
        'customer_id',
        'customer_name',
        'customer_phone',
        'customer_address',
        'status',
        'subtotal',
        'discount',
        'tax',
        'service_fee',
        'grand_total',
        'paid_total',
        'cash_position',
        'channel',
        'note',
        'ordered_at',
    ];

    protected $casts = [
        'subtotal'    => 'float',
        'discount'    => 'float',
        'tax'         => 'float',
        'service_fee' => 'float',
        'grand_total' => 'float',
        'paid_total'  => 'float',
        'cash_position' => 'string',
        'ordered_at'  => 'datetime',
    ];

    // Relations
    public function cabang(): BelongsTo
    {
        return $this->belongsTo(Cabang::class, 'cabang_id');
    }
    public function gudang(): BelongsTo
    {
        return $this->belongsTo(Gudang::class, 'gudang_id');
    }
    public function cashier(): BelongsTo
    {
        return $this->belongsTo(User::class, 'cashier_id');
    }
    public function items(): HasMany
    {
        return $this->hasMany(OrderItem::class);
    }
    public function customer()
    {
        return $this->belongsTo(Customer::class, 'customer_id');
    }
    public function payments(): HasMany
    {
        return $this->hasMany(Payment::class);
    }
    public function isEditable(): bool
    {
        return in_array($this->status, ['DRAFT', 'UNPAID'], true);
    }
    public function isPaid(): bool
    {
        return $this->status === 'PAID';
    }

    // Scope by branch (for Admin Cabang / Kasir)
    public function scopeOfCabang($q, $cabangId)
    {
        return $q->where('cabang_id', $cabangId);
    }

    public function getCodeAttribute(): ?string
    {
        // jika kolom 'kode' ada, expose sebagai 'code'
        return $this->attributes['kode'] ?? null;
    }
}
