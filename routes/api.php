<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\CabangController;
use App\Http\Controllers\Api\GudangController;
use App\Http\Controllers\Api\CategoryController;
use App\Http\Controllers\Api\ProductController;
use App\Http\Controllers\Api\ProductVariantController;
use App\Http\Controllers\Api\ProductMediaController;
use App\Http\Controllers\Api\VariantStockController;
use App\Http\Controllers\Api\OrderController;
use App\Http\Controllers\Api\OrdersController;
use App\Http\Controllers\Api\DeliveriesController;
use App\Http\Controllers\Api\CashController;
use App\Http\Controllers\Api\FeeEntryController;
use App\Http\Controllers\Api\FeeController;
use App\Http\Controllers\Api\CustomersController;
use App\Http\Controllers\Api\DashboardController;
use App\Http\Controllers\Api\SettingsController;
use App\Http\Controllers\Api\AccountController;
use App\Http\Controllers\Api\JournalController;
use App\Http\Controllers\Api\FiscalPeriodController;
use App\Http\Controllers\Api\AccountingReportController;
use App\Http\Controllers\Api\PaymentWebhookController;

Route::prefix('v1')->group(function () {
    // public
    Route::post('/auth/login', [AuthController::class, 'login']);

    Route::post('/webhooks/xendit/invoice', [PaymentWebhookController::class, 'invoice']);

    // protected
    Route::middleware('auth:sanctum')->group(function () {
        Route::get('/auth/me', [AuthController::class, 'me']);
        Route::post('/auth/logout', [AuthController::class, 'logout']);

        // Users (RBAC via Policy)
        Route::get('/users', [UserController::class, 'index']);
        Route::post('/users', [UserController::class, 'store']);
        Route::get('/users/{id}', [UserController::class, 'show']);
        Route::put('/users/{id}', [UserController::class, 'update']);
        Route::delete('/users/{id}', [UserController::class, 'destroy']);

        // Cabang
        Route::get('cabangs', [CabangController::class, 'index']);
        Route::post('cabangs', [CabangController::class, 'store']);
        Route::get('cabangs/{cabang}', [CabangController::class, 'show']);
        Route::put('cabangs/{cabang}', [CabangController::class, 'update']);
        Route::patch('cabangs/{cabang}', [CabangController::class, 'update']);
        Route::delete('cabangs/{cabang}', [CabangController::class, 'destroy']);

        // Gudang
        Route::get('gudangs', [GudangController::class, 'index']);
        Route::post('gudangs', [GudangController::class, 'store']);
        Route::get('gudangs/{gudang}', [GudangController::class, 'show']);
        Route::put('gudangs/{gudang}', [GudangController::class, 'update']);
        Route::patch('gudangs/{gudang}', [GudangController::class, 'update']);
        Route::delete('gudangs/{gudang}', [GudangController::class, 'destroy']);

        // Kategori (CRUD)
        Route::get('/categories', [CategoryController::class, 'index']);
        Route::post('/categories', [CategoryController::class, 'store']);
        Route::get('/categories/{category}', [CategoryController::class, 'show']);
        Route::put('/categories/{category}', [CategoryController::class, 'update']);
        Route::patch('/categories/{category}', [CategoryController::class, 'update']);
        Route::delete('/categories/{category}', [CategoryController::class, 'destroy']);

        // PRODUCTS
        Route::get('/products', [ProductController::class, 'index']);
        Route::post('/products', [ProductController::class, 'store']);
        Route::get('/products/{product}', [ProductController::class, 'show']);
        Route::put('/products/{product}', [ProductController::class, 'update']);
        Route::patch('/products/{product}', [ProductController::class, 'update']);
        Route::delete('/products/{product}', [ProductController::class, 'destroy']);

        // VARIANTS (nested under product)
        Route::get('/variants', [ProductVariantController::class, 'search']);
        Route::get('/products/{product}/variants', [ProductVariantController::class, 'index']);
        Route::post('/products/{product}/variants', [ProductVariantController::class, 'store']);
        Route::get('/products/{product}/variants/{variant}', [ProductVariantController::class, 'show']);
        Route::put('/products/{product}/variants/{variant}', [ProductVariantController::class, 'update']);
        Route::patch('/products/{product}/variants/{variant}', [ProductVariantController::class, 'update']);
        Route::delete('/products/{product}/variants/{variant}', [ProductVariantController::class, 'destroy']);

        // MEDIA (nested under product)
        Route::get('/products/{product}/media', [ProductMediaController::class, 'index']);
        Route::post('/products/{product}/media', [ProductMediaController::class, 'store']);
        Route::post('/products/{product}/media/set-primary', [ProductMediaController::class, 'setPrimary']);
        Route::post('/products/{product}/media/reorder', [ProductMediaController::class, 'reorder']);
        Route::delete('/products/{product}/media/{media}', [ProductMediaController::class, 'destroy']);

        // Stok Gudang
        Route::get('/stocks', [VariantStockController::class, 'index']);
        Route::get('/stocks/{stock}', [VariantStockController::class, 'show']);
        Route::post('/stocks', [VariantStockController::class, 'store']);   // set stok awal / upsert
        Route::patch('/stocks/{stock}', [VariantStockController::class, 'update']);  // update min_stok
        Route::post('/stocks/{stock}/adjust', [VariantStockController::class, 'adjust']);  // adjust +/-
        Route::delete('/stocks/{stock}', [VariantStockController::class, 'destroy']); // hard delete

        // POS — Orders
        // Print receipt (HTML)
        Route::get('/orders/{order}/print', [OrderController::class, 'print'])->whereNumber('order');

        Route::get('/orders', [OrderController::class, 'index']);
        Route::get('/orders/{order}', [OrderController::class, 'show'])->whereNumber('order');

        // Cart & Quote
        Route::post('/cart/quote', [OrderController::class, 'quote']);

        // Checkout (create order + optional payment)
        Route::post('/checkout', [OrderController::class, 'checkout']);

        // Update items of an order (DRAFT/UNPAID)
        Route::put('/orders/{order}', [OrderController::class, 'update'])->whereNumber('order');

        // Payment (split tender supported)
        Route::post('/orders/{order}/payments', [OrderController::class, 'addPayment'])->whereNumber('order');

        // Cancel / Void
        Route::post('/orders/{order}/cancel', [OrderController::class, 'cancel'])->whereNumber('order');

        Route::get('/orders', [OrdersController::class, 'index']);
        Route::get('/orders/{order}',         [OrdersController::class, 'show']);
        Route::put('/orders/{order}/items',   [OrdersController::class, 'updateItems']);
        Route::post('/orders/{order}/reprint', [OrdersController::class, 'reprint']);
        Route::post('/orders/{order}/resend-wa', [OrdersController::class, 'resendWA']);
        Route::post('/orders/{order}/cash-position', [OrderController::class, 'setCashPosition'])
            ->whereNumber('order');

        Route::get('/deliveries/{id}/note', [DeliveriesController::class, 'note']);
        Route::post('/deliveries/{id}/send-wa', [DeliveriesController::class, 'sendWa']);
        Route::get('/deliveries', [DeliveriesController::class, 'index']);
        Route::get('/deliveries/{id}', [DeliveriesController::class, 'show']);
        Route::post('/deliveries', [DeliveriesController::class, 'store']);

        // custom actions
        Route::post('/deliveries/{id}/assign', [DeliveriesController::class, 'assign']); // json: {assigned_to:int}
        Route::post('/deliveries/{id}/status', [DeliveriesController::class, 'updateStatus']); // multipart/form-data supported
        Route::post('/deliveries/{id}/events', [DeliveriesController::class, 'addEvent']); // multipart/form-data

        // Cash (M8)
        Route::get('cash/holders', [CashController::class, 'holders']);
        Route::post('cash/holders', [CashController::class, 'storeHolder']);
        Route::get('cash/moves',   [CashController::class, 'moves']);
        Route::post('cash/moves',  [CashController::class, 'store']);
        Route::post('cash/moves/{move}/approve', [CashController::class, 'approve']);
        Route::post('cash/moves/{move}/reject',  [CashController::class, 'reject']);
        Route::delete('cash/moves/{move}',       [CashController::class, 'destroy']);

        Route::apiResource('fees', FeeController::class)->only([
            'index',
            'show',
            'store',
            'update',
            'destroy'
        ]);
        Route::get('/fee-entries', [FeeEntryController::class, 'index']);
        Route::get('/fee-entries/export', [FeeEntryController::class, 'export']);
        Route::post('/fee-entries/pay', [FeeEntryController::class, 'pay']);

        Route::get('/customers', [CustomersController::class, 'index']);
        Route::get('/customers/{customer}', [CustomersController::class, 'show']);
        Route::post('/customers', [CustomersController::class, 'store']);
        Route::put('/customers/{customer}', [CustomersController::class, 'update']);
        Route::delete('/customers/{customer}', [CustomersController::class, 'destroy']);

        Route::get('/customers/{customer}/history', [CustomersController::class, 'history']);
        Route::post('/customers/{customer}/stage', [CustomersController::class, 'setStage']);

        Route::get('/dashboard/kpis', [DashboardController::class, 'kpis']);
        Route::get('/dashboard/chart7d', [DashboardController::class, 'chart7d']);
        Route::get('/dashboard/top-products', [DashboardController::class, 'topProducts']);
        Route::get('/dashboard/low-stock', [DashboardController::class, 'lowStock']);
        Route::get('/dashboard/quick-actions', [DashboardController::class, 'quickActions']);

        Route::get('/settings', [SettingsController::class, 'index']);
        Route::post('/settings/upsert', [SettingsController::class, 'upsert']);
        Route::post('/settings/bulk-upsert', [SettingsController::class, 'bulkUpsert']);
        Route::delete('/settings/{setting}', [SettingsController::class, 'destroy']);
        Route::get('/settings/export', [SettingsController::class, 'export']);
        Route::post('/settings/import', [SettingsController::class, 'import']);

        Route::prefix('accounting')->group(function () {
            // COA
            Route::get('/accounts', [AccountController::class, 'index']);
            Route::post('/accounts', [AccountController::class, 'store']);
            Route::put('/accounts/{account}', [AccountController::class, 'update']);
            Route::delete('/accounts/{account}', [AccountController::class, 'destroy']);

            // Journals
            Route::get('/journals', [JournalController::class, 'index']);
            Route::post('/journals', [JournalController::class, 'store']);
            Route::put('/journals/{journal}', [JournalController::class, 'update']);
            Route::post('/journals/{journal}/post', [JournalController::class, 'post']);
            Route::delete('/journals/{journal}', [JournalController::class, 'destroy']);

            // Periods
            Route::get('/periods', [FiscalPeriodController::class, 'index']);
            Route::post('/periods/open', [FiscalPeriodController::class, 'open']);
            Route::post('/periods/close', [FiscalPeriodController::class, 'close']);

            // Reports
            Route::get('/reports/trial-balance', [AccountingReportController::class, 'trialBalance']);
            Route::get('/reports/general-ledger', [AccountingReportController::class, 'generalLedger']);
            Route::get('/reports/profit-loss', [AccountingReportController::class, 'profitLoss']);
            Route::get('/reports/balance-sheet', [AccountingReportController::class, 'balanceSheet']);
        });
    });
});
