<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class SetPrimaryProductMediaRequest extends FormRequest
{
    public function authorize(): bool
    {
        $product = $this->route('product');
        return $this->user()?->can('update', $product) ?? false;
    }

    public function rules(): array
    {
        return [
            'media_id' => ['required', 'exists:product_media,id'],
        ];
    }
}
