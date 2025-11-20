<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class CashSession extends Model
{
    protected $fillable = [
        'cabang_id',
        'cashier_id',
        'opening_amount',
        'closing_amount',
        'status',
        'opened_at',
        'closed_at'
    ];
    protected $casts = ['opening_amount' => 'decimal:2', 'closing_amount' => 'decimal:2', 'opened_at' => 'datetime', 'closed_at' => 'datetime'];
    public function cabang(): BelongsTo
    {
        return $this->belongsTo(Cabang::class, 'cabang_id');
    }
    public function cashier(): BelongsTo
    {
        return $this->belongsTo(User::class, 'cashier_id');
    }
    public function transactions(): HasMany
    {
        return $this->hasMany(CashTransaction::class, 'session_id');
    }
}
