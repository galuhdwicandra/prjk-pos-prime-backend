<?php

namespace App\Services\Products;

use App\Models\Product;
use App\Models\ProductMedia;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class ProductMediaService
{
    public function upload(Product $product, array $files, string $disk = 'public'): array
    {
        $saved = [];

        DB::transaction(function () use ($product, $files, $disk, &$saved) {
            foreach ($files as $file) {
                /** @var UploadedFile $file */
                $path = $file->store('products/' . $product->id, $disk);

                $media = ProductMedia::create([
                    'product_id' => $product->id,
                    'disk' => $disk,
                    'path' => $path,
                    'mime' => $file->getClientMimeType(),
                    'size_kb' => (int) round(($file->getSize() ?? 0) / 1024),
                    'is_primary' => false,
                    'sort_order' => 0,
                ]);

                $saved[] = $media;
            }
        });

        return $saved;
    }

    public function setPrimary(Product $product, ProductMedia $media): void
    {
        DB::transaction(function () use ($product, $media) {
            ProductMedia::where('product_id', $product->id)->update(['is_primary' => false]);
            $media->update(['is_primary' => true, 'sort_order' => 0]);
        });
    }

    public function reorder(Product $product, array $orders): void
    {
        DB::transaction(function () use ($product, $orders) {
            foreach ($orders as $o) {
                ProductMedia::where('product_id', $product->id)
                    ->where('id', $o['id'])
                    ->update(['sort_order' => (int) $o['sort_order']]);
            }
        });
    }

    public function delete(ProductMedia $media): void
    {
        DB::transaction(function () use ($media) {
            $disk = $media->disk;
            $path = $media->path;
            $media->delete();
            if ($path && $disk && Storage::disk($disk)->exists($path)) {
                Storage::disk($disk)->delete($path);
            }
        });
    }
}
