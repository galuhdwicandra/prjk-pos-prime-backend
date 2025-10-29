<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CabangUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'nama' => ['sometimes','string','max:120'],
            'kota' => ['sometimes','nullable','string','max:120'],
            'alamat' => ['sometimes','nullable','string','max:255'],
            'telepon' => ['sometimes','nullable','string','max:30'],
            'jam_operasional' => ['sometimes','nullable','string','max:120'],
            'is_active' => ['sometimes','boolean'],
        ];
    }
}
