<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\UploadProductMediaRequest;
use App\Http\Requests\ReorderProductMediaRequest;
use App\Http\Requests\SetPrimaryProductMediaRequest;
use App\Models\Product;
use App\Models\ProductMedia;
use App\Services\Products\ProductMediaService;
use Illuminate\Http\Request;

class ProductMediaController extends Controller
{
    public function __construct(private ProductMediaService $svc) {}

    // List media by product
    public function index(Product $product)
    {
        $this->authorize('view', $product);

        return response()->json(
            $product->media()->orderByDesc('is_primary')->orderBy('sort_order')->get()
        );
    }

    // Upload multiple files
    public function store(UploadProductMediaRequest $request, Product $product)
    {
        $this->authorize('update', $product);

        // Accept *either* single 'file' or array 'files[]'
        $files = [];

        if ($request->hasFile('file')) {
            $files = [$request->file('file')]; // single
        } elseif ($request->hasFile('files')) {
            $files = $request->file('files');  // multiple
        }

        // Safety: either path must pass UploadProductMediaRequest rules (files.*)
        // If you want both paths validated, adjust rules to allow 'file' too (see below).

        $created = [];
        foreach ($files as $uploaded) {
            $path = $uploaded->store("products/{$product->id}", 'public');

            $media = \App\Models\ProductMedia::create([
                'product_id' => $product->id,
                'disk'       => 'public',
                'path'       => $path,
                'mime'       => $uploaded->getClientMimeType(),
                'size_kb'    => (int) round(($uploaded->getSize() ?? 0) / 1024),
                'is_primary' => !\App\Models\ProductMedia::where('product_id', $product->id)->exists(),
                'sort_order' => 0,
            ]);

            // convenience URLs
            $media->url = asset('storage/' . $media->path);
            $created[] = $media;
        }

        return response()->json(['data' => $created], 201);
    }

    // Set primary image
    public function setPrimary(SetPrimaryProductMediaRequest $request, Product $product)
    {
        $this->authorize('update', $product);

        $media = ProductMedia::where('product_id', $product->id)
            ->where('id', $request->validated()['media_id'])
            ->firstOrFail();

        $this->svc->setPrimary($product, $media);

        return response()->json(['message' => 'Primary image set']);
    }

    // Reorder (sort_order)
    public function reorder(ReorderProductMediaRequest $request, Product $product)
    {
        $this->authorize('update', $product);

        $this->svc->reorder($product, $request->validated()['orders']);

        return response()->json(['message' => 'Media reordered']);
    }

    // Delete media
    public function destroy(Product $product, ProductMedia $media)
    {
        $this->authorize('update', $product);
        $this->authorize('delete', $media);
        abort_unless($media->product_id === $product->id, 404);

        $this->svc->delete($media);

        return response()->json(['message' => 'Media deleted']);
    }
}
