<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UploadProductMediaRequest extends FormRequest
{
    public function authorize(): bool
    {
        $product = $this->route('product');
        return $this->user()?->can('update', $product) ?? false;
    }

    public function rules(): array
    {
        return [
            // allow EITHER files[] array OR single file
            'file'     => ['sometimes', 'image', 'max:5120'], // 5MB
            'files'    => ['sometimes', 'array', 'min:1', 'max:10'],
            'files.*'  => ['file', 'mimetypes:image/jpeg,image/png,image/webp', 'max:5120'],
        ];
    }
}
