<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class GudangUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'nama' => ['sometimes','string','max:120'],
            'is_default' => ['sometimes','boolean'],
            'is_active' => ['sometimes','boolean'],
        ];
    }
}
