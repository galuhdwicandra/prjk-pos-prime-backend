<?php

namespace App\Policies;

use App\Models\User;
use App\Models\CashHolder;

class CashHolderPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->hasAnyRole([
            'superadmin',
            'admin cabang',
            'admin_cabang',
            'admin-cabang',
            'kasir',
            'sales',
            'kurir',
        ]) || $user->can('cash.view');
    }

    public function create(User $user): bool
    {
        return $user->hasAnyRole(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang'])
            || $user->can('cash.holder.create');
    }
}
