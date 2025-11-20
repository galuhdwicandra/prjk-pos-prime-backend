<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class SettingQueryRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }
    public function rules(): array
    {
        return [
            'scope' => 'nullable|in:GLOBAL,BRANCH,USER',
            'scope_id' => 'nullable|integer|min:1',
            'keys' => 'nullable|array',
            'keys.*' => 'string|max:150',
        ];
    }
}
