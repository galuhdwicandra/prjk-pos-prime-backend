<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PaymentStoreRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        return [
            'method' => ['required','in:CASH,TRANSFER,QRIS,XENDIT'],
            'amount' => ['required','numeric','gt:0'],
            'ref_no' => ['nullable','string','max:191'],
            'payload_json' => ['nullable','array'],
        ];
    }
}
