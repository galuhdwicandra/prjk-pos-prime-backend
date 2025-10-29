<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class OrderSetCashPositionRequest extends FormRequest
{
    public function authorize(): bool
    {
        /** @var \App\Models\Order|null $order */
        $order = $this->route('order'); // pastikan nama param route = 'order'
        return $this->user()?->can('setCashPosition', $order) ?? false;
    }

    public function rules(): array
    {
        return [
            'cash_position' => ['required', 'string', 'in:CUSTOMER,CASHIER,SALES,ADMIN'],
        ];
    }
}
