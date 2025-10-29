<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class JournalLine extends Model
{
    protected $fillable = [
        'journal_id',
        'account_id',
        'cabang_id',
        'debit',
        'credit',
        'ref_type',
        'ref_id'
    ];

    public function journal()
    {
        return $this->belongsTo(JournalEntry::class, 'journal_id');
    }
    public function account()
    {
        return $this->belongsTo(Account::class, 'account_id');
    }
}
