<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\{BelongsTo, HasMany};
use Illuminate\Support\Facades\DB;

class Delivery extends Model
{
    protected $fillable = [
        'order_id',
        'assigned_to',
        'type',
        'status',
        'pickup_address',
        'delivery_address',
        'pickup_lat',
        'pickup_lng',
        'delivery_lat',
        'delivery_lng',
        'requested_at',
        'completed_at',
    ];

    protected $casts = [
        'requested_at' => 'datetime',
        'completed_at' => 'datetime',
        'pickup_lat' => 'decimal:7',
        'pickup_lng' => 'decimal:7',
        'delivery_lat' => 'decimal:7',
        'delivery_lng' => 'decimal:7',
    ];

    public function order()
    {
        return $this->belongsTo(Order::class)->select([
            'id',
            DB::raw('"kode" as code'),
            'cabang_id',
        ]);
    }

    public function courier(): BelongsTo
    {
        return $this->belongsTo(User::class, 'assigned_to');
    }

    public function events(): HasMany
    {
        return $this->hasMany(DeliveryEvent::class);
    }

    // Quick scopes
    public function scopeStatus($q, string $status)
    {
        return $q->where('status', $status);
    }
    public function scopeCourier($q, int $userId)
    {
        return $q->where('assigned_to', $userId);
    }
}
