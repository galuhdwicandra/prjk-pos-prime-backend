<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Backup extends Model
{
    public $timestamps = false;
    protected $fillable = ['storage_path', 'kind', 'size_bytes', 'created_at'];
    protected $casts = ['size_bytes' => 'integer', 'created_at' => 'datetime'];
}
