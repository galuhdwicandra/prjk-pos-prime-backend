<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('categories', function (Blueprint $table) {
            $table->id();
            $table->string('nama', 120);
            $table->string('slug', 140)->unique(); // untuk URL & unique constraint
            $table->text('deskripsi')->nullable();
            $table->boolean('is_active')->default(true)->index();
            $table->timestamps();

            // Catatan: FK ke produk akan dibuat di modul Produk (products.category_id -> categories.id, onDelete('restrict')).
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('categories');
    }
};
