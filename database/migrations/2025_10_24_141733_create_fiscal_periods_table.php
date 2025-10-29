<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('fiscal_periods', function (Blueprint $t) {
            $t->id();
            $t->unsignedBigInteger('cabang_id')->index();
            $t->unsignedSmallInteger('year');
            $t->unsignedTinyInteger('month'); // 1..12
            // status: OPEN/CLOSED
            $t->string('status', 6)->default('OPEN')->index();
            $t->timestamps();

            $t->unique(['cabang_id', 'year', 'month']);
            $t->foreign('cabang_id')->references('id')->on('cabangs')->onDelete('cascade');
        });
    }
    public function down(): void
    {
        Schema::dropIfExists('fiscal_periods');
    }
};
