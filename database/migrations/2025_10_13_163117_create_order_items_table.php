<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void {
        Schema::create('order_items', function (Blueprint $t) {
            $t->bigIncrements('id');
            $t->foreignId('order_id')->constrained('orders')->cascadeOnDelete();
            $t->foreignId('variant_id')->constrained('product_variants')->restrictOnDelete();

            $t->string('name_snapshot', 200);    // product/variant name at time of sale
            $t->decimal('price', 18, 2);         // unit price (final)
            $t->decimal('discount', 18, 2)->default(0);
            $t->decimal('qty', 18, 2);
            $t->decimal('line_total', 18, 2);    // (price - discount) * qty

            $t->timestamps();

            $t->index('order_id');
            $t->index('variant_id');
        });
    }

    public function down(): void {
        Schema::dropIfExists('order_items');
    }
};
