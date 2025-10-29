<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB; // ⬅️ penting kalau pakai DB::raw

return new class extends Migration {
    public function up(): void
    {
        Schema::create('order_change_logs', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('order_id');
            $table->unsignedBigInteger('actor_id')->nullable();
            $table->string('action', 50);
            $table->json('diff_json')->nullable();
            $table->text('note')->nullable();

            // default CURRENT_TIMESTAMP (PostgreSQL)
            $table->timestampTz('occurred_at')
                ->default(DB::raw('CURRENT_TIMESTAMP'));

            $table->timestampsTz();

            $table->index(['order_id', 'occurred_at']);
            $table->index(['action', 'occurred_at']);

            $table->foreign('order_id')->references('id')->on('orders')->onDelete('cascade');
            $table->foreign('actor_id')->references('id')->on('users')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('order_change_logs');
    }
};
