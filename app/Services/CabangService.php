<?php

namespace App\Services;

use App\Models\Cabang;
use App\Models\Gudang;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Support\Facades\DB;

class CabangService
{
    public function queryIndexForUser($user): Builder
    {
        // superadmin lihat semua; selain itu hanya cabangnya sendiri
        return Cabang::query()
            ->when($user->role !== 'superadmin', fn ($q) => $q->where('id', $user->cabang_id));
    }

    public function create(array $data): Cabang
    {
        return DB::transaction(function () use ($data) {
            /** @var Cabang $cabang */
            $cabang = Cabang::create([
                'nama' => $data['nama'],
                'kota' => $data['kota'] ?? null,
                'alamat' => $data['alamat'] ?? null,
                'telepon' => $data['telepon'] ?? null,
                'jam_operasional' => $data['jam_operasional'] ?? null,
                'is_active' => $data['is_active'] ?? true,
            ]);

            // auto-create gudang default
            Gudang::create([
                'cabang_id' => $cabang->id,
                'nama' => 'Gudang Utama',
                'is_default' => true,
                'is_active' => true,
            ]);

            return $cabang->fresh(['gudangs']);
        });
    }

    public function update(Cabang $cabang, array $data): Cabang
    {
        $cabang->fill($data)->save();
        return $cabang->fresh();
    }

    public function delete(Cabang $cabang): void
    {
        // FK gudangs cascade delete; users.cabang_id set null (jika FK nullOnDelete diterapkan)
        $cabang->delete();
    }
}
