<?php

namespace App\Policies;

use App\Models\Cabang;
use App\Models\User;

class CabangPolicy
{
    public function before(User $user, string $ability)
    {
        if ($user->role === 'superadmin') {
            return true;
        }
        return null;
    }

    public function viewAny(User $user): bool
    {
        // Semua role boleh melihat daftar cabang,
        // tapi Admin Cabang dan role non-superadmin hanya melihat cabangnya sendiri (dibatasi di query/controller).
        return in_array($user->role, ['admin_cabang', 'gudang', 'kasir', 'sales', 'kurir', 'superadmin'], true);
    }

    public function view(User $user, Cabang $cabang): bool
    {
        if ($user->role === 'admin_cabang') {
            return $user->cabang_id === $cabang->id;
        }
        // role lain (gudang/kasir/sales/kurir) hanya boleh lihat kalau 1 cabang yang sama
        if (in_array($user->role, ['gudang','kasir','sales','kurir'], true)) {
            return $user->cabang_id === $cabang->id;
        }
        return false;
    }

    public function create(User $user): bool
    {
        // hanya superadmin (handled by before) atau admin_cabang? -> cabang baru biasanya dibuat pusat
        // jika ingin izinkan admin_cabang membuat sub-cabang, ubah ke true sesuai kebutuhan
        return false;
    }

    public function update(User $user, Cabang $cabang): bool
    {
        if ($user->role === 'admin_cabang') {
            return $user->cabang_id === $cabang->id;
        }
        return false;
    }

    public function delete(User $user, Cabang $cabang): bool
    {
        if ($user->role === 'admin_cabang') {
            // Admin cabang tidak boleh hapus cabangnya sendiri (umumnya kebijakan bisnis)
            return false;
        }
        return false;
    }
}
