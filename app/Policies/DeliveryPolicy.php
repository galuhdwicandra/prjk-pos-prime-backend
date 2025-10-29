<?php

namespace App\Policies;

use App\Models\{Delivery, Order, User};

class DeliveryPolicy
{
    /** Superadmin boleh semua via Spatie helper kamu */
    public function before(User $user, string $ability): bool|null
    {
        return $user->hasRoleCompat('superadmin') ? true : null;
    }

    /** List deliveries (FE index). Kurir hanya akan melihat miliknya via query scope/controller. */
    public function viewAny(User $actor): bool
    {
        return in_array($actor->role, ['superadmin', 'admin_cabang', 'kasir', 'kurir', 'gudang'], true);
    }

    /** Lihat 1 delivery */
    public function view(User $actor, Delivery $delivery): bool
    {
        // admin_cabang/kasir/gudang: harus satu cabang dgn order
        if (in_array($actor->role, ['admin_cabang', 'kasir', 'gudang'], true)) {
            return $this->sameBranch($actor, $delivery);
        }

        // kurir: hanya yang ditugaskan
        if ($actor->role === 'kurir') {
            return (int)$delivery->assigned_to === (int)$actor->id;
        }

        return false;
    }

    /**
     * Buat delivery untuk sebuah order.
     * Dipakai dengan Gate::authorize('create', [Delivery::class, $order])
     */
    public function create(User $user, Order $order): bool
    {
        if ($user->hasAnyRoleCompat(['admin_cabang', 'kasir', 'admin', 'gudang'])) {
            return (int)$order->cabang_id === (int)$user->cabang_id;
        }
        return $user->hasRoleCompat('superadmin');
    }

    /** Assign kurir */
    public function assign(User $actor, Delivery $delivery): bool
    {
        if (in_array($actor->role, ['admin_cabang', 'kasir', 'gudang'], true)) {
            return $this->sameBranch($actor, $delivery) && !$this->isFinal($delivery);
        }
        return false;
    }

    /** Update status (kurir miliknya, admin/kasir/gudang di cabangnya) */
    public function updateStatus(User $actor, Delivery $delivery): bool
    {
        if ($actor->role === 'kurir') {
            return (int)$delivery->assigned_to === (int)$actor->id;
        }
        if (in_array($actor->role, ['admin_cabang', 'kasir', 'gudang'], true)) {
            return $this->sameBranch($actor, $delivery);
        }
        return false;
    }

    /** Tambah event tracking → ikut aturan updateStatus */
    public function addEvent(User $user, Delivery $delivery): bool
    {
        return $this->updateStatus($user, $delivery);
    }

    /**
     * ====== Tambahan untuk SURAT JALAN ======
     * Lihat/cetak Surat Jalan (HTML). Syarat: boleh view & sudah assigned.
     */
    public function note(User $actor, Delivery $delivery): bool
    {
        if (!$this->view($actor, $delivery)) return false;
        return !is_null($delivery->assigned_to);
    }

    /**
     * Kirim WA Surat Jalan ke kurir. Syarat: cabang sesuai (atau kurir sendiri) & sudah assigned.
     * FE akan memanggil POST /deliveries/{id}/send-wa
     */
    public function sendSuratJalan(User $actor, Delivery $delivery): bool
    {
        // kurir boleh kirim link SJ untuk dirinya sendiri
        if ($actor->role === 'kurir') {
            return (int)$delivery->assigned_to === (int)$actor->id;
        }
        // admin_cabang/kasir/gudang boleh jika satu cabang
        if (in_array($actor->role, ['admin_cabang', 'kasir', 'gudang'], true)) {
            return $this->sameBranch($actor, $delivery) && !is_null($delivery->assigned_to);
        }
        return false;
    }

    /** ===== Helpers ===== */

    private function sameBranch(User $actor, Delivery $delivery): bool
    {
        // pastikan relasi order terload di controller: $delivery->loadMissing('order')
        if (!$actor->cabang_id || !$delivery->order) return false;
        return (int)$actor->cabang_id === (int)$delivery->order->cabang_id;
    }

    private function isFinal(Delivery $delivery): bool
    {
        // Sesuaikan dengan enum/status final di sistemmu
        return in_array($delivery->status, ['DELIVERED', 'FAILED', 'CANCELLED'], true);
    }
}
