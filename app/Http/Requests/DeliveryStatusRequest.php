<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class DeliveryStatusRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'status' => ['required', Rule::in(['REQUESTED', 'ASSIGNED', 'PICKED_UP', 'ON_ROUTE', 'DELIVERED', 'FAILED', 'CANCELLED'])],
            'note'   => ['nullable', 'string'],
        ];
    }
}
