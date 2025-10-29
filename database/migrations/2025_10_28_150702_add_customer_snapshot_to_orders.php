<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('orders', function (Blueprint $t) {
            $t->string('customer_name', 191)->nullable()->after('customer_id');
            $t->string('customer_phone', 30)->nullable()->after('customer_name');
            $t->text('customer_address')->nullable()->after('customer_phone');
        });
    }

    public function down(): void
    {
        Schema::table('orders', function (Blueprint $t) {
            $t->dropColumn(['customer_name', 'customer_phone', 'customer_address']);
        });
    }
};
