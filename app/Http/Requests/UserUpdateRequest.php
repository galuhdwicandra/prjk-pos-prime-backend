<?php

// app/Http/Requests/UserUpdateRequest.php
namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UserUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        if ($this->has('password') && $this->string('password') === '') {
            // Konversi "" menjadi null agar lolos rule nullable|min:8
            $this->merge(['password' => null]);
        }
    }

    public function rules(): array
    {
        $roles = ['superadmin', 'admin_cabang', 'gudang', 'kasir', 'sales', 'kurir'];
        $id = $this->route('id') ?? $this->route('user');

        return [
            'name'      => ['sometimes', 'string', 'max:120'],
            'email'     => ['sometimes', 'email', 'max:190', "unique:users,email,{$id}"],
            'phone'     => ['sometimes', 'nullable', 'string', 'max:30'],
            // ⬇️ izinkan null (artinya tidak ganti), min:8 hanya berlaku jika ada nilai
            'password'  => ['sometimes', 'nullable', 'string', 'min:8'],
            'cabang_id' => ['sometimes', 'nullable', 'integer', 'min:1'],
            'role'      => ['sometimes', Rule::in($roles)],
            'is_active' => ['sometimes', 'boolean'],
        ];
    }
}
