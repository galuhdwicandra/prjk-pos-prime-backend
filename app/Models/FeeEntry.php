<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class FeeEntry extends Model
{
    protected $fillable = [
        'fee_id',
        'cabang_id',
        'period_date',
        'ref_type',
        'ref_id',
        'owner_user_id',
        'base_amount',
        'fee_amount',
        'pay_status',
        'paid_amount',
        'paid_at',
        'notes',
        'created_by',
        'updated_by'
    ];

    protected $casts = [
        'period_date' => 'date',
        'base_amount' => 'decimal:2',
        'fee_amount' => 'decimal:2',
        'paid_amount' => 'decimal:2',
        'paid_at' => 'datetime',
    ];

    public function fee(): BelongsTo
    {
        return $this->belongsTo(Fee::class);
    }
}
