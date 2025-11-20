<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PeriodCloseRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'cabang_id' => ['required', 'integer', 'exists:cabangs,id'],
            'year'      => ['required', 'integer', 'min:2000', 'max:2100'],
            'month'     => ['required', 'integer', 'min:1', 'max:12'],
        ];
    }
}
