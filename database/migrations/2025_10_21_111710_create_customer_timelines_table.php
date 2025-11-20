<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('customer_timelines', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('customer_id');
            $table->string('event_type', 40); // ORDER, PAYMENT, STAGE, NOTE
            $table->string('title', 190)->nullable();
            $table->text('note')->nullable();
            $table->jsonb('meta')->nullable(); // PgSQL jsonb
            $table->timestamp('happened_at')->useCurrent();
            $table->timestamps();

            $table->index('customer_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('customer_timelines');
    }
};
