<?php

namespace App\Policies;

use App\Models\User;
use App\Models\Setting;

class SettingPolicy
{
    // Settings visible to superadmin & admin_cabang
    public function viewAny(User $user): bool
    {
        return $user->hasAnyRole(['superadmin', 'admin_cabang']);
    }

    public function view(User $user, Setting $setting): bool
    {
        if ($user->hasRole('superadmin')) {
            return true;
        }

        if ($user->hasRole('admin_cabang')) {
            // Jika kamu ingin admin_cabang bisa lihat GLOBAL juga, set true untuk GLOBAL
            if ($setting->scope === 'GLOBAL') {
                return true;
            }
            // Batasi item BRANCH ke cabang miliknya
            return $setting->scope === 'BRANCH'
                && (int) $setting->scope_id === (int) ($user->cabang_id ?? 0);
        }

        return false;
    }

    public function create(User $user): bool
    {
        return $user->hasAnyRole(['superadmin', 'admin_cabang']);
    }

    public function update(User $user, Setting $setting): bool
    {
        if ($user->hasRole('superadmin')) {
            return true;
        }

        if ($user->hasRole('admin_cabang')) {
            // Admin cabang hanya boleh ubah setting BRANCH miliknya
            return $setting->scope === 'BRANCH'
                && (int) $setting->scope_id === (int) ($user->cabang_id ?? 0);
        }

        return false;
    }

    public function delete(User $user, Setting $setting): bool
    {
        // Lebih ketat: hapus hanya superadmin
        return $user->hasRole('superadmin');
    }

    // Custom ops
    public function export(User $user): bool
    {
        return $this->viewAny($user);
    }

    public function import(User $user): bool
    {
        return $this->create($user);
    }
}
