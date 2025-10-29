<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class FeeUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        $fee = $this->route('fee'); // model binding
        return $this->user()->can('update', $fee);
    }

    public function rules(): array
    {
        return [
            'cabang_id' => ['sometimes', 'integer', 'exists:cabangs,id'],
            'name'      => ['sometimes', 'string', 'max:100'],
            'kind'      => ['sometimes', 'in:SALES,CASHIER,COURIER'],
            'calc_type' => ['sometimes', 'in:PERCENT,FIXED'],
            'rate'      => ['sometimes', 'numeric', 'min:0'],
            'base'      => ['sometimes', 'in:GRAND_TOTAL,DELIVERY'],
            'is_active' => ['sometimes', 'boolean'],
        ];
    }

    public function withValidator($v)
    {
        $v->after(function ($v) {
            $calc = $this->input('calc_type');
            if ($calc === 'PERCENT' && $this->has('rate')) {
                $rate = (float) $this->input('rate', 0);
                if ($rate > 100) {
                    $v->errors()->add('rate', 'Rate persentase tidak boleh lebih dari 100.');
                }
            }
        });
    }
}
