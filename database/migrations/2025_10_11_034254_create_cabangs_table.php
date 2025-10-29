<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('cabangs', function (Blueprint $table) {
            $table->id();
            $table->string('nama', 120);
            $table->string('kota', 120)->nullable();
            $table->string('alamat', 255)->nullable();
            $table->string('telepon', 30)->nullable();
            // format jam operasional bebas: "Senin-Jumat 08:00-20:00"
            $table->string('jam_operasional', 120)->nullable();

            $table->boolean('is_active')->default(true)->index();
            $table->timestamps();

            $table->index(['kota', 'is_active']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('cabangs');
    }
};
