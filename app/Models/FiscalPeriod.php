<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FiscalPeriod extends Model
{
    protected $fillable = ['cabang_id', 'year', 'month', 'status'];

    public function scopeCabang($q, $cabangId)
    {
        return $q->where('cabang_id', $cabangId);
    }

    public function isOpen(): bool
    {
        return $this->status === 'OPEN';
    }
}
