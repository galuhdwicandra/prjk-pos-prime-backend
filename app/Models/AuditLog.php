<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AuditLog extends Model
{
    protected $fillable = ['actor_type', 'actor_id', 'action', 'model', 'model_id', 'diff_json', 'occurred_at'];
    protected $casts = ['diff_json' => 'array', 'occurred_at' => 'datetime'];
}
