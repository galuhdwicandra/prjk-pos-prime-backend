<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class FeeStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->can('create', \App\Models\Fee::class);
    }

    public function rules(): array
    {
        return [
            'cabang_id' => ['required', 'integer', 'exists:cabangs,id'],
            'name'      => ['required', 'string', 'max:100'],
            'kind'      => ['required', 'in:SALES,CASHIER,COURIER'],
            'calc_type' => ['required', 'in:PERCENT,FIXED'],
            'rate'      => ['required', 'numeric', 'min:0'],
            'base'      => ['required', 'in:GRAND_TOTAL,DELIVERY'],
            'is_active' => ['required', 'boolean'],
        ];
    }

    public function withValidator($v)
    {
        $v->after(function ($v) {
            $calc = $this->input('calc_type');
            $rate = (float) $this->input('rate', 0);
            if ($calc === 'PERCENT' && $rate > 100) {
                $v->errors()->add('rate', 'Rate persentase tidak boleh lebih dari 100.');
            }
        });
    }
}
