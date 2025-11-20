<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class OrderUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'note' => ['nullable', 'string', 'max:2000'],
            'items' => ['required', 'array', 'min:1'],
            'items.*.id' => ['nullable', 'integer'],
            'items.*.variant_id' => ['required', 'integer', 'min:1'],
            'items.*.qty' => ['required', 'numeric', 'gt:0'],
            'items.*.discount' => ['nullable', 'numeric', 'min:0'],
            'items.*._delete' => ['sometimes', 'boolean'],
            'cash_position' => ['nullable', 'string', 'in:CUSTOMER,CASHIER,SALES,ADMIN'],
        ];
    }
}
