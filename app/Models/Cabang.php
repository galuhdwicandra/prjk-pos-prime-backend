<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cabang extends Model
{
    use HasFactory;

    protected $fillable = [
        'nama', 'kota', 'alamat', 'telepon', 'jam_operasional', 'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    public function gudangs()
    {
        return $this->hasMany(Gudang::class);
    }

    public function users()
    {
        return $this->hasMany(User::class);
    }

    /** Scope: hanya cabang aktif */
    public function scopeActive($q)
    {
        return $q->where('is_active', true);
    }
}
