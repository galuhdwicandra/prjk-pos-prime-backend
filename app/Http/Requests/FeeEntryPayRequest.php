<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class FeeEntryPayRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'entry_ids'  => ['required', 'array', 'min:1'],
            'entry_ids.*' => ['integer', 'distinct'],
            'status'     => ['required', 'in:PAID,PARTIAL'],
            'paid_amount' => ['nullable', 'numeric', 'min:0'],
            'paid_at'    => ['nullable', 'date'],
        ];
    }
}
