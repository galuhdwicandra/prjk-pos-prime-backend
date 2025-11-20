<?php

namespace App\Http\Requests\Category;

use Illuminate\Foundation\Http\FormRequest;

class StoreCategoryRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->can('create', \App\Models\Category::class);
    }

    public function rules(): array
    {
        return [
            'nama'       => ['required', 'string', 'max:120'],
            'deskripsi'  => ['nullable', 'string'],
            'is_active'  => ['nullable', 'boolean'],
            // slug tidak diwajibkan di input; akan dihasilkan otomatis oleh Service
            'slug'       => ['nullable', 'string', 'max:140', 'unique:categories,slug'],
        ];
    }

    public function payload(): array
    {
        return [
            'nama'      => $this->input('nama'),
            'deskripsi' => $this->input('deskripsi'),
            'is_active' => $this->boolean('is_active', true),
            'slug'      => $this->input('slug'), // optional; kalau kosong akan di-generate
        ];
    }
}
