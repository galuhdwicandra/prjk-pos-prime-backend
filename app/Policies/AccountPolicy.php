<?php

namespace App\Policies;

use App\Models\User;
use App\Models\Account;

class AccountPolicy
{
    public function viewAny(User $u): bool
    {
        return $u->hasAnyRoleCompat(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang', 'kasir']);
    }

    public function view(User $u, Account $m): bool
    {
        return $this->viewAny($u);
    }

    public function create(User $u): bool
    {
        return $u->hasAnyRoleCompat(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang']);
    }

    public function update(User $u, Account $m): bool
    {
        return $u->hasAnyRoleCompat(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang']);
    }

    public function delete(User $u, Account $m): bool
    {
        return $u->hasAnyRoleCompat(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang']);
    }
}
