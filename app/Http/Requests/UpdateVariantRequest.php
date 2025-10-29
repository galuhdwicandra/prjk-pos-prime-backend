<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateVariantRequest extends FormRequest
{
    public function authorize(): bool
    {
        $variant = $this->route('variant');
        return $this->user()?->can('update', $variant) ?? false;
    }

    public function rules(): array
    {
        $variant = $this->route('variant');

        return [
            'size' => ['nullable', 'string', 'max:40'],
            'type' => ['nullable', 'string', 'max:60'],
            'tester' => ['nullable', 'string', 'max:40'],
            'harga' => ['sometimes', 'numeric', 'min:0'],
            'sku' => [
                'nullable',
                'string',
                'max:80',
                Rule::unique('product_variants', 'sku')->ignore($variant?->id),
            ],
            'is_active' => ['boolean'],
        ];
    }
}
