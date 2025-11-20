<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;
use Illuminate\Filesystem\FilesystemAdapter;

class Product extends Model
{
    protected $fillable = [
        'category_id',
        'nama',
        'slug',
        'deskripsi',
        'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    /** 🔹 Make image_url appear in JSON automatically */
    protected $appends = ['image_url'];

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function variants()
    {
        return $this->hasMany(ProductVariant::class);
    }

    public function media()
    {
        return $this->hasMany(ProductMedia::class)
            ->orderBy('is_primary', 'desc')
            ->orderBy('sort_order');
    }

    /** 🔹 The single primary media (fast to eager-load) */
    public function primaryMedia()
    {
        return $this->hasOne(ProductMedia::class)
            ->where('is_primary', true)
            ->orderBy('sort_order');
    }

    /** Scope aktif */
    public function scopeActive($q)
    {
        return $q->where('is_active', true);
    }

    /** Scope pencarian nama/slug */
    public function scopeSearch($q, ?string $term)
    {
        $term = trim((string) $term);
        if ($term === '') return $q;

        return $q->where(
            fn($w) =>
            $w->where('nama', 'like', "%{$term}%")
                ->orWhere('slug', 'like', "%{$term}%")
        );
    }

    /** 🔹 JSON accessor for the POS thumbnail URL */
    public function getImageUrlAttribute(): ?string
    {
        // Prefer eager-loaded primaryMedia; otherwise pick the first from media()
        $media = $this->relationLoaded('primaryMedia')
            ? $this->getRelation('primaryMedia')
            : $this->primaryMedia()->first();

        if (!$media) {
            // fallback: first non-primary media if exists
            $media = $this->relationLoaded('media')
                ? ($this->getRelation('media')->first() ?: null)
                : $this->media()->first();
        }

        if (!$media || empty($media->path)) return null;

        // Build a stable public URL (FILES_BASE_URL falls back to APP_URL)
        $base = rtrim(env('FILES_BASE_URL', config('app.url')), '/');
        $path = ltrim($media->path, '/'); // stored on "public" disk as e.g. products/xx.jpg

        /** @var FilesystemAdapter $disk */
        $disk = Storage::disk('public');

        return $disk->url($media->path);
    }
}
