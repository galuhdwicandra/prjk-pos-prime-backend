<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;

    protected $table = 'categories';

    protected $fillable = [
        'nama',
        'slug',
        'deskripsi',
        'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    /** Scope: hanya kategori aktif */
    public function scopeActive($q)
    {
        return $q->where('is_active', true);
    }

    /** Scope pencarian sederhana pada nama/slug */
    public function scopeSearch($q, ?string $term)
    {
        $term = trim((string) $term);
        if ($term === '') return $q;

        return $q->where(function ($w) use ($term) {
            $w->where('nama', 'like', "%{$term}%")
              ->orWhere('slug', 'like', "%{$term}%");
        });
    }

    /** Relasi ke produk — akan diaktifkan saat modul Produk tersedia */
    // public function products()
    // {
    //     return $this->hasMany(Product::class, 'category_id');
    // }
}
