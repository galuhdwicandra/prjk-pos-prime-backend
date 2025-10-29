<?php

namespace App\Http\Requests\Customer;

use Illuminate\Foundation\Http\FormRequest;

class CustomerUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        $customer = $this->route('customer');
        return $this->user()->can('update', $customer);
    }

    public function rules(): array
    {
        $customer = $this->route('customer');
        $cabangId = (int)($this->user()->cabang_id);

        return [
            'nama'   => ['required', 'string', 'max:120'],
            'phone'  => ['required', 'string', 'max:30', "unique:customers,phone,{$customer->id},id,cabang_id,{$cabangId}"],
            'email'  => ['nullable', 'email', 'max:190'],
            'alamat' => ['nullable', 'string', 'max:255'],
            'catatan' => ['nullable', 'string', 'max:255'],
            'stage'  => ['nullable', 'in:LEAD,ACTIVE,CHURN'],
        ];
    }
}
