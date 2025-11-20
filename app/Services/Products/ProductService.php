<?php

namespace App\Services\Products;

use App\Models\Product;
use App\Models\ProductVariant;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Database\Eloquent\Collection;

class ProductService
{
    public function list(?string $search = null, int $perPage = 24, ?bool $onlyActive = true)
    {
        return Product::query()
            ->when($onlyActive, fn($q) => $q->active())     // 🔹 default: hanya produk aktif
            ->withCount('variants')
            ->with(['primaryMedia:id,product_id,path,is_primary,sort_order'])
            ->search($search)
            ->orderByDesc('id')
            ->paginate($perPage);
    }

    public function create(array $data): Product
    {
        return DB::transaction(function () use ($data) {
            // slug
            $data['slug'] = $this->ensureUniqueSlug($data['slug'] ?? Str::slug($data['nama']));

            /** @var Product $product */
            $product = Product::create([
                'category_id' => $data['category_id'],
                'nama'        => $data['nama'],
                'slug'        => $data['slug'],
                'deskripsi'   => $data['deskripsi'] ?? null,
                'is_active'   => $data['is_active'] ?? true,
            ]);

            // optional initial variants
            if (!empty($data['variants']) && is_array($data['variants'])) {
                foreach ($data['variants'] as $v) {
                    $this->createVariant($product, $v);
                }
            }

            return $product->load('variants', 'media');
        });
    }

    public function update(Product $product, array $data): Product
    {
        return DB::transaction(function () use ($product, $data) {
            if (isset($data['nama']) && !isset($data['slug'])) {
                // regenerate slug only if not explicitly provided
                $data['slug'] = $this->ensureUniqueSlug(Str::slug($data['nama']), $product->id);
            } elseif (isset($data['slug'])) {
                $data['slug'] = $this->ensureUniqueSlug($data['slug'], $product->id);
            }

            $product->fill($data)->save();

            return $product->refresh()->load('variants', 'media');
        });
    }

    public function delete(Product $product): void
    {
        DB::transaction(function () use ($product) {
            $product->delete(); // media + variants cascade via FK onDelete? Variants yes; Media yes (set in migration)
        });
    }

    // ---------- Variants ----------
    public function createVariant(Product $product, array $data): ProductVariant
    {
        $sku = $data['sku'] ?? $this->generateSku($product, $data);
        return ProductVariant::create([
            'product_id' => $product->id,
            'size'   => $data['size']   ?? null,
            'type'   => $data['type']   ?? null,
            'tester' => $data['tester'] ?? null,
            'harga'  => $data['harga'],
            'sku'    => $this->ensureUniqueSku($sku),
            'is_active' => $data['is_active'] ?? true,
        ]);
    }

    public function updateVariant(ProductVariant $variant, array $data): ProductVariant
    {
        if (empty($data['sku'])) {
            // regenerate when attributes change
            $data['sku'] = $this->generateSku($variant->product, array_merge($variant->toArray(), $data));
        }
        $data['sku'] = $this->ensureUniqueSku($data['sku'], $variant->id);

        $variant->fill($data)->save();
        return $variant->refresh();
    }

    public function deleteVariant(ProductVariant $variant): void
    {
        $variant->delete();
    }

    // ---------- Helpers ----------
    private function ensureUniqueSlug(string $base, ?int $ignoreId = null): string
    {
        $slug = Str::slug($base) ?: Str::random(6);
        $try  = $slug;
        $i = 1;
        while (Product::where('slug', $try)->when($ignoreId, fn($q) => $q->where('id', '!=', $ignoreId))->exists()) {
            $try = $slug . '-' . $i++;
        }
        return $try;
    }

    private function generateSku(Product $product, array $data): string
    {
        $code = strtoupper(Str::slug(substr($product->nama, 0, 12), ''));
        $parts = [
            strtoupper(substr((string)($data['size'] ?? ''), 0, 3)),
            strtoupper(substr((string)($data['type'] ?? ''), 0, 3)),
            strtoupper(substr((string)($data['tester'] ?? ''), 0, 3)),
        ];
        $base = $code . '-' . implode('', array_filter($parts));
        return $base ?: 'SKU-' . Str::upper(Str::random(6));
    }

    private function ensureUniqueSku(string $base, ?int $ignoreId = null): string
    {
        $sku = preg_replace('/\s+/', '', strtoupper($base)) ?: 'SKU-' . Str::upper(Str::random(6));
        $try = $sku;
        $i = 1;
        $query = fn($t) => ProductVariant::where('sku', $t)
            ->when($ignoreId, fn($q) => $q->where('id', '!=', $ignoreId));
        while ($query($try)->exists()) {
            $try = $sku . '-' . $i++;
        }
        return $try;
    }
}
