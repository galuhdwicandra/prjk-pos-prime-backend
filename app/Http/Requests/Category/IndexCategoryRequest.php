<?php

namespace App\Http\Requests\Category;

use Illuminate\Foundation\Http\FormRequest;

class IndexCategoryRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->can('viewAny', \App\Models\Category::class);
    }

    public function rules(): array
    {
        return [
            'q'        => ['nullable', 'string', 'max:120'],
            'is_active'=> ['nullable', 'in:0,1'],
            'per_page' => ['nullable', 'integer', 'min:5', 'max:100'],
            'sort'     => ['nullable', 'in:nama,-nama,created_at,-created_at'],
        ];
    }

    public function perPage(): int
    {
        return (int) ($this->input('per_page', 10));
    }

    public function sort(): array
    {
        $sort = $this->input('sort', 'nama');
        $dir  = str_starts_with($sort, '-') ? 'desc' : 'asc';
        $col  = ltrim($sort, '-');
        return [$col, $dir];
    }
}
