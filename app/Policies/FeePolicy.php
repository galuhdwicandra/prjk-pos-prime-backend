<?php

namespace App\Policies;

use App\Models\Fee;
use App\Models\User;

class FeePolicy
{
    public function before(User $user, $ability)
    {
        // Jika punya role superadmin → full akses
        if ($user->hasRole('superadmin')) {
            return true;
        }
    }

    public function viewAny(User $user): bool
    {
        // admin_cabang boleh lihat fee cabangnya
        return $user->hasAnyRole(['admin_cabang','kasir','sales']);
    }

    public function view(User $user, Fee $fee): bool
    {
        if ($user->hasRole('admin_cabang')) {
            return $user->cabang_id === $fee->cabang_id;
        }
        return false;
    }

    public function create(User $user): bool
    {
        return $user->hasAnyRole(['admin_cabang']);
    }

    public function update(User $user, Fee $fee): bool
    {
        if ($user->hasRole('admin_cabang')) {
            return $user->cabang_id === $fee->cabang_id;
        }
        return false;
    }

    public function delete(User $user, Fee $fee): bool
    {
        if ($user->hasRole('admin_cabang')) {
            return $user->cabang_id === $fee->cabang_id;
        }
        return false;
    }
}
