<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class JournalStoreRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'cabang_id'     => ['required', 'integer', 'exists:cabangs,id'],
            'journal_date'  => ['required', 'date'],
            'number'        => ['required', 'string', 'max:40'],
            'description'   => ['nullable', 'string', 'max:255'],
            'lines'         => ['required', 'array', 'min:2'],
            'lines.*.account_id' => ['required', 'integer', 'exists:accounts,id'],
            'lines.*.debit'      => ['required_without:lines.*.credit', 'numeric', 'min:0'],
            'lines.*.credit'     => ['required_without:lines.*.debit', 'numeric', 'min:0'],
            'lines.*.ref_type'   => ['nullable', 'string', 'max:50'],
            'lines.*.ref_id'     => ['nullable', 'integer'],
        ];
    }
}
