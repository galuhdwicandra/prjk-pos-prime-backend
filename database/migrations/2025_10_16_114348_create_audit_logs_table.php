<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('audit_logs', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('actor_type', 50);       // USER / SYSTEM / JOB, etc.
            $table->unsignedBigInteger('actor_id')->nullable();
            $table->string('action', 120);          // e.g. ORDER_ITEMS_UPDATED
            $table->string('model', 120);           // e.g. Order
            $table->unsignedBigInteger('model_id'); // target id
            $table->json('diff_json');              // before/after + note
            $table->timestamps();

            $table->index(['model', 'model_id']);
            $table->index(['action']);
            $table->index(['actor_type', 'actor_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('audit_logs');
    }
};
