<?php

namespace App\Policies;

use App\Models\User;

class BackupPolicy
{
    public function create(User $user): bool
    {
        return $user->hasRole('Superadmin');
    }
    public function viewAny(User $user): bool
    {
        return $user->hasRole('Superadmin');
    }
    public function restore(User $user): bool
    {
        return $user->hasRole('Superadmin');
    }
    public function delete(User $user): bool
    {
        return $user->hasRole('Superadmin');
    }
}
