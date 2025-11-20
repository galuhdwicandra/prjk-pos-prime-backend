<?php

namespace App\Http\Requests\Dashboard;

use Illuminate\Foundation\Http\FormRequest;

class CommonQuery extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'branch_id' => ['nullable', 'integer'], // accepted input name
            'from' => ['nullable', 'date'],
            'to' => ['nullable', 'date', 'after_or_equal:from'],
            'limit' => ['nullable', 'integer', 'between:1,50'],
            'threshold' => ['nullable', 'numeric', 'min:0'],
        ];
    }

    public function branchIdOrUser(): ?int
    {
        // prioritaskan cabang_id (frontend baru), fallback branch_id (legacy), lalu cabang user
        $fromInput = $this->integer('cabang_id') ?: $this->integer('branch_id');
        if ($fromInput) return (int) $fromInput;

        return $this->user()->cabang_id ? (int) $this->user()->cabang_id : null;
    }

    public function dateRange(): array
    {
        $from = $this->input('from');
        $to   = $this->input('to');
        return [
            $from ? now()->parse($from)->startOfDay() : now()->startOfDay(),
            $to ? now()->parse($to)->endOfDay() : now()->endOfDay()
        ];
    }
}
