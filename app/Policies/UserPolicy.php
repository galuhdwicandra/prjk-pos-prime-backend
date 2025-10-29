<?php

// app/Policies/UserPolicy.php
namespace App\Policies;

use App\Models\User;

class UserPolicy
{
    // superadmin = all; admin_cabang = same cabang (non-superadmin)
    public function viewAny(User $actor): bool
    {
        // sebelumnya hanya superadmin & admin_cabang
        // tambahkan kasir, karena kasir di FE boleh assign kurir
        return in_array($actor->role, ['superadmin', 'admin_cabang', 'kasir', 'gudang'], true);
    }

    public function view(User $actor, User $target): bool
    {
        if ($actor->role === 'superadmin')
            return true;
        if ($actor->role === 'admin_cabang') {
            return $actor->cabang_id && $actor->cabang_id === $target->cabang_id && $target->role !== 'superadmin';
        }
        // user biasa bisa lihat dirinya sendiri
        return $actor->id === $target->id;
    }

    public function create(User $actor): bool
    {
        return in_array($actor->role, ['superadmin', 'admin_cabang']);
    }

    public function update(User $actor, User $target): bool
    {
        if ($actor->role === 'superadmin')
            return true;
        if ($actor->role === 'admin_cabang') {
            return $actor->cabang_id && $actor->cabang_id === $target->cabang_id && $target->role !== 'superadmin';
        }
        // role selain dua di atas hanya boleh update dirinya sendiri (profil)
        return $actor->id === $target->id;
    }

    public function delete(User $actor, User $target): bool
    {
        if ($actor->id === $target->id)
            return false; // tidak boleh hapus diri sendiri
        if ($actor->role === 'superadmin')
            return true;
        if ($actor->role === 'admin_cabang') {
            return $actor->cabang_id && $actor->cabang_id === $target->cabang_id && $target->role !== 'superadmin';
        }
        return false;
    }

    // Tidak pakai restore/forceDelete khusus (hard delete only). Tambahkan jika perlu.
}
