<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('audit_logs', function (Blueprint $table) {
            if (!Schema::hasColumn('audit_logs', 'occurred_at')) {
                $table->timestamp('occurred_at')->nullable()->index()->after('diff_json');
            }
        });
    }

    public function down(): void
    {
        Schema::table('audit_logs', function (Blueprint $table) {
            if (Schema::hasColumn('audit_logs', 'occurred_at')) {
                $table->dropIndex(['occurred_at']);
                $table->dropColumn('occurred_at');
            }
        });
    }
};
