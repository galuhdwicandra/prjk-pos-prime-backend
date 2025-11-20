<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('cash_sessions', function (Blueprint $t) {
            $t->id();
            $t->foreignId('cabang_id')->constrained('cabangs');
            $t->foreignId('cashier_id')->constrained('users');
            $t->decimal('opening_amount', 18, 2)->default(0);
            $t->decimal('closing_amount', 18, 2)->nullable();
            $t->enum('status', ['OPEN', 'CLOSED'])->default('OPEN');
            $t->timestamp('opened_at');
            $t->timestamp('closed_at')->nullable();
            $t->timestamps();
            $t->index(['cabang_id', 'cashier_id', 'opened_at']);
            $t->index('status');
        });

        Schema::create('cash_transactions', function (Blueprint $t) {
            $t->id();
            $t->foreignId('session_id')->constrained('cash_sessions')->cascadeOnDelete();
            $t->enum('type', ['IN', 'OUT']);
            $t->decimal('amount', 18, 2);
            $t->enum('source', ['ORDER', 'MANUAL', 'REFUND']);
            $t->string('ref_type', 50)->nullable();
            $t->unsignedBigInteger('ref_id')->nullable();
            $t->text('note')->nullable();
            $t->timestamp('occurred_at');
            $t->timestamps();
            $t->index(['session_id', 'occurred_at']);
            $t->index(['ref_type', 'ref_id']);
        });

        Schema::create('cash_holders', function (Blueprint $t) {
            $t->id();
            $t->foreignId('cabang_id')->constrained('cabangs');
            $t->string('name', 120);
            $t->decimal('balance', 18, 2)->default(0);
            $t->timestamps();
            $t->index(['cabang_id', 'name']);
        });

        Schema::create('cash_moves', function (Blueprint $t) {
            $t->id();
            $t->foreignId('from_holder_id')->constrained('cash_holders');
            $t->foreignId('to_holder_id')->constrained('cash_holders');
            $t->decimal('amount', 18, 2);
            $t->text('note')->nullable();
            $t->timestamp('moved_at');
            // ---- workflow fields (Option A) ----
            $t->enum('status', ['DRAFT', 'SUBMITTED', 'APPROVED', 'REJECTED'])->default('DRAFT');
            $t->foreignId('submitted_by')->nullable()->constrained('users');
            $t->foreignId('approved_by')->nullable()->constrained('users');
            $t->timestamp('approved_at')->nullable();
            $t->timestamp('rejected_at')->nullable();
            $t->text('reject_reason')->nullable();
            $t->string('idempotency_key', 64)->nullable()->unique();
            $t->timestamps();
            $t->index('moved_at');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('cash_moves');
        Schema::dropIfExists('cash_holders');
        Schema::dropIfExists('cash_transactions');
        Schema::dropIfExists('cash_sessions');
    }
};
