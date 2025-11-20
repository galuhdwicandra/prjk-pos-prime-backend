<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('receipts', function (Blueprint $table) {
            $table->bigIncrements('id');

            // Relasi ke orders (wajib ada)
            $table->foreignId('order_id')
                ->constrained('orders')
                ->onUpdate('cascade')
                ->onDelete('cascade');

            /**
             * Format kertas thermal:
             *  - 58 = 58mm
             *  - 80 = 80mm
             * Pakai smallInteger agar portable (bisa juga enum, tapi smallint lebih aman lintas DB).
             */
            $table->smallInteger('print_format')->default(58); // 58 atau 80

            // Snapshot HTML yang ditampilkan/di-print di frontend
            $table->longText('html_snapshot');

            // Info opsional (mungkin dipakai di re-print / kirim WA)
            $table->string('wa_url')->nullable();         // jika kamu simpan link WA terakhir
            $table->foreignId('printed_by')->nullable()   // user/kasir yang nge-print
                ->constrained('users')
                ->nullOnDelete();

            $table->timestampTz('printed_at')->useCurrent(); // waktu cetak (tz-aware)

            // Jika ini hasil re-print, simpan referensi ke receipt awal
            $table->foreignId('reprint_of_id')->nullable()
                ->constrained('receipts')
                ->nullOnDelete();

            $table->timestamps();

            // Index berguna
            $table->index(['order_id', 'printed_at']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('receipts');
    }
};
