<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('variant_stocks', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('cabang_id');                 // denormalisasi utk query cepat per cabang
            $table->unsignedBigInteger('gudang_id');                 // FK -> gudangs.id
            $table->unsignedBigInteger('product_variant_id');        // FK -> product_variants.id

            $table->unsignedInteger('qty')->default(0);              // stok saat ini
            $table->unsignedInteger('min_stok')->default(10);        // threshold low-stock (UI/UX default <10)

            $table->timestamps();

            // Integrity & performance
            $table->unique(['gudang_id','product_variant_id'], 'variant_stocks_unique_gudang_variant');
            $table->index(['cabang_id','gudang_id']);
            $table->index(['product_variant_id']);

            // FK (ikuti pola FK yang sudah ada pada dump)
            $table->foreign('gudang_id')->references('id')->on('gudangs')->onDelete('cascade');
            $table->foreign('product_variant_id')->references('id')->on('product_variants')->onDelete('restrict');
            $table->foreign('cabang_id')->references('id')->on('cabangs')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('variant_stocks');
    }
};
