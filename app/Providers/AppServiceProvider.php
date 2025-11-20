<?php

namespace App\Providers;

use Illuminate\Auth\Notifications\ResetPassword;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\DB;   // <-- sudah ada
use Illuminate\Support\Facades\Log;  // <-- sudah ada
use App\Services\XenditService;      // <-- TAMBAHKAN BARIS INI

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        // === TAMBAHKAN BLOK INI ===
        $this->app->singleton(XenditService::class, function () {
            $cfg = config('services.xendit', []);
            return new XenditService(
                baseUrl:    $cfg['base_url']       ?? env('XENDIT_BASE_URL', ''),
                secret:     $cfg['secret']         ?? env('XENDIT_SECRET_KEY', ''),
                cbToken:    $cfg['callback_token'] ?? env('XENDIT_CALLBACK_TOKEN', ''),
                successUrl: env('XENDIT_SUCCESS_URL', ''),
                failureUrl: env('XENDIT_FAILURE_URL', '')
            );
        });
        // === SELESAI TAMBAHAN ===
    }

    public function boot(): void
    {
        // ===== EXISTING: reset password link ke FE =====
        ResetPassword::createUrlUsing(function (object $notifiable, string $token) {
            return config('app.frontend_url') . "/password-reset/$token?email={$notifiable->getEmailForPasswordReset()}";
        });

        // ===== EXISTING: query tracing =====
        if (! app()->isProduction()) {
            DB::listen(function ($query) {
                $sql = $query->sql;

                $needTrace =
                    str_contains($sql, 'discount_total') ||
                    str_contains($sql, 'payment_status');

                if ($needTrace) {
                    Log::error('TRACE_QUERY_BAD_COLUMNS', [
                        'sql'      => $sql,
                        'bindings' => $query->bindings,
                        'time_ms'  => $query->time,
                        'trace'    => collect(debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS, 15))
                            ->map(fn($t) => ($t['file'] ?? '?') . ':' . ($t['line'] ?? '?') . '::' . ($t['function'] ?? '?'))
                            ->all(),
                    ]);
                }
            });
        }
    }
}
