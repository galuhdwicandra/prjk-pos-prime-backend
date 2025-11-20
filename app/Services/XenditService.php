<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;

class XenditService
{
    public function __construct(
        private string $baseUrl = '',
        private string $secret = '',
        private string $cbToken = '',
        private string $successUrl = '',
        private string $failureUrl = ''
    ) {
        $this->baseUrl    = config('services.xendit.base_url', env('XENDIT_BASE_URL'));
        $this->secret     = config('services.xendit.secret', env('XENDIT_SECRET_KEY'));
        $this->cbToken    = config('services.xendit.callback_token', env('XENDIT_CALLBACK_TOKEN'));
        $this->successUrl = env('XENDIT_SUCCESS_URL');
        $this->failureUrl = env('XENDIT_FAILURE_URL');
    }

    /** Buat invoice Xendit, kembalikan array: ['ref_no' => string, 'checkout_url' => string, 'raw' => array] */
    public function createInvoice(array $payload): array
    {
        // $payload minimal: amount, description, external_id
        $resp = Http::withBasicAuth($this->secret, '')
            ->acceptJson()
            ->post(rtrim($this->baseUrl, '/') . '/v2/invoices', [
                'external_id' => $payload['external_id'],
                'amount' => (int) $payload['amount'],
                'description' => $payload['description'] ?? 'Order Payment',
                'success_redirect_url' => $this->successUrl,
                'failure_redirect_url' => $this->failureUrl,
            ]);

        $data = $resp->throw()->json();

        return [
            'ref_no'       => (string)($data['id'] ?? $data['invoice_id'] ?? ''),
            'checkout_url' => (string)($data['invoice_url'] ?? $data['checkout_url'] ?? ''),
            'raw'          => $data,
        ];
    }

    /** Validasi header callback token dari Xendit */
    public function isValidCallback(string $headerToken = null): bool
    {
        return $headerToken && hash_equals($this->cbToken, $headerToken);
    }
}
