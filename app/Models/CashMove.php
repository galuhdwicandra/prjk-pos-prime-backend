<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class CashMove extends Model
{
    protected $fillable = [
        'from_holder_id',
        'to_holder_id',
        'amount',
        'note',
        'moved_at',
        'status',
        'submitted_by',
        'approved_by',
        'approved_at',
        'rejected_at',
        'reject_reason',
        'idempotency_key'
    ];
    protected $casts = [
        'amount'    => 'decimal:2',
        'moved_at'  => 'datetime',
        'approved_at' => 'datetime',
        'rejected_at' => 'datetime',
    ];
    public function from(): BelongsTo
    {
        return $this->belongsTo(CashHolder::class, 'from_holder_id');
    }
    public function to(): BelongsTo
    {
        return $this->belongsTo(CashHolder::class, 'to_holder_id');
    }
    public function submitter(): BelongsTo
    {
        return $this->belongsTo(User::class, 'submitted_by');
    }
    public function approver(): BelongsTo
    {
        return $this->belongsTo(User::class, 'approved_by');
    }
}
