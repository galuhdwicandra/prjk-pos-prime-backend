<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ImportRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }
    public function rules(): array
    {
        return [
            'items' => 'required|array|min:1',
            'mode' => 'nullable|in:replace,merge,skip',
        ];
    }
}
