<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class AccountStoreRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'cabang_id'      => ['nullable', 'integer', 'exists:cabangs,id'],
            'code'           => ['required', 'string', 'max:32'],
            'name'           => ['required', 'string', 'max:160'],
            'type'           => ['required', 'in:Asset,Liability,Equity,Revenue,Expense'],
            'normal_balance' => ['required', 'in:DEBIT,CREDIT'],
            'parent_id'      => ['nullable', 'integer', 'exists:accounts,id'],
            'is_active'      => ['boolean'],
        ];
    }
}
