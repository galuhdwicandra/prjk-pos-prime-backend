<?php

namespace App\Http\Requests\Orders;

use Illuminate\Foundation\Http\FormRequest;

class UpdateOrderItemsRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'items'              => ['required', 'array', 'min:1'],
            'items.*.id'         => ['nullable', 'integer'], // existing order_item id (null = new)
            'items.*.variant_id' => ['required_without:items.*.id', 'integer'],
            'items.*.name' => ['nullable', 'string', 'max:200', 'not_regex:/^\s*$/'],
            'items.*.price'      => ['required', 'numeric', 'min:0'],
            'items.*.discount'   => ['nullable', 'numeric', 'min:0'],
            'items.*.qty'        => ['required', 'numeric', 'gt:0'],
            'remove_item_ids'    => ['nullable', 'array'],
            'remove_item_ids.*'  => ['integer'],
            'note'               => ['nullable', 'string', 'max:500'],
        ];
    }

    public function messages(): array
    {
        return [
            'items.required' => 'Minimal satu item.',
            'items.*.price.min' => 'Harga tidak boleh negatif.',
            'items.*.qty.gt' => 'Qty harus lebih dari 0.',
        ];
    }
}
