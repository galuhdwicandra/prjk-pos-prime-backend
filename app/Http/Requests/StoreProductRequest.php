<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreProductRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()?->can('create', \App\Models\Product::class) ?? false;
    }

    public function rules(): array
    {
        return [
            'category_id' => ['required', 'exists:categories,id'],
            'nama' => ['required', 'string', 'max:160'],
            'slug' => ['nullable', 'string', 'max:180', 'unique:products,slug'],
            'deskripsi' => ['nullable', 'string'],
            'is_active' => ['boolean'],
            // optional create with initial variants:
            'variants' => ['sometimes', 'array', 'max:50'],
            'variants.*.size' => ['nullable', 'string', 'max:40'],
            'variants.*.type' => ['nullable', 'string', 'max:60'],
            'variants.*.tester' => ['nullable', 'string', 'max:40'],
            'variants.*.harga' => ['required', 'numeric', 'min:0'],
        ];
    }
}
