<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('settings', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->enum('scope', ['GLOBAL', 'BRANCH', 'USER']);
            $table->unsignedBigInteger('scope_id')->nullable();
            $table->string('key', 150);
            $table->json('value_json');
            $table->timestamps();
            $table->unique(['scope', 'scope_id', 'key'], 'settings_scope_key_uk');
            $table->index(['scope', 'scope_id'], 'settings_scope_idx');
        });
    }
    public function down(): void
    {
        Schema::dropIfExists('settings');
    }
};
