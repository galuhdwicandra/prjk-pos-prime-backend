<?php

namespace App\Http\Requests\Customer;

use Illuminate\Foundation\Http\FormRequest;

class CustomerStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->can('create', \App\Models\Customer::class);
    }

    public function rules(): array
    {
        $cabangId = (int)($this->user()->cabang_id);

        return [
            'nama'   => ['required', 'string', 'max:120'],
            'phone'  => ['required', 'string', 'max:30', "unique:customers,phone,NULL,id,cabang_id,{$cabangId}"],
            'email'  => ['nullable', 'email', 'max:190'],
            'alamat' => ['nullable', 'string', 'max:255'],
            'catatan' => ['nullable', 'string', 'max:255'],
            'stage'  => ['nullable', 'in:LEAD,ACTIVE,CHURN'],
        ];
    }

    public function prepareForValidation(): void
    {
        $user = $this->user();
        if ($user->hasRole(['kasir', 'sales'])) {
            $this->merge(['cabang_id' => $user->cabang_id]);
        }
    }
}
