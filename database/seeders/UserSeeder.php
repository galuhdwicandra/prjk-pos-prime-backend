<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        // Superadmin
        $super = User::updateOrCreate(
            ['email' => 'superadmin@gmail.com'],
            [
                'name' => 'Superadmin',
                'phone' => '081234567890',
                'password' => Hash::make('password'),
                'role' => 'superadmin',
                'is_active' => true,
                'cabang_id' => null,
            ]
        );
        $super->syncRoles(['superadmin']);

        // Admin Cabang 1
        $admin1 = User::updateOrCreate(
            ['email' => 'admin1@gmail.com'],
            [
                'name' => 'Admin 1',
                'phone' => '081111111111',
                'password' => Hash::make('password'),
                'role' => 'admin_cabang',
                'is_active' => true,
                'cabang_id' => 1,
            ]
        );
        $admin1->syncRoles(['admin_cabang']);

        // Kasir Cabang 1
        $kasir1 = User::updateOrCreate(
            ['email' => 'kasir1@gmail.com'],
            [
                'name' => 'Kasir 1',
                'phone' => '082222222222',
                'password' => Hash::make('password'),
                'role' => 'kasir',
                'is_active' => true,
                'cabang_id' => 1,
            ]
        );
        $kasir1->syncRoles(['kasir']);

        // Kurir Cabang 1
        $kurir1 = User::updateOrCreate(
            ['email' => 'kurir1@gmail.com'],
            [
                'name' => 'Kurir 1',
                'phone' => '083333333333',
                'password' => Hash::make('password'),
                'role' => 'kurir',
                'is_active' => true,
                'cabang_id' => 1,
            ]
        );
        $kurir1->syncRoles(['kurir']);

        // (Opsional) Hapus factory random agar tidak membingungkan role/guard saat pengujian
        // User::factory()->count(3)->create();
    }
}
