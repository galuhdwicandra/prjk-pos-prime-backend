<?php

namespace App\Providers;

use Illuminate\Auth\Notifications\ResetPassword;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\DB;   // <-- tambahkan
use Illuminate\Support\Facades\Log;  // <-- tambahkan

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        //
    }

    public function boot(): void
    {
        // ===== EXISTING: reset password link ke FE =====
        ResetPassword::createUrlUsing(function (object $notifiable, string $token) {
            return config('app.frontend_url') . "/password-reset/$token?email={$notifiable->getEmailForPasswordReset()}";
        });

        // ===== NEW: query tracing untuk cari sumber 'discount_total' / 'payment_status' =====
        if (! app()->isProduction()) { // aktifkan hanya di non-production
            DB::listen(function ($query) {
                $sql = $query->sql;

                // target kata kunci yang memicu 500
                $needTrace =
                    str_contains($sql, 'discount_total') ||
                    str_contains($sql, 'payment_status');

                if ($needTrace) {
                    Log::error('TRACE_QUERY_BAD_COLUMNS', [
                        'sql'      => $sql,
                        'bindings' => $query->bindings,
                        'time_ms'  => $query->time,
                        // jejak singkat biar tahu asal pemanggil
                        'trace'    => collect(debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS, 15))
                            ->map(fn($t) => ($t['file'] ?? '?') . ':' . ($t['line'] ?? '?') . '::' . ($t['function'] ?? '?'))
                            ->all(),
                    ]);
                }
            });
        }
    }
}
