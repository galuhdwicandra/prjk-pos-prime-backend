<?php

namespace App\Http\Requests\Orders;

use Illuminate\Foundation\Http\FormRequest;

class ResendWARequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'phone'   => ['required', 'string', 'max:30'],
            'message' => ['nullable', 'string', 'max:1000'],
        ];
    }
}
