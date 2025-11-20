<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class GudangStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'cabang_id' => ['required','integer','exists:cabangs,id'],
            'nama' => ['required','string','max:120'],
            'is_default' => ['sometimes','boolean'],
            'is_active' => ['sometimes','boolean'],
        ];
    }
}
