<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CashHolderStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->can('create', \App\Models\CashHolder::class);
    }

    public function rules(): array
    {
        return [
            'cabang_id'       => ['required', 'integer', 'exists:cabangs,id'],
            'name'            => ['required', 'string', 'max:120'],
            'opening_balance' => ['nullable', 'numeric', 'min:0'],
        ];
    }
}
