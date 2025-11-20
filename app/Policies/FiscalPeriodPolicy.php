<?php

namespace App\Policies;

use App\Models\User;
use App\Models\FiscalPeriod;

class FiscalPeriodPolicy
{
    public function viewAny(User $u): bool
    {
        return $u->hasAnyRole(['superadmin', 'admin_cabang', 'kasir']);
    }
    public function view(User $u, FiscalPeriod $m): bool
    {
        return $this->viewAny($u);
    }

    public function open(User $u): bool
    {
        return $u->hasAnyRole(['superadmin', 'admin_cabang']);
    }
    public function close(User $u, FiscalPeriod $m): bool
    {
        return $u->hasAnyRole(['superadmin', 'admin_cabang']) && $m->status === 'OPEN';
    }
}
