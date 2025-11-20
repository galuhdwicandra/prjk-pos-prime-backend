<?php

namespace App\Policies;

use App\Models\User;
use App\Models\VariantStock;

class VariantStockPolicy
{
    // Role helper
    protected function canManage(User $user): bool
    {
        return in_array($user->role, ['superadmin','admin_cabang','gudang'], true);
    }

    public function viewAny(User $user): bool
    {
        // Lihat stok per cabang/gudang
        return $this->canManage($user);
    }

    public function view(User $user, VariantStock $stock): bool
    {
        if (!$this->canManage($user)) return false;
        // Admin Cabang/Gudang hanya cabangnya
        if ($user->role === 'superadmin') return true;
        return (int)$user->cabang_id === (int)$stock->cabang_id;
    }

    public function create(User $user): bool
    {
        // Set stok awal
        return $this->canManage($user);
    }

    public function update(User $user, VariantStock $stock): bool
    {
        if (!$this->canManage($user)) return false;
        if ($user->role === 'superadmin') return true;
        return (int)$user->cabang_id === (int)$stock->cabang_id;
    }

    public function adjust(User $user, VariantStock $stock): bool
    {
        // Penyesuaian manual (tambah/kurang)
        return $this->update($user, $stock);
    }

    public function delete(User $user, VariantStock $stock): bool
    {
        // Hard delete only (sesuai SOP)
        if (!$this->canManage($user)) return false;
        if ($user->role === 'superadmin') return true;
        return (int)$user->cabang_id === (int)$stock->cabang_id;
    }
}
