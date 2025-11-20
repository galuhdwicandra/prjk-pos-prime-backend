<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('product_media', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('product_id');
            $table->string('disk', 40)->default('public'); // default sesuai .env/filesystem
            $table->string('path', 255);   // path relatif di disk
            $table->string('mime', 100)->nullable();
            $table->unsignedInteger('size_kb')->nullable();
            $table->boolean('is_primary')->default(false);
            $table->unsignedSmallInteger('sort_order')->default(0);
            $table->timestamps();

            $table->foreign('product_id')
                ->references('id')->on('products')
                ->cascadeOnDelete();

            $table->index(['product_id', 'is_primary']);
        });
    }
    public function down(): void
    {
        Schema::dropIfExists('product_media');
    }
};
