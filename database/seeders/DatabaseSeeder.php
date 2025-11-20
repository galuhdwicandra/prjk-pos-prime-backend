<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Database\Seeders\CabangGudangSeeder;
use Database\Seeders\CategorySeeder;
use Database\Seeders\RolePermissionSeeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();

        $this->call([
            RolePermissionSeeder::class,
            CabangGudangSeeder::class,
            UserSeeder::class,
            CategorySeeder::class,
            AccountsSeeder::class,
            AccountingSettingsSeeder::class,
        ]);
    }
}
