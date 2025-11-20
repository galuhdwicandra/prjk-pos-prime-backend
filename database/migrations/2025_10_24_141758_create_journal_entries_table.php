<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('journal_entries', function (Blueprint $t) {
            $t->id();
            $t->unsignedBigInteger('cabang_id')->index();
            $t->date('journal_date')->index();
            $t->string('number', 40)->index(); // bebas (auto/diisi UI); jaga idempotency
            $t->string('description', 255)->nullable();
            // status: DRAFT/POSTED
            $t->string('status', 6)->default('DRAFT')->index();
            $t->unsignedSmallInteger('period_year');
            $t->unsignedTinyInteger('period_month');
            $t->timestamps();

            $t->unique(['cabang_id', 'number']); // idempotency by cabang
            $t->foreign('cabang_id')->references('id')->on('cabangs')->onDelete('cascade');
        });
    }
    public function down(): void
    {
        Schema::dropIfExists('journal_entries');
    }
};
