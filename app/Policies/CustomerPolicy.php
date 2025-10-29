<?php

namespace App\Policies;

use App\Models\User;
use App\Models\Customer;

class CustomerPolicy
{
    public function before(User $user, $ability)
    {
        // superadmin selalu boleh
        if (method_exists($user, 'hasRole') && $user->hasRole('superadmin')) {
            return true;
        }
        // jika pakai compat dan ada alias 'super admin' dsb
        if (method_exists($user, 'hasRoleCompat') && $user->hasRoleCompat('superadmin')) {
            return true;
        }
        return null;
    }

    public function viewAny(User $user): bool
    {
        $roles = ['superadmin','admin_cabang','admin cabang','admin-cabang','kasir','sales','kurir','gudang'];

        if (method_exists($user, 'hasAnyRoleCompat')) {
            return $user->hasAnyRoleCompat($roles);
        }
        if (method_exists($user, 'hasAnyRole')) {
            // Spatie: nama harus persis
            return $user->hasAnyRole(['superadmin','admin_cabang','kasir','sales','kurir','gudang']);
        }
        return in_array(strtolower((string)$user->role), ['superadmin','admin_cabang','kasir','sales','kurir','gudang'], true);
    }

    public function view(User $user, Customer $customer): bool
    {
        // admin_cabang boleh lihat semua (di cabangnya—opsional: batasi cabang jika mau)
        if (
            (method_exists($user, 'hasAnyRoleCompat') && $user->hasAnyRoleCompat(['admin_cabang','admin cabang','admin-cabang'])) ||
            (method_exists($user, 'hasRole') && $user->hasRole('admin_cabang')) ||
            (strtolower((string)$user->role) === 'admin_cabang')
        ) {
            return true;
        }

        // kasir & sales: hanya customer di cabang yang sama
        $isKasirAtauSales =
            (method_exists($user, 'hasAnyRoleCompat') && $user->hasAnyRoleCompat(['kasir','sales'])) ||
            (method_exists($user, 'hasAnyRole') && $user->hasAnyRole(['kasir','sales'])) ||
            in_array(strtolower((string)$user->role), ['kasir','sales'], true);

        if ($isKasirAtauSales) {
            return (int)$user->cabang_id === (int)$customer->cabang_id; // <- perbaiki branch_id → cabang_id
        }

        return false;
    }

    public function create(User $user): bool
    {
        if (method_exists($user, 'hasAnyRoleCompat')) {
            return $user->hasAnyRoleCompat(['admin_cabang','admin cabang','admin-cabang','kasir','sales']);
        }
        if (method_exists($user, 'hasAnyRole')) {
            return $user->hasAnyRole(['admin_cabang','kasir','sales']);
        }
        return in_array(strtolower((string)$user->role), ['admin_cabang','kasir','sales'], true);
    }

    public function update(User $user, Customer $customer): bool
    {
        // hanya admin_cabang, dan harus di cabang yang sama
        $isAdminCabang =
            (method_exists($user, 'hasAnyRoleCompat') && $user->hasAnyRoleCompat(['admin_cabang','admin cabang','admin-cabang'])) ||
            (method_exists($user, 'hasRole') && $user->hasRole('admin_cabang')) ||
            (strtolower((string)$user->role) === 'admin_cabang');

        return $isAdminCabang && (int)$user->cabang_id === (int)$customer->cabang_id;
    }

    public function delete(User $user, Customer $customer): bool
    {
        // konsisten dengan update()
        $isAdminCabang =
            (method_exists($user, 'hasAnyRoleCompat') && $user->hasAnyRoleCompat(['admin_cabang','admin cabang','admin-cabang'])) ||
            (method_exists($user, 'hasRole') && $user->hasRole('admin_cabang')) ||
            (strtolower((string)$user->role) === 'admin_cabang');

        return $isAdminCabang && (int)$user->cabang_id === (int)$customer->cabang_id;
    }
}
