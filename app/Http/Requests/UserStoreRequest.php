<?php

// app/Http/Requests/UserStoreRequest.php
namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UserStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }
    public function rules(): array
    {
        $roles = ['superadmin', 'admin_cabang', 'gudang', 'kasir', 'sales', 'kurir'];
        return [
            'name' => ['required', 'string', 'max:120'],
            'email' => ['required', 'email', 'max:190', 'unique:users,email'],
            'phone' => ['nullable', 'string', 'max:30'],
            'password' => ['required', 'string', 'min:8', 'max:190'],
            'cabang_id' => ['nullable', 'integer', 'min:1'],
            'role' => ['required', Rule::in($roles)],
            'is_active' => ['boolean'],
        ];
    }
}
