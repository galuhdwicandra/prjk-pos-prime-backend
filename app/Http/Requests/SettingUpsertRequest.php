<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class SettingUpsertRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }
    public function rules(): array
    {
        return [
            'scope' => 'required|in:GLOBAL,BRANCH,USER',
            'scope_id' => 'nullable|integer|min:1',
            'key' => 'required|string|max:150',
            'value' => 'required|array',
        ];
    }
}
