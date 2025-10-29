<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('fees', function (Blueprint $t) {
            $t->id();
            $t->unsignedBigInteger('cabang_id'); // branch
            $t->string('name', 100);
            $t->enum('kind', ['SALES', 'CASHIER', 'COURIER']); // who this fee is intended for
            $t->enum('calc_type', ['PERCENT', 'FIXED']);      // how to calculate
            $t->decimal('rate', 10, 2);                      // percent or fixed amount
            $t->enum('base', ['GRAND_TOTAL', 'DELIVERY']);    // base metric
            $t->boolean('is_active')->default(true);
            $t->unsignedBigInteger('created_by')->nullable();
            $t->unsignedBigInteger('updated_by')->nullable();
            $t->timestamps();

            $t->index(['cabang_id', 'kind', 'is_active']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('fees');
    }
};
