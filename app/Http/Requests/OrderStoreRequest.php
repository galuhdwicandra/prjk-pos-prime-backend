<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class OrderStoreRequest extends FormRequest
{
    public function authorize(): bool { return true; } // pakai Policy di Controller

    public function rules(): array
    {
        return [
            'cabang_id' => ['required','integer'],
            'gudang_id' => ['required','integer'],
            'customer_id' => ['nullable','integer'],
            'note' => ['nullable','string','max:2000'],
            'ordered_at' => ['nullable','date'],

            'items' => ['required','array','min:1'],
            'items.*.variant_id' => ['required','integer','min:1'],
            'items.*.qty' => ['required','numeric','gt:0'],
            'items.*.discount' => ['nullable','numeric','min:0'],
            // input hint (opsional) dari client, tidak dipakai sebagai kebenaran
            'items.*.price_hint' => ['nullable','numeric','min:0'],

            // optional immediate payment saat checkout
            'cash_position' => ['nullable','string','in:CUSTOMER,CASHIER,SALES,ADMIN'],
            'payment' => ['nullable','array'],
            'payment.method' => ['required_with:payment','in:CASH,TRANSFER,QRIS,XENDIT'],
            'payment.amount' => ['required_with:payment','numeric','gt:0'],
        ];
    }
}
