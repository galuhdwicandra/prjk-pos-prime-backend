<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class VariantStockAdjustRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        return [
            'type'   => ['required','in:increase,decrease'],
            'amount' => ['required','integer','min:1'],
            'note'   => ['nullable','string','max:255'],
        ];
    }
}
