<?php

namespace App\Http\Requests\Orders;

use Illuminate\Foundation\Http\FormRequest;

class IndexOrdersRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'cabang_id' => ['nullable', 'integer'],
            'status'    => ['nullable', 'in:DRAFT,UNPAID,PAID,VOID,REFUND'],
            'date_from' => ['nullable', 'date'],
            'date_to'   => ['nullable', 'date', 'after_or_equal:date_from'],
            'search'    => ['nullable', 'string', 'max:120'], // kode/phone/note
            'page'      => ['nullable', 'integer', 'min:1'],
            'per_page'  => ['nullable', 'integer', 'min:5', 'max:100'],
        ];
    }
}
