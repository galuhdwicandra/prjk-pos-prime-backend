<?php

namespace App\Policies;

use App\Models\Gudang;
use App\Models\User;

class GudangPolicy
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
        return in_array($user->role, ['admin_cabang','gudang','kasir','sales','kurir','superadmin'], true);
    }

    public function view(User $user, Gudang $gudang): bool
    {
        if ($user->role === 'admin_cabang' || in_array($user->role, ['gudang','kasir','sales','kurir'], true)) {
            return $user->cabang_id === $gudang->cabang_id;
        }
        return false;
    }

    public function create(User $user): bool
    {
        return in_array ($user->role, ['admin_cabang','gudang'], true);
    }

    public function update(User $user, Gudang $gudang): bool
    {
        if ($user->role === 'admin_cabang') {
            return $user->cabang_id === $gudang->cabang_id;
        }
        return false;
    }

    public function delete(User $user, Gudang $gudang): bool
    {
        if ($user->role === 'admin_cabang') {
            return $user->cabang_id === $gudang->cabang_id;
        }
        return false;
    }
}
