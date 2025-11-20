<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('products', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('category_id');
            $table->string('nama', 160);
            $table->string('slug', 180)->unique();
            $table->text('deskripsi')->nullable();
            $table->boolean('is_active')->default(true);
            $table->timestamps();

            // kategori dipakai produk => TIDAK boleh dihapus (RESTRICT)
            $table->foreign('category_id')
                ->references('id')->on('categories')
                ->restrictOnDelete();

            $table->index(['category_id', 'is_active']);
        });
    }
    public function down(): void
    {
        Schema::dropIfExists('products');
    }
};
