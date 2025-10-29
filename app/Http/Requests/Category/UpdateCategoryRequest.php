<?php

namespace App\Http\Requests\Category;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateCategoryRequest extends FormRequest
{
    public function authorize(): bool
    {
        $category = $this->route('category'); // pastikan route model binding dipakai nantinya
        return $this->user()->can('update', $category);
    }

    public function rules(): array
    {
        $categoryId = $this->route('category')?->id;

        return [
            'nama'       => ['required', 'string', 'max:120'],
            'deskripsi'  => ['nullable', 'string'],
            'is_active'  => ['nullable', 'boolean'],
            'slug'       => [
                'nullable',
                'string',
                'max:140',
                Rule::unique('categories', 'slug')->ignore($categoryId),
            ],
        ];
    }

    public function payload(): array
    {
        return [
            'nama'      => $this->input('nama'),
            'deskripsi' => $this->input('deskripsi'),
            'is_active' => $this->boolean('is_active', true),
            'slug'      => $this->input('slug'), // optional; jika kosong, service bisa regenerate dari nama (opsional)
        ];
    }
}
