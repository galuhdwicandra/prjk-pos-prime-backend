<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration {
    private function fkExists(string $table, string $constraint): bool
    {
        $driver = Schema::getConnection()->getDriverName();

        if ($driver === 'pgsql') {
            // PostgreSQL: cek di information_schema (schema aktif)
            $row = DB::selectOne("
                SELECT tc.constraint_name
                FROM information_schema.table_constraints tc
                WHERE tc.constraint_type = 'FOREIGN KEY'
                  AND tc.table_schema = current_schema()
                  AND tc.table_name = ?
                  AND tc.constraint_name = ?
                LIMIT 1
            ", [$table, $constraint]);
        } else {
            // MySQL/MariaDB
            $row = DB::selectOne("
                SELECT CONSTRAINT_NAME
                FROM information_schema.table_constraints
                WHERE table_schema = DATABASE()
                  AND table_name = ?
                  AND constraint_name = ?
                  AND constraint_type = 'FOREIGN KEY'
                LIMIT 1
            ", [$table, $constraint]);
        }

        return (bool) $row;
    }

    public function up(): void
    {
        // 1) Bersihkan data 'yatim' dengan sintaks portable

        // a) cabang_id = 0 -> NULL
        DB::table('users')
            ->where('cabang_id', 0)
            ->update(['cabang_id' => null]);

        // b) cabang_id tidak punya pasangan di cabangs -> NULL
        //    Pakai subquery NOT EXISTS (jalan di MySQL & PostgreSQL)
        DB::statement("
            UPDATE users u
            SET cabang_id = NULL
            WHERE u.cabang_id IS NOT NULL
              AND NOT EXISTS (
                SELECT 1 FROM cabangs c WHERE c.id = u.cabang_id
              )
        ");

        // 2) Tambah FK hanya jika belum ada
        if (!$this->fkExists('users', 'users_cabang_id_foreign')) {
            Schema::table('users', function (Blueprint $table) {
                // Pastikan kolom nullable agar nullOnDelete masuk akal
                // (abaikan jika sudah nullable)
                // $table->unsignedBigInteger('cabang_id')->nullable()->change(); // aktifkan jika perlu

                $table->foreign('cabang_id')
                    ->references('id')
                    ->on('cabangs')
                    ->nullOnDelete();
            });
        }
    }

    public function down(): void
    {
        if ($this->fkExists('users', 'users_cabang_id_foreign')) {
            Schema::table('users', function (Blueprint $table) {
                $table->dropForeign('users_cabang_id_foreign');
            });
        }
    }
};
