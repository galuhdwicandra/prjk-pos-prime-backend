<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Fee extends Model
{
    protected $fillable = [
        'cabang_id',
        'name',
        'kind',
        'calc_type',
        'rate',
        'base',
        'is_active',
        'created_by',
        'updated_by'
    ];

    protected $casts = [
        'is_active' => 'boolean',
        'rate' => 'decimal:2',
    ];

    public function cabang()
    {
        return $this->belongsTo(Cabang::class, 'cabang_id');
    }

    public function entries()
    {
        return $this->hasMany(FeeEntry::class, 'fee_id');
    }

    /* ===== Scopes ===== */
    public function scopeActive(Builder $q, ?bool $isActive = true): Builder
    {
        if ($isActive === null) return $q;
        return $q->where('is_active', $isActive);
    }

    public function scopeCabang(Builder $q, $cabangId): Builder
    {
        if (!$cabangId) return $q;
        return $q->where('cabang_id', $cabangId);
    }

    public function scopeSearch(Builder $q, ?string $term): Builder
    {
        if (!$term) return $q;
        return $q->where(function ($qq) use ($term) {
            $qq->where('name', 'like', "%{$term}%");
        });
    }
}
