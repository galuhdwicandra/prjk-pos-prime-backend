<?php

namespace App\Policies;

use App\Models\User;
use App\Models\CashMove;

class CashMovePolicy
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
    public function view(User $user, CashMove $m): bool
    {
        return $this->viewAny($user);
    }
    public function create(User $user): bool
    {
        return $user->hasAnyRole(['kasir', 'sales', 'kurir'])
            || $user->can('cash.create');
    }
    public function approve(User $user, CashMove $m): bool
    {
        return $user->hasAnyRole(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang'])
            || $user->can('cash.approve');
    }
    public function reject(User $user, CashMove $m): bool
    {
        return $this->approve($user, $m);
    }
    public function delete(User $user, CashMove $m): bool
    {
        return $user->hasAnyRole(['superadmin']) || $user->can('cash.delete');
    }
}
