<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreVariantRequest extends FormRequest
{
    public function authorize(): bool
    {
        $product = $this->route('product');
        return $this->user()?->can('update', $product) ?? false;
    }

    public function rules(): array
    {
        return [
            'size' => ['nullable', 'string', 'max:40'],
            'type' => ['nullable', 'string', 'max:60'],
            'tester' => ['nullable', 'string', 'max:40'],
            'harga' => ['required', 'numeric', 'min:0'],
            'sku' => ['nullable', 'string', 'max:80', 'unique:product_variants,sku'],
        ];
    }
}
