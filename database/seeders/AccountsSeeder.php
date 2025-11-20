<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class AccountsSeeder extends Seeder
{
    private const TYPE_ASSET     = 'ASSET';
    private const TYPE_LIABILITY = 'LIABILITY';
    private const TYPE_EQUITY    = 'EQUITY';
    private const TYPE_REVENUE   = 'REVENUE';
    private const TYPE_EXPENSE   = 'EXPENSE';

    private const NB_DEBIT  = 'DEBIT';
    private const NB_CREDIT = 'CREDIT';

    private function normalBalance(string $type): string
    {
        return in_array($type, [self::TYPE_ASSET, self::TYPE_EXPENSE], true)
            ? self::NB_DEBIT
            : self::NB_CREDIT;
    }

    public function run(): void
    {
        $now = Carbon::now();

        // Definisi COA (pakai parent_code → jadi parent_id)
        $rows = [
            // ===== ASET
            ['code' => '1000', 'name' => 'ASET',                 'type' => self::TYPE_ASSET,     'parent_code' => null],
            ['code' => '1100', 'name' => 'Kas & Bank',           'type' => self::TYPE_ASSET,     'parent_code' => '1000'],
            ['code' => '1110', 'name' => 'Kas (Cash on Hand)',   'type' => self::TYPE_ASSET,     'parent_code' => '1100'],
            ['code' => '1120', 'name' => 'Bank',                 'type' => self::TYPE_ASSET,     'parent_code' => '1100'],
            ['code' => '1200', 'name' => 'Piutang Usaha',        'type' => self::TYPE_ASSET,     'parent_code' => '1000'],
            ['code' => '1400', 'name' => 'Persediaan Barang',    'type' => self::TYPE_ASSET,     'parent_code' => '1000'],

            // ===== KEWAJIBAN
            ['code' => '2000', 'name' => 'KEWAJIBAN',            'type' => self::TYPE_LIABILITY, 'parent_code' => null],
            ['code' => '2100', 'name' => 'Hutang Usaha',         'type' => self::TYPE_LIABILITY, 'parent_code' => '2000'],

            // ===== EKUITAS
            ['code' => '3000', 'name' => 'EKUITAS',              'type' => self::TYPE_EQUITY,    'parent_code' => null],
            ['code' => '3100', 'name' => 'Modal Pemilik',        'type' => self::TYPE_EQUITY,    'parent_code' => '3000'],
            ['code' => '3200', 'name' => 'Laba Ditahan',         'type' => self::TYPE_EQUITY,    'parent_code' => '3000'],

            // ===== PENDAPATAN
            ['code' => '4000', 'name' => 'PENDAPATAN',           'type' => self::TYPE_REVENUE,   'parent_code' => null],
            ['code' => '4100', 'name' => 'Penjualan',            'type' => self::TYPE_REVENUE,   'parent_code' => '4000'],
            // Diskon penjualan (contra-revenue) tetap type REVENUE
            ['code' => '4200', 'name' => 'Diskon Penjualan (-)', 'type' => self::TYPE_REVENUE,   'parent_code' => '4000'],

            // ===== HPP & BEBAN
            ['code' => '5000', 'name' => 'HARGA POKOK PENJUALAN', 'type' => self::TYPE_EXPENSE,   'parent_code' => null],
            ['code' => '5100', 'name' => 'HPP',                  'type' => self::TYPE_EXPENSE,   'parent_code' => '5000'],

            ['code' => '6000', 'name' => 'BEBAN OPERASIONAL',    'type' => self::TYPE_EXPENSE,   'parent_code' => null],
            ['code' => '6100', 'name' => 'Beban Listrik & Air',  'type' => self::TYPE_EXPENSE,   'parent_code' => '6000'],
            ['code' => '6200', 'name' => 'Beban Sewa',           'type' => self::TYPE_EXPENSE,   'parent_code' => '6000'],
            ['code' => '6300', 'name' => 'Beban Gaji',           'type' => self::TYPE_EXPENSE,   'parent_code' => '6000'],
        ];

        $idsByCode = [];
        $pending = collect($rows);
        $maxPass = 10;

        while ($pending->isNotEmpty() && $maxPass-- > 0) {
            $insertedThisPass = collect();

            foreach ($pending as $row) {
                $parentId = null;
                if (!empty($row['parent_code'])) {
                    if (!isset($idsByCode[$row['parent_code']])) {
                        continue; // tunggu sampai parent dibuat
                    }
                    $parentId = $idsByCode[$row['parent_code']];
                }

                $type = $row['type'];
                $payload = [
                    'code'           => $row['code'],
                    'name'           => $row['name'],
                    'type'           => $type,
                    'parent_id'      => $parentId,
                    'normal_balance' => $this->normalBalance($type), // <-- WAJIB
                    'is_active'      => true,
                    'updated_at'     => $now,
                ];

                $exists = DB::table('accounts')->where('code', $row['code'])->first();

                if (!$exists) {
                    $payload['created_at'] = $now;
                    $id = DB::table('accounts')->insertGetId($payload);
                } else {
                    DB::table('accounts')->where('id', $exists->id)->update($payload);
                    $id = $exists->id;
                }

                $idsByCode[$row['code']] = $id;
                $insertedThisPass->push($row['code']);
            }

            if ($insertedThisPass->isNotEmpty()) {
                $pending = $pending->reject(fn($r) => $insertedThisPass->contains($r['code']));
            } else {
                break; // tidak ada progress: kemungkinan parent_code salah
            }
        }

        if ($pending->isNotEmpty()) {
            $codes = $pending->pluck('code')->implode(', ');
            throw new \RuntimeException("Gagal menyusun COA karena parent belum tersedia untuk code: {$codes}. Periksa 'parent_code'.");
        }
    }
}
