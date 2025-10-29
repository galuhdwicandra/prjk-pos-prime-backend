<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration {
    private array $values = ['CUSTOMER', 'CASHIER', 'SALES', 'ADMIN'];

    public function up(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->string('cash_position', 16)->nullable()->index()->after('status');
        });

        // PostgreSQL: tambahkan CHECK
        $driver = DB::getDriverName();
        if ($driver === 'pgsql') {
            $vals = "'" . implode("','", $this->values) . "'";
            DB::statement("ALTER TABLE orders
                ADD CONSTRAINT orders_cash_position_check
                CHECK (cash_position IS NULL OR cash_position IN ($vals))");
        }
        // MySQL bisa pakai ENUM (opsional), kalau mau tetap string + app-level validation juga oke.
    }

    public function down(): void
    {
        // Drop constraint pgsql (aman kalau belum ada)
        $driver = DB::getDriverName();
        if ($driver === 'pgsql') {
            @DB::statement("ALTER TABLE orders DROP CONSTRAINT IF EXISTS orders_cash_position_check");
        }

        Schema::table('orders', function (Blueprint $table) {
            $table->dropColumn('cash_position');
        });
    }
};
