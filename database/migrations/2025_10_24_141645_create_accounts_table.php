<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('accounts', function (Blueprint $t) {
            $t->id();
            $t->unsignedBigInteger('cabang_id')->nullable()->index();
            $t->string('code', 32)->unique();
            $t->string('name', 160);
            // type: Asset/Liability/Equity/Revenue/Expense
            $t->string('type', 20)->index();
            // normal_balance: DEBIT/CREDIT
            $t->string('normal_balance', 6);
            $t->unsignedBigInteger('parent_id')->nullable()->index();
            $t->boolean('is_active')->default(true)->index();
            $t->timestamps();

            $t->foreign('parent_id')->references('id')->on('accounts')->onDelete('restrict');
            $t->foreign('cabang_id')->references('id')->on('cabangs')->onDelete('set null');
        });
    }
    public function down(): void
    {
        Schema::dropIfExists('accounts');
    }
};
