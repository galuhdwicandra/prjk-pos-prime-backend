<?php

namespace App\Policies;

use App\Models\Category;
use App\Models\User;

class CategoryPolicy
{
    public function before(User $user, string $ability): bool|null
    {
        // superadmin full access
        if ($user->role === 'superadmin') {
            return true;
        }
        return null;
    }

    public function viewAny(User $user): bool
    {
        // semua role boleh melihat daftar kategori
        return in_array($user->role, ['superadmin', 'admin_cabang', 'gudang', 'kasir', 'sales', 'kurir'], true);
    }

    public function view(User $user, Category $category): bool
    {
        return $this->viewAny($user);
    }

    public function create(User $user): bool
    {
        return in_array($user->role, ['superadmin', 'admin_cabang'], true);
    }

    public function update(User $user, Category $category): bool
    {
        return in_array($user->role, ['superadmin', 'admin_cabang'], true);
    }

    public function delete(User $user, Category $category): bool
    {
        return in_array($user->role, ['superadmin', 'admin_cabang'], true);
    }
}
