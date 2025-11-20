<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('gudangs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('cabang_id')->constrained('cabangs')->cascadeOnDelete();
            $table->string('nama', 120);
            $table->boolean('is_default')->default(false);
            $table->boolean('is_active')->default(true)->index();
            $table->timestamps();

            $table->index(['cabang_id', 'is_active']);
            // Catatan: unik "default per cabang" akan dijaga di level service (MySQL tidak punya partial unique index).
            // $table->unique(['cabang_id', 'is_default']); // BISA membatasi hanya satu baris is_default=0 & satu baris is_default=1 per cabang, TIDAK SESUAI kebutuhan.
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('gudangs');
    }
};
