<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class CashHolder extends Model
{
    protected $fillable = ['cabang_id', 'name', 'balance'];

    public function cabang(): BelongsTo
    {
        return $this->belongsTo(Cabang::class, 'cabang_id');
    }
    public function outgoingMoves(): HasMany
    {
        return $this->hasMany(CashMove::class, 'from_holder_id');
    }
    public function incomingMoves(): HasMany
    {
        return $this->hasMany(CashMove::class, 'to_holder_id');
    }
}
