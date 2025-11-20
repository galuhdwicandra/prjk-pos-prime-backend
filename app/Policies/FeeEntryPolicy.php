<?php

namespace App\Policies;

use App\Models\User;
use App\Models\FeeEntry;

class FeeEntryPolicy
{

    private function has(User $u, string $role): bool
    {
        // accept either Spatie role name OR users.role column
        return $u->hasRole($role) || ($u->role === $role);
    }
    private function isSuper(User $u): bool
    {
        return $this->has($u, 'superadmin');
    }
    private function isAdminCab(User $u): bool
    {
        return $this->has($u, 'admin_cabang');
    }
    private function isKasir(User $u): bool
    {
        return $this->has($u, 'kasir');
    }
    private function isKurir(User $u): bool
    {
        return $this->has($u, 'kurir');
    }
    private function isSales(User $u): bool
    {
        return $this->has($u, 'sales');
    }
    public function viewAny(User $user): bool
    {
        return $this->isSuper($user)
            || $this->isAdminCab($user)
            || $this->isSales($user)
            || $this->isKasir($user)
            || $this->isKurir($user);
    }

    public function view(User $user, FeeEntry $entry): bool
    {
        if ($this->isSales($user) || $this->isKasir($user) || $this->isKurir($user)) {
            return $entry->owner_user_id === $user->id;
        }
        // Admins: branch-level or superadmin
        return $this->isSuper($user)
            || ($this->isAdminCab($user) && ($user->cabang_id ?? null) === $entry->cabang_id);
    }

    public function updateStatus(User $user, FeeEntry $entry): bool
    {
        // Only admins can mark paid
        return $this->isSuper($user) || $this->isAdminCab($user);
    }

    public function export(User $user): bool
    {
        return $this->isSuper($user) || $this->isAdminCab($user);
    }
}
