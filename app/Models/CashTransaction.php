<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class CashTransaction extends Model
{
    protected $fillable = ['session_id', 'type', 'amount', 'source', 'ref_type', 'ref_id', 'note', 'occurred_at'];
    protected $casts = ['amount' => 'decimal:2', 'occurred_at' => 'datetime'];
    public function session(): BelongsTo
    {
        return $this->belongsTo(CashSession::class, 'session_id');
    }
}
