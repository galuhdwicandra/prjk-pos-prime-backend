<?php

namespace App\Policies;

use App\Models\User;
use App\Models\JournalEntry;

class JournalEntryPolicy
{
    public function viewAny(User $u): bool
    {
        return $u->hasAnyRoleCompat(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang', 'kasir']);
    }

    public function view(User $u, JournalEntry $m): bool
    {
        return $this->viewAny($u);
    }

    public function create(User $u): bool
    {
        return $u->hasAnyRoleCompat(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang']);
    }

    public function update(User $u, JournalEntry $m): bool
    {
        return $u->hasAnyRoleCompat(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang'])
            && $m->status === 'DRAFT';
    }

    public function post(User $u, JournalEntry $m): bool
    {
        return $u->hasAnyRoleCompat(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang'])
            && $m->status === 'DRAFT';
    }

    public function delete(User $u, JournalEntry $m): bool
    {
        return $u->hasAnyRoleCompat(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang'])
            && $m->status === 'DRAFT';
    }
}
