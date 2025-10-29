<?php

// app/Services/User/UserService.php
namespace App\Services\User;

use App\Models\User;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Hash;

class UserService
{
    /**
     * @param array{
     *   q?:string, role?:string, cabang_id?:int|null, is_active?:bool|null, per_page?:int
     * } $filters
     */
    public function paginate(array $filters = []): LengthAwarePaginator
    {
        $perPage = $filters['per_page'] ?? 15;

        $q         = $filters['q']         ?? null;
        $role      = $filters['role']      ?? null;
        $cabangId  = $filters['cabang_id'] ?? null;
        $isActive  = $filters['is_active'] ?? null;

        $query = User::query();

        if ($q) {
            $query->where(function($s) use ($q) {
                $s->where('name','like',"%{$q}%")
                  ->orWhere('email','like',"%{$q}%")
                  ->orWhere('phone','like',"%{$q}%");
            });
        }

        if ($role)     $query->where('role', $role);
        if (!is_null($isActive)) $query->where('is_active', (bool)$isActive);

        // scoping per cabang (opsional di listing superadmin)
        if ($cabangId) $query->where('cabang_id', $cabangId);

        return $query->orderByDesc('id')->paginate($perPage);
    }

    /** @param array{name:string,email:string,phone?:?string,password:string,cabang_id?:?int,role:string,is_active?:bool} $data */
    public function create(array $data): User
    {
        $payload = $data;
        $payload['password'] = Hash::make($data['password']);
        return User::create($payload);
    }

    /** @param array{name?:string,email?:string,phone?:?string,password?:string,cabang_id?:?int,role?:string,is_active?:bool} $data */
    public function update(User $user, array $data): User
    {
        $payload = $data;
        if (!empty($data['password'])) {
            $payload['password'] = Hash::make($data['password']);
        } else {
            unset($payload['password']);
        }
        $user->update($payload);
        return $user->refresh();
    }

    public function delete(User $user): void
    {
        $user->delete(); // hard delete
    }

    public function findOrFail(int $id): User
    {
        return User::query()->findOrFail($id);
    }
}
