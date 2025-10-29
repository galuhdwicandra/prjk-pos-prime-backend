<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use App\Models\Delivery;
use App\Models\User;

class DeliveryAssignRequest extends FormRequest
{
    public function authorize(): bool
    {
        // Controller sudah panggil $this->authorize('assign', $delivery)
        // jadi di sini boleh true.
        return true;
    }

    protected function prepareForValidation(): void
    {
        // Normalisasi input agar rules boolean/integer konsisten
        $auto = $this->input('auto', false);
        $assigned = $this->input('assigned_to', null);

        $this->merge([
            'auto' => filter_var($auto, FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE) ?? false,
            'assigned_to' => $assigned !== null && $assigned !== '' ? (int) $assigned : null,
        ]);
    }

    public function rules(): array
    {
        // Ambil delivery dari route param (deliveries/{id}/assign)
        $deliveryId = (int) $this->route('id');
        $delivery = Delivery::with('order:id,cabang_id')->find($deliveryId);

        return [
            'auto' => ['sometimes', 'boolean'],
            'assigned_to' => [
                // Wajib isi salah satu: assigned_to ATAU auto
                'nullable',
                'integer',
                'required_without:auto',
                // opsional: kalau kamu ingin memaksa user TIDAK mengisi keduanya bersamaan:
                // 'prohibited_if:auto,true',
                'exists:users,id',
                function (string $attr, $value, \Closure $fail) use ($delivery) {
                    if ($value === null) return;

                    $user = User::query()->select(['id', 'role', 'cabang_id'])->find($value);
                    if (!$user) return;

                    if ($user->role !== 'kurir') {
                        $fail('User yang dipilih bukan kurir.');
                        return;
                    }
                    if ($delivery && $delivery->order && $user->cabang_id !== $delivery->order->cabang_id) {
                        $fail('Kurir harus dari cabang yang sama dengan order.');
                    }
                },
            ],
        ];
    }

    public function messages(): array
    {
        return [
            'assigned_to.required_without' => 'Pilih kurir atau aktifkan auto-assign.',
            'assigned_to.exists' => 'Kurir tidak ditemukan.',
        ];
    }
}
