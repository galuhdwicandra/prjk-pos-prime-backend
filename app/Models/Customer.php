<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasManyThrough;

class Customer extends Model
{
    protected $table = 'customers';

    protected $fillable = [
        'cabang_id',
        'nama',
        'phone',
        'email',
        'alamat',
        'catatan',
        'stage',
        'last_order_at',
        'total_spent',
        'total_orders',
    ];

    protected $casts = [
        'last_order_at' => 'datetime',
        'total_spent'   => 'decimal:2',
        'total_orders'  => 'integer',
    ];

    public function orders(): HasMany
    {
        return $this->hasMany(Order::class, 'customer_id');
    }

    public function timelines(): HasMany
    {
        return $this->hasMany(CustomerTimeline::class, 'customer_id');
    }

    /** Scope data by cabang (branch). */
    public function scopeForCabang($q, int $cabangId)
    {
        return $q->where('cabang_id', $cabangId);
    }
}
