<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('deliveries', function (Blueprint $t) {
            $t->bigIncrements('id');
            $t->foreignId('order_id')->constrained('orders')->restrictOnDelete();
            $t->foreignId('assigned_to')->nullable()->constrained('users')->nullOnDelete(); // kurir (optional until assigned)

            // PICKUP (ambil), DELIVERY (antar), BOTH (ambil lalu antar)
            $t->enum('type', ['PICKUP','DELIVERY','BOTH'])->default('DELIVERY');

            // Status life-cycle
            $t->enum('status', [
                'REQUESTED','ASSIGNED','PICKED_UP','ON_ROUTE','DELIVERED','FAILED','CANCELLED'
            ])->default('REQUESTED');

            // Addresses & optional geo
            $t->string('pickup_address', 255)->nullable();
            $t->string('delivery_address', 255)->nullable();
            $t->decimal('pickup_lat', 10, 7)->nullable();
            $t->decimal('pickup_lng', 10, 7)->nullable();
            $t->decimal('delivery_lat', 10, 7)->nullable();
            $t->decimal('delivery_lng', 10, 7)->nullable();

            // Timestamps
            $t->timestamp('requested_at')->useCurrent();
            $t->timestamp('completed_at')->nullable();

            $t->timestamps();

            // Useful indexes
            $t->index(['assigned_to', 'status']);
            $t->index(['requested_at']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('deliveries');
    }
};
