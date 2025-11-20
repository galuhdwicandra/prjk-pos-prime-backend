<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class JournalPostRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'idempotency_key' => ['nullable', 'string', 'max:64'],
        ];
    }
}
