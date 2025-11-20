<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CashMoveStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->can('create', \App\Models\CashMove::class);
    }
    public function rules(): array
    {
        return [
            'from_holder_id' => ['required', 'integer', 'exists:cash_holders,id'],
            'to_holder_id'   => ['required', 'integer', 'different:from_holder_id', 'exists:cash_holders,id'],
            'amount'         => ['required', 'numeric', 'gt:0'],
            'note'           => ['nullable', 'string'],
            'moved_at'       => ['required', 'date'],
            'idempotency_key' => ['nullable', 'string', 'max:64'],
        ];
    }
}
