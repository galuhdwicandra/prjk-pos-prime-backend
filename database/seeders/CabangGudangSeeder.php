<?php

namespace Database\Seeders;

use App\Models\Cabang;
use App\Models\Gudang;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CabangGudangSeeder extends Seeder
{
    public function run(): void
    {
        DB::transaction(function () {
            /** @var Cabang $cabang */
            $cabang = Cabang::query()->first() ?? Cabang::create([
                'nama' => 'Cabang Pusat',
                'kota' => 'Bandung',
                'alamat' => 'Jl. Contoh No. 1',
                'telepon' => '081234567890',
                'jam_operasional' => 'Senin-Minggu 08:00-21:00',
                'is_active' => true,
            ]);

            // pastikan ada satu gudang default
            $hasDefault = $cabang->gudangs()->where('is_default', true)->exists();
            if (!$hasDefault) {
                Gudang::create([
                    'cabang_id' => $cabang->id,
                    'nama' => 'Gudang Utama',
                    'is_default' => true,
                    'is_active' => true,
                ]);
            }
        });
    }
}
