<?php

namespace App\Policies;

use App\Models\User;
use App\Models\ProductMedia;

class ProductMediaPolicy
{
    private function isRole(User $user, array $roles): bool
    {
        // Spatie: return $user->hasAnyRole($roles);
        return in_array($user->role ?? '', $roles, true);
    }

    public function viewAny(User $user): bool
    {
        return $this->isRole($user, ['superadmin', 'admin_cabang', 'gudang', 'kasir', 'sales']);
    }

    public function view(User $user, ProductMedia $media): bool
    {
        return $this->viewAny($user);
    }

    public function create(User $user): bool
    {
        return $this->isRole($user, ['superadmin', 'admin_cabang']);
    }

    public function update(User $user, ProductMedia $media): bool
    {
        return $this->isRole($user, ['superadmin', 'admin_cabang']);
    }

    public function delete(User $user, ProductMedia $media): bool
    {
        return $this->isRole($user, ['superadmin', 'admin_cabang']);
    }
}
