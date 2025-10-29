<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class AccountUpdateRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'name'           => ['sometimes', 'string', 'max:160'],
            'type'           => ['sometimes', 'in:Asset,Liability,Equity,Revenue,Expense'],
            'normal_balance' => ['sometimes', 'in:DEBIT,CREDIT'],
            'parent_id'      => ['nullable', 'integer', 'exists:accounts,id'],
            'is_active'      => ['boolean'],
        ];
    }
}
