<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void {
        Schema::create('payments', function (Blueprint $t) {
            $t->bigIncrements('id');
            $t->foreignId('order_id')->constrained('orders')->cascadeOnDelete();
            $t->enum('method', ['CASH','TRANSFER','QRIS','XENDIT']);
            $t->decimal('amount', 18, 2);
            $t->enum('status', ['PENDING','SUCCESS','FAILED','REFUND'])->default('PENDING');
            $t->string('ref_no', 191)->nullable();
            $t->json('payload_json')->nullable(); // raw gateway/meta if any
            $t->timestamp('paid_at')->nullable();
            $t->timestamps();

            $t->index(['order_id','method','status']);
            $t->index('paid_at');
        });
    }

    public function down(): void {
        Schema::dropIfExists('payments');
    }
};
