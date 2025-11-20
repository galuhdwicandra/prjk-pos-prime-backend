<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;

class RolePermissionSeeder extends Seeder
{
    public function run(): void
    {
        app(\Spatie\Permission\PermissionRegistrar::class)->forgetCachedPermissions();

        // Minimal roles yang dipakai modul
        Role::firstOrCreate(['name' => 'superadmin',   'guard_name' => 'web']);
        Role::firstOrCreate(['name' => 'admin_cabang', 'guard_name' => 'web']);
        Role::firstOrCreate(['name' => 'kasir',        'guard_name' => 'web']);
        Role::firstOrCreate(['name' => 'kurir',        'guard_name' => 'web']);
        Role::firstOrCreate(['name' => 'gudang',       'guard_name' => 'web']);
        Role::firstOrCreate(['name' => 'sales',        'guard_name' => 'web']);

    }
}
