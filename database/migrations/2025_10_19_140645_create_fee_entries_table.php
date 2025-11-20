<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('fee_entries', function (Blueprint $t) {
            $t->id();
            $t->unsignedBigInteger('fee_id');
            $t->unsignedBigInteger('cabang_id');
            $t->date('period_date'); // daily bucket (date of event)
            $t->enum('ref_type', ['ORDER', 'DELIVERY']);
            $t->unsignedBigInteger('ref_id'); // order_id or delivery_id
            $t->unsignedBigInteger('owner_user_id')->nullable(); // salesperson/cashier/courier

            $t->decimal('base_amount', 18, 2)->default(0);
            $t->decimal('fee_amount', 18, 2)->default(0);

            $t->enum('pay_status', ['UNPAID', 'PAID', 'PARTIAL'])->default('UNPAID');
            $t->decimal('paid_amount', 18, 2)->default(0);
            $t->timestamp('paid_at')->nullable();
            $t->string('notes', 255)->nullable();

            $t->unsignedBigInteger('created_by')->nullable();
            $t->unsignedBigInteger('updated_by')->nullable();
            $t->timestamps();

            // Idempotency: one entry per fee × ref
            $t->unique(['fee_id', 'ref_type', 'ref_id']);

            $t->index(['cabang_id', 'period_date']);
            $t->index(['owner_user_id', 'pay_status']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('fee_entries');
    }
};
