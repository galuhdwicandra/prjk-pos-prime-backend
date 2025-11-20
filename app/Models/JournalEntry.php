<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class JournalEntry extends Model
{
    protected $fillable = [
        'cabang_id',
        'journal_date',
        'number',
        'description',
        'status',
        'period_year',
        'period_month'
    ];

    public function lines()
    {
        return $this->hasMany(JournalLine::class, 'journal_id');
    }
}
