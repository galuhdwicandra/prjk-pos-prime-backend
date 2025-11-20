<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class VariantStockUpdateRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        return [
            'min_stok' => ['required','integer','min:0'],
        ];
    }
}
