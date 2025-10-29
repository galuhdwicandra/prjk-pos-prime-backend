<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class VariantStockStoreRequest extends FormRequest
{
    public function authorize(): bool { return true; } // via Controller->authorize() by policy

    public function rules(): array
    {
        return [
            'gudang_id'          => ['required','integer','exists:gudangs,id'],
            'product_variant_id' => ['required','integer','exists:product_variants,id'],
            'qty'                => ['required','integer','min:0'],
            'min_stok'           => ['nullable','integer','min:0'],
        ];
    }

    public function messages(): array
    {
        return [
            'gudang_id.required' => 'Gudang wajib dipilih.',
            'product_variant_id.required' => 'Varian wajib dipilih.',
            'qty.required' => 'Jumlah stok awal wajib diisi.',
        ];
    }
}
