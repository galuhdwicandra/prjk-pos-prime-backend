<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CabangStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        // hanya superadmin (handled by policy via controller) -> return true lalu controller->authorize('create', Cabang::class)
        return true;
    }

    public function rules(): array
    {
        return [
            'nama' => ['required','string','max:120'],
            'kota' => ['nullable','string','max:120'],
            'alamat' => ['nullable','string','max:255'],
            'telepon' => ['nullable','string','max:30'],
            'jam_operasional' => ['nullable','string','max:120'],
            'is_active' => ['sometimes','boolean'],
        ];
    }
}
