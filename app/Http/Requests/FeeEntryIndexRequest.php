<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class FeeEntryIndexRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'cabang_id'  => ['nullable', 'integer'],
            'from'       => ['nullable', 'date'],
            'to'         => ['nullable', 'date', 'after_or_equal:from'],
            'pay_status' => ['nullable', 'in:UNPAID,PAID,PARTIAL'],
            'per_page'   => ['nullable', 'integer', 'min:1', 'max:200'],
        ];
    }
}
