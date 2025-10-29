<?php

namespace App\Policies;

use App\Models\User;

class DashboardPolicy
{
    public function view(User $user): bool
    {
        // Selaras dengan FE: superadmin, admin_cabang, kasir, sales
        if (method_exists($user, 'hasAnyRole')) {
            return $user->hasAnyRole(['superadmin', 'admin_cabang', 'kasir', 'sales']);
        }

        // fallback sederhana bila helper role tidak tersedia
        return true;
    }
}
