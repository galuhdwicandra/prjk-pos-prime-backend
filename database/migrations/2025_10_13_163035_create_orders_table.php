<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void {
        Schema::create('orders', function (Blueprint $t) {
            $t->bigIncrements('id');
            $t->string('kode', 50)->unique();                 // order number
            $t->foreignId('cabang_id')->constrained('cabangs')->restrictOnDelete();
            $t->foreignId('gudang_id')->constrained('gudangs')->restrictOnDelete();
            $t->foreignId('cashier_id')->constrained('users')->restrictOnDelete();
            $t->unsignedBigInteger('customer_id')->nullable(); // FK to customers (next module)

            $t->enum('status', ['DRAFT','UNPAID','PAID','VOID','REFUND'])->default('DRAFT');
            $t->decimal('subtotal', 18, 2)->default(0);
            $t->decimal('discount', 18, 2)->default(0);
            $t->decimal('tax', 18, 2)->default(0);
            $t->decimal('service_fee', 18, 2)->default(0);
            $t->decimal('grand_total', 18, 2)->default(0);
            $t->decimal('paid_total', 18, 2)->default(0);

            $t->enum('channel', ['POS','ONLINE'])->default('POS');
            $t->text('note')->nullable();
            $t->timestamp('ordered_at'); // set at create

            $t->timestamps();

            $t->index(['cabang_id','ordered_at']);
            $t->index('gudang_id');
            $t->index('cashier_id');
            $t->index(['status','channel']);
        });
    }

    public function down(): void {
        Schema::dropIfExists('orders');
    }
};
