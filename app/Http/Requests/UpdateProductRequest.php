<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateProductRequest extends FormRequest
{
    public function authorize(): bool
    {
        $product = $this->route('product');
        return $this->user()?->can('update', $product) ?? false;
    }

    public function rules(): array
    {
        $product = $this->route('product');

        return [
            'category_id' => ['sometimes', 'exists:categories,id'],
            'nama' => ['sometimes', 'string', 'max:160'],
            'slug' => [
                'nullable',
                'string',
                'max:180',
                Rule::unique('products', 'slug')->ignore($product?->id),
            ],
            'deskripsi' => ['nullable', 'string'],
            'is_active' => ['boolean'],
        ];
    }
}
