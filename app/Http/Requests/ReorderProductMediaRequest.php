<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ReorderProductMediaRequest extends FormRequest
{
    public function authorize(): bool
    {
        $product = $this->route('product');
        return $this->user()?->can('update', $product) ?? false;
    }

    public function rules(): array
    {
        return [
            'orders' => ['required', 'array', 'min:1'],
            'orders.*.id' => ['required', 'exists:product_media,id'],
            'orders.*.sort_order' => ['required', 'integer', 'min:0', 'max:65535'],
        ];
    }
}
