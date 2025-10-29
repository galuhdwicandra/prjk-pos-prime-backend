<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('delivery_events', function (Blueprint $t) {
            $t->bigIncrements('id');
            $t->foreignId('delivery_id')->constrained('deliveries')->cascadeOnDelete();

            // mirror status timeline / notes
            $t->string('status', 50); // free-form but validated in Request later (must be one of allowed states)
            $t->text('note')->nullable();

            // optional photo (we’ll store path/URL here; actual file on disk 'public')
            $t->text('photo_url')->nullable();

            $t->timestamp('occurred_at')->useCurrent();
            $t->timestamps();

            $t->index(['delivery_id', 'occurred_at']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('delivery_events');
    }
};
