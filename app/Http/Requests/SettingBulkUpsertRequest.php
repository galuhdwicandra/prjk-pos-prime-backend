<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class SettingBulkUpsertRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }
    public function rules(): array
    {
        return [
            'items' => 'required|array|min:1',
            'items.*.scope' => 'required|in:GLOBAL,BRANCH,USER',
            'items.*.scope_id' => 'nullable|integer|min:1',
            'items.*.key' => 'required|string|max:150',
            'items.*.value' => 'required|array',
        ];
    }
}
