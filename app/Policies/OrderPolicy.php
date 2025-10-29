<?php

namespace App\Policies;

use App\Models\Order;
use App\Models\User;
use Illuminate\Support\Str;

class OrderPolicy
{
    // SUPERADMIN bypass for all abilities
    public function before(User $user, string $ability): ?bool
    {
        if ($this->isSuper($user)) return true;
        return null;
    }

    protected function hasRoleInsensitive(User $user, string $expected): bool
    {
        $norm = fn(string $v) => Str::of($v)->lower()->replace([' ', '-'], '_')->value();
        $expectedN = $norm($expected);

        // 1) Spatie roles
        if (method_exists($user, 'getRoleNames')) {
            foreach ($user->getRoleNames() as $r) {
                if ($norm($r) === $expectedN) return true;
            }
        }

        // 2) Plain column fallback
        if (isset($user->role) && is_string($user->role) && $norm($user->role) === $expectedN) {
            return true;
        }

        // 3) Optional flags
        $flags = [
            'superadmin'    => (bool)($user->is_super        ?? false),
            'admin_cabang'  => (bool)($user->is_admin_cabang ?? false),
            'kasir'         => (bool)($user->is_kasir        ?? false),
            'sales'         => (bool)($user->is_sales        ?? false),
        ];
        if (($flags[$expectedN] ?? false) === true) return true;

        return false;
    }

    protected function hasAnyInsensitive(User $user, array $expected): bool
    {
        foreach ($expected as $e) if ($this->hasRoleInsensitive($user, $e)) return true;
        return false;
    }

    protected function sameCabang(User $user, ?Order $order = null): bool
    {
        if (!$order) return true;
        // jika order belum punya cabang_id, jangan gagalkan (atau ubah ke `return false;` kalau wajib sama)
        if (is_null($order->cabang_id)) return true;
        if (is_null($user->cabang_id))  return false;
        return (int)$user->cabang_id === (int)$order->cabang_id;
    }

    protected function isSuper(User $user): bool
    {
        return $this->hasRoleInsensitive($user, 'superadmin');
    }

    protected function isAdminCabang(User $user): bool
    {
        return $this->hasRoleInsensitive($user, 'admin_cabang')
            || $this->hasRoleInsensitive($user, 'admin'); // kalau kamu masih pakai plain 'admin'
    }

    protected function isKasir(User $user): bool
    {
        return $this->hasRoleInsensitive($user, 'kasir');
    }

    protected function isSales(User $user): bool
    {
        return $this->hasRoleInsensitive($user, 'sales');
    }

    public function viewAny(User $user): bool
    {
        return $this->isAdminCabang($user) || $this->isKasir($user) || $this->isSales($user);
    }

    public function view(User $user, Order $order): bool
    {
        return $this->sameCabang($user, $order)
            && ($this->isAdminCabang($user) || $this->isKasir($user) || $this->isSales($user));
    }

    // /cart/quote
    public function create(User $user): bool
    {
        return $this->isAdminCabang($user) || $this->isKasir($user) || $this->isSales($user);
    }

    public function update(User $user, Order $order): bool
    {
        if (!in_array($order->status, ['DRAFT', 'UNPAID'], true)) return false;
        return $this->sameCabang($user, $order) && ($this->isAdminCabang($user) || $this->isKasir($user));
    }

    public function addPayment(User $user, Order $order): bool
    {
        if (!in_array($order->status, ['DRAFT', 'UNPAID'], true)) return false;
        return $this->sameCabang($user, $order) && ($this->isAdminCabang($user) || $this->isKasir($user));
    }

    public function setCashPosition(User $user, Order $order): bool
    {
        if (in_array($order->status, ['VOID', 'REFUND'], true)) return false;

        $allowedRole = $this->isAdminCabang($user) || $this->isKasir($user) || $this->isSales($user);
        return $allowedRole && $this->sameCabang($user, $order);
    }

    public function cancel(User $user, Order $order): bool
    {
        // Tidak bisa cancel lagi kalau sudah VOID/REFUND
        if (in_array($order->status, ['VOID', 'REFUND'], true)) return false;

        // PAID: hanya admin cabang (superadmin sudah bypass di before)
        if ($order->status === 'PAID') return $this->isAdminCabang($user);

        return $this->sameCabang($user, $order) && ($this->isAdminCabang($user) || $this->isKasir($user));
    }

    public function print(User $user, Order $order): bool
    {
        return $this->view($user, $order);
    }

    public function reprint(User $user, Order $order): bool
    {
        return $this->view($user, $order);
    }

    public function resendWA(User $user, Order $order): bool
    {
        return $this->view($user, $order);
    }

    public function delete(User $user, Order $order): bool
    {
        return false;
    }
}
