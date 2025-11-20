<?php

// database/migrations/2025_10_10_000000_create_users_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('name', 120);
            $table->string('email', 190)->unique();
            $table->string('phone', 30)->nullable()->index();
            $table->string('password');
            // cabang_id nullable pada M0; akan di-FK-kan setelah modul Cabang jadi
            $table->unsignedBigInteger('cabang_id')->nullable()->index();

            // strict enum 6 role sesuai dokumen UI/UX
            $table->enum('role', [
                'superadmin',
                'admin_cabang',
                'gudang',
                'kasir',
                'sales',
                'kurir'
            ])->index();

            $table->boolean('is_active')->default(true)->index();
            $table->rememberToken();
            $table->timestamps();

            // Tidak ada soft deletes (hard delete only)
            // FK cabang_id ditambahkan di modul Cabang & Gudang (M selanjutnya)
        });
    }
    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};
