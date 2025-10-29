<?php

namespace App\Services;

use App\Models\Gudang;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class GudangService
{
    public function queryIndexForUser($user): Builder
    {
        return Gudang::query()
            ->when($user->role !== 'superadmin', fn ($q) => $q->where('cabang_id', $user->cabang_id));
    }

    public function create(array $data, $user): Gudang
    {
        // Admin Cabang hanya boleh di cabang miliknya
        if ($user->role === 'admin_cabang' && (int)$data['cabang_id'] !== (int)$user->cabang_id) {
            throw ValidationException::withMessages(['cabang_id' => 'Tidak diizinkan membuat gudang di cabang lain.']);
        }

        return DB::transaction(function () use ($data) {
            /** @var Gudang $gudang */
            $gudang = Gudang::create([
                'cabang_id'  => $data['cabang_id'],
                'nama'       => $data['nama'],
                'is_default' => (bool)($data['is_default'] ?? false),
                'is_active'  => (bool)($data['is_active'] ?? true),
            ]);

            if ($gudang->is_default) {
                // matikan default lainnya
                Gudang::where('cabang_id', $gudang->cabang_id)
                    ->where('id', '!=', $gudang->id)
                    ->where('is_default', true)
                    ->update(['is_default' => false]);
            } else {
                // jika belum ada default di cabang ini, set yang baru ini jadi default
                $hasDefault = Gudang::where('cabang_id', $gudang->cabang_id)->where('is_default', true)->exists();
                if (!$hasDefault) {
                    $gudang->is_default = true;
                    $gudang->save();
                }
            }

            return $gudang->fresh();
        });
    }

    public function update(Gudang $gudang, array $data, $user): Gudang
    {
        if ($user->role === 'admin_cabang' && (int)$gudang->cabang_id !== (int)$user->cabang_id) {
            throw ValidationException::withMessages(['gudang' => 'Tidak diizinkan mengubah gudang di cabang lain.']);
        }

        return DB::transaction(function () use ($gudang, $data) {
            $gudang->fill($data)->save();

            if (array_key_exists('is_default', $data) && $gudang->is_default) {
                Gudang::where('cabang_id', $gudang->cabang_id)
                    ->where('id', '!=', $gudang->id)
                    ->where('is_default', true)
                    ->update(['is_default' => false]);
            }

            // pastikan selalu ada default
            $hasDefault = Gudang::where('cabang_id', $gudang->cabang_id)->where('is_default', true)->exists();
            if (!$hasDefault) {
                $gudang->is_default = true;
                $gudang->save();
            }

            return $gudang->fresh();
        });
    }

    public function delete(Gudang $gudang, $user): void
    {
        if ($user->role === 'admin_cabang' && (int)$gudang->cabang_id !== (int)$user->cabang_id) {
            throw ValidationException::withMessages(['gudang' => 'Tidak diizinkan menghapus gudang di cabang lain.']);
        }

        DB::transaction(function () use ($gudang) {
            $cabangId = $gudang->cabang_id;
            $wasDefault = $gudang->is_default;

            $gudang->delete();

            if ($wasDefault) {
                $another = Gudang::where('cabang_id', $cabangId)->orderBy('id')->first();
                if ($another && !$another->is_default) {
                    $another->is_default = true;
                    $another->save();
                }
            }
        });
    }
}
