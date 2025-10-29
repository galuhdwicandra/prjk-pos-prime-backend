<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('product_variants', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('product_id');
            // Kombinasi varian sesuai UI-UX: Size, Type, Tester
            $table->string('size', 40)->nullable();   // Small/Medium/Large
            $table->string('type', 60)->nullable();   // Choco/Vanilla/Red Velvet/Matcha
            $table->string('tester', 40)->nullable(); // Full/Slice/Bite
            $table->string('sku', 80)->unique();      // auto-generate di Service
            $table->decimal('harga', 14, 2);          // harga per varian
            $table->boolean('is_active')->default(true);
            $table->timestamps();

            $table->foreign('product_id')
                ->references('id')->on('products')
                ->cascadeOnDelete();

            // Hindari duplikasi kombinasi dalam 1 produk
            $table->unique(['product_id', 'size', 'type', 'tester']);

            $table->index(['product_id', 'is_active']);
        });
    }
    public function down(): void
    {
        Schema::dropIfExists('product_variants');
    }
};
