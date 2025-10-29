<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        // Guarded add: only add FK if customers exists and orders.customer_id exists
        DB::statement('
            DO $$
            BEGIN
                IF EXISTS (SELECT 1 FROM information_schema.columns
                           WHERE table_name = \'orders\' AND column_name = \'customer_id\') THEN
                    BEGIN
                        EXECUTE \'ALTER TABLE "orders"
                                 ADD CONSTRAINT "orders_customer_id_fkey"
                                 FOREIGN KEY ("customer_id")
                                 REFERENCES "customers" ("id")
                                 ON UPDATE CASCADE ON DELETE SET NULL\';
                    EXCEPTION WHEN duplicate_object THEN
                        -- Already added; ignore
                        NULL;
                    END;
                END IF;
            END$$;
        ');
    }

    public function down(): void
    {
        DB::statement('
            DO $$
            BEGIN
                BEGIN
                    EXECUTE \'ALTER TABLE "orders" DROP CONSTRAINT IF EXISTS "orders_customer_id_fkey"\';
                EXCEPTION WHEN undefined_object THEN
                    NULL;
                END;
            END$$;
        ');
    }
};
