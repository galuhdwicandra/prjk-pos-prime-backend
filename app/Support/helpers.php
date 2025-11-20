<?php

use Illuminate\Support\Facades\Config;

if (!function_exists('setting')) {
    function setting(string $key, $default = null)
    {
        $map = [
            'acc.cash_id'        => 'accounting.cash_id',
            'acc.bank_id'        => 'accounting.bank_id',
            'acc.sales_id'       => 'accounting.sales_id',
            'acc.fee_expense_id' => 'accounting.fee_expense_id',
            'acc.fee_payable_id' => 'accounting.fee_payable_id',
        ];
        $confKey = $map[$key] ?? $key;

        try {
            /** @var \App\Services\SettingService $svc */
            $svc = app(\App\Services\SettingService::class);
            $val = $svc->get($key, null, null); // GLOBAL
            if ($val !== null) {
                if (is_array($val) && array_key_exists('id', $val)) return $val['id'];
                return $val;
            }
        } catch (\Throwable $e) {
            // diam, lanjut ke config fallback
        }

        return Config::get($confKey, $default);
    }
}
