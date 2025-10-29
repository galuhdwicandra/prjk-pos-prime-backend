<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('customers', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('cabang_id'); // branch
            $table->string('nama', 120);
            $table->string('phone', 30);
            $table->string('email', 190)->nullable();
            $table->string('alamat', 255)->nullable();
            $table->string('catatan', 255)->nullable();
            $table->string('stage', 30)->default('ACTIVE'); // e.g. LEAD, ACTIVE, CHURN
            $table->timestamp('last_order_at')->nullable();
            $table->decimal('total_spent', 18, 2)->default(0);
            $table->unsignedBigInteger('total_orders')->default(0);
            $table->timestamps();

            $table->index('cabang_id');
            $table->index(['cabang_id', 'phone']);
            $table->unique(['cabang_id', 'phone']); // branch-scoped uniqueness
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('customers');
    }
};
