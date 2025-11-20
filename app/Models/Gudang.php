<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Gudang extends Model
{
    use HasFactory;

    protected $fillable = [
        'cabang_id',
        'nama',
        'is_default',
        'is_active',
    ];

    protected $casts = [
        'is_default' => 'boolean',
        'is_active' => 'boolean',
    ];

    public function cabang()
    {
        return $this->belongsTo(Cabang::class);
    }

    // Placeholder relasi stok: akan ditambahkan saat modul Stok Gudang dibuat.
    // public function stokVarian() { ... }
}
