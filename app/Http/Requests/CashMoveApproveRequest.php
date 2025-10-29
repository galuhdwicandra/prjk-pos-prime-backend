<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CashMoveApproveRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->can('approve', $this->route('move'));
    }
    public function rules(): array
    {
        return ['approved_at' => ['nullable', 'date']];
    }
}
