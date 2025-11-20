<?php

// app/Models/User.php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Spatie\Permission\Traits\HasRoles;

class User extends Authenticatable
{
    use HasApiTokens, Notifiable, HasFactory;
    use HasRoles;

    protected $guard_name = 'web';

    protected $fillable = [
        'name',
        'email',
        'phone',
        'password',
        'cabang_id',
        'role',
        'is_active',
    ];

    protected $hidden = ['password', 'remember_token'];

    protected $casts = [
        'is_active' => 'boolean',
        'email_verified_at' => 'datetime',
    ];

    // Scope: batasi query per cabang (digunakan di controller/service)
    public function scopeForCabang($query, ?int $cabangId)
    {
        if ($cabangId) {
            $query->where('cabang_id', $cabangId);
        }
        return $query;
    }

    public function cabang()
    {
        return $this->belongsTo(Cabang::class);
    }

    public function deliveries()
    {
        // tugas delivery yang di-assign ke user (kurir)
        return $this->hasMany(\App\Models\Delivery::class, 'assigned_to');
    }

    public function hasRoleCompat(string $role): bool
    {
        $norm = fn($s) => str_replace([' ', '-'], '_', strtolower($s));
        $want = $norm($role);

        // 1) Cek Spatie
        if (method_exists($this, 'hasRole') && $this->hasRole($role)) {
            return true;
        }
        // 2) Cek kolom `role`
        return $norm((string) $this->role) === $want;
    }

    public function hasAnyRoleCompat(array $roles): bool
    {
        foreach ($roles as $r) {
            if ($this->hasRoleCompat($r)) return true;
        }
        return false;
    }
}
