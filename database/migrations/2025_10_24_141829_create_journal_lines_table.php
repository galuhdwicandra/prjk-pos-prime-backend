<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('journal_lines', function (Blueprint $t) {
            $t->id();
            $t->unsignedBigInteger('journal_id')->index();
            $t->unsignedBigInteger('account_id')->index();
            $t->unsignedBigInteger('cabang_id')->index();
            $t->decimal('debit', 18, 2)->default(0);
            $t->decimal('credit', 18, 2)->default(0);
            $t->string('ref_type', 50)->nullable()->index(); // 'order','payment','fee', dst.
            $t->unsignedBigInteger('ref_id')->nullable()->index();
            $t->timestamps();

            $t->foreign('journal_id')->references('id')->on('journal_entries')->onDelete('cascade');
            $t->foreign('account_id')->references('id')->on('accounts')->onDelete('restrict');
            $t->foreign('cabang_id')->references('id')->on('cabangs')->onDelete('cascade');
        });
    }
    public function down(): void
    {
        Schema::dropIfExists('journal_lines');
    }
};
