<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Setting extends Model
{
    protected $fillable = ['scope', 'scope_id', 'key', 'value_json'];
    protected $casts = ['value_json' => 'array'];

    // Scope helpers
    public function scopeGlobal($q)
    {
        return $q->where('scope', 'GLOBAL');
    }
    public function scopeBranch($q, int $branchId)
    {
        return $q->where(['scope' => 'BRANCH', 'scope_id' => $branchId]);
    }
    public function scopeUser($q, int $userId)
    {
        return $q->where(['scope' => 'USER', 'scope_id' => $userId]);
    }
}
