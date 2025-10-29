<?php

namespace App\Providers;

use Illuminate\Support\Facades\Gate;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use App\Models\User;
use App\Policies\UserPolicy;
use App\Models\Cabang;
use App\Policies\CabangPolicy;
use App\Models\Gudang;
use App\Policies\GudangPolicy;
use App\Models\Category;
use App\Policies\CategoryPolicy;
use App\Models\Product;
use App\Policies\ProductPolicy;
use App\Models\ProductVariant;
use App\Policies\ProductVariantPolicy;
use App\Models\ProductMedia;
use App\Policies\ProductMediaPolicy;
use App\Models\VariantStock;
use App\Policies\VariantStockPolicy;
use App\Models\Order;
use App\Policies\OrderPolicy;
use App\Models\Delivery;
use App\Policies\DeliveryPolicy;
use App\Models\CashMove;
use App\Policies\CashMovePolicy;
use App\Models\CashHolder;
use App\Policies\CashHolderPolicy;
use App\Models\Fee;
use App\Policies\FeePolicy;
use App\Models\Customer;
use App\Policies\CustomerPolicy;
use App\Models\Setting;
use App\Policies\SettingPolicy;
use App\Models\Backup;
use App\Policies\BackupPolicy;
use App\Policies\DashboardPolicy;
use App\Models\{Account, JournalEntry, FiscalPeriod};
use App\Policies\{AccountPolicy, JournalEntryPolicy, FiscalPeriodPolicy};

class AuthServiceProvider extends ServiceProvider
{
    protected $policies = [
        User::class => UserPolicy::class,
        Cabang::class => CabangPolicy::class,
        Gudang::class => GudangPolicy::class,
        Category::class => CategoryPolicy::class,
        Product::class => ProductPolicy::class,
        ProductVariant::class => ProductVariantPolicy::class,
        ProductMedia::class => ProductMediaPolicy::class,
        VariantStock::class => VariantStockPolicy::class,
        Order::class => OrderPolicy::class,
        Delivery::class => DeliveryPolicy::class,
        CashMove::class => CashMovePolicy::class,
        CashHolder::class => CashHolderPolicy::class,
        Fee::class => FeePolicy::class,
        Customer::class => CustomerPolicy::class,
        Setting::class => SettingPolicy::class,
        Backup::class  => BackupPolicy::class,
        Account::class      => AccountPolicy::class,
        JournalEntry::class => JournalEntryPolicy::class,
        FiscalPeriod::class => FiscalPeriodPolicy::class,
    ];

    public function boot(): void
    {
        $this->registerPolicies();

        Gate::policy('dashboard', DashboardPolicy::class);

        Gate::before(function ($user, $ability) {
            return $user->hasAnyRole(['superadmin']) ? true : null;
        });
    }
}
