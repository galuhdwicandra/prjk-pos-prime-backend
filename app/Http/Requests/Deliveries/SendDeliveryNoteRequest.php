<?php

namespace App\Http\Requests\Deliveries;

use Illuminate\Foundation\Http\FormRequest;

class SendDeliveryNoteRequest extends FormRequest
{
    public function authorize(): bool
    {
        // Otorisasi pakai policy di controller (sendSuratJalan)
        return true;
    }

    protected function prepareForValidation(): void
    {
        if ($this->has('message')) {
            $this->merge([
                'message' => trim((string)$this->input('message')),
            ]);
        }
    }

    public function rules(): array
    {
        return [
            'message' => ['nullable', 'string', 'max:3000'],
        ];
    }
}
