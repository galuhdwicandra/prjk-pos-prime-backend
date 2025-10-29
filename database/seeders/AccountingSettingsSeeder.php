<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class AccountingSettingsSeeder extends Seeder
{
    /**
     * Ambil id akun dari code COA. Throw jika tidak ketemu agar cepat ketahuan.
     */
    private function accountIdByCode(string $code): int
    {
        $row = DB::table('accounts')->where('code', $code)->select('id')->first();
        if (!$row) {
            throw new \RuntimeException("Akun dengan code {$code} tidak ditemukan. Pastikan AccountsSeeder sudah jalan.");
        }
        return (int) $row->id;
    }

    public function run(): void
    {
        $now = Carbon::now();

        // Map kunci setting -> kode COA
        // (Silakan sesuaikan kode COA kalau struktur COA-mu beda)
        $map = [
            'acc.cash_id'        => '1110', // Kas (Cash on Hand)
            'acc.bank_id'        => '1120', // Bank
            'acc.sales_id'       => '4100', // Penjualan
            'acc.fee_expense_id' => '6000', // Beban Operasional (atau ganti ke 61xx khusus fee)
            'acc.fee_payable_id' => '2100', // Hutang Usaha (atau kodenya khusus fee payable)
        ];

        foreach ($map as $key => $code) {
            $accountId = $this->accountIdByCode($code);

            DB::table('settings')->updateOrInsert(
                [
                    'scope'    => 'GLOBAL',
                    'scope_id' => null,
                    'key'      => $key,
                ],
                [
                    'value_json' => json_encode(['id' => $accountId], JSON_UNESCAPED_UNICODE),
                    'updated_at' => $now,
                    'created_at' => $now,
                ]
            );
        }
    }
}
