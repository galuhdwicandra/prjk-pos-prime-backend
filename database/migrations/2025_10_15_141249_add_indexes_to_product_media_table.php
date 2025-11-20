<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('product_media', function (Blueprint $table) {
            // Tambahkan index gabungan
            $table->index(['product_id', 'is_primary', 'sort_order'], 'product_media_primary_sort_idx');
        });
    }

    public function down(): void
    {
        Schema::table('product_media', function (Blueprint $table) {
            $table->dropIndex('product_media_primary_sort_idx');
        });
    }
};
