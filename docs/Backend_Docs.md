# Dokumentasi Backend (FULL Source)

_Dihasilkan otomatis: 2025-11-10 15:21:38_  
**Root:** `/home/galuhdwicandra/projects/clone/project-order/backend`


## Daftar Isi

- [Controllers (app/Http/Controllers/Api)](#controllers-apphttpcontrollersapi)
  - [app/Http/Controllers/Api/AccountController.php](#file-apphttpcontrollersapiaccountcontrollerphp)
  - [app/Http/Controllers/Api/AccountingReportController.php](#file-apphttpcontrollersapiaccountingreportcontrollerphp)
  - [app/Http/Controllers/Api/AuthController.php](#file-apphttpcontrollersapiauthcontrollerphp)
  - [app/Http/Controllers/Api/CabangController.php](#file-apphttpcontrollersapicabangcontrollerphp)
  - [app/Http/Controllers/Api/CashController.php](#file-apphttpcontrollersapicashcontrollerphp)
  - [app/Http/Controllers/Api/CategoryController.php](#file-apphttpcontrollersapicategorycontrollerphp)
  - [app/Http/Controllers/Api/CustomersController.php](#file-apphttpcontrollersapicustomerscontrollerphp)
  - [app/Http/Controllers/Api/DashboardController.php](#file-apphttpcontrollersapidashboardcontrollerphp)
  - [app/Http/Controllers/Api/DeliveriesController.php](#file-apphttpcontrollersapideliveriescontrollerphp)
  - [app/Http/Controllers/Api/FeeController.php](#file-apphttpcontrollersapifeecontrollerphp)
  - [app/Http/Controllers/Api/FeeEntryController.php](#file-apphttpcontrollersapifeeentrycontrollerphp)
  - [app/Http/Controllers/Api/FiscalPeriodController.php](#file-apphttpcontrollersapifiscalperiodcontrollerphp)
  - [app/Http/Controllers/Api/GudangController.php](#file-apphttpcontrollersapigudangcontrollerphp)
  - [app/Http/Controllers/Api/JournalController.php](#file-apphttpcontrollersapijournalcontrollerphp)
  - [app/Http/Controllers/Api/OrderController.php](#file-apphttpcontrollersapiordercontrollerphp)
  - [app/Http/Controllers/Api/OrdersController.php](#file-apphttpcontrollersapiorderscontrollerphp)
  - [app/Http/Controllers/Api/PaymentWebhookController.php](#file-apphttpcontrollersapipaymentwebhookcontrollerphp)
  - [app/Http/Controllers/Api/ProductController.php](#file-apphttpcontrollersapiproductcontrollerphp)
  - [app/Http/Controllers/Api/ProductMediaController.php](#file-apphttpcontrollersapiproductmediacontrollerphp)
  - [app/Http/Controllers/Api/ProductVariantController.php](#file-apphttpcontrollersapiproductvariantcontrollerphp)
  - [app/Http/Controllers/Api/SettingsController.php](#file-apphttpcontrollersapisettingscontrollerphp)
  - [app/Http/Controllers/Api/UserController.php](#file-apphttpcontrollersapiusercontrollerphp)
  - [app/Http/Controllers/Api/VariantStockController.php](#file-apphttpcontrollersapivariantstockcontrollerphp)

- [Models (app/Models)](#models-appmodels)
  - [app/Models/Account.php](#file-appmodelsaccountphp)
  - [app/Models/AuditLog.php](#file-appmodelsauditlogphp)
  - [app/Models/Backup.php](#file-appmodelsbackupphp)
  - [app/Models/Cabang.php](#file-appmodelscabangphp)
  - [app/Models/CashHolder.php](#file-appmodelscashholderphp)
  - [app/Models/CashMove.php](#file-appmodelscashmovephp)
  - [app/Models/CashSession.php](#file-appmodelscashsessionphp)
  - [app/Models/CashTransaction.php](#file-appmodelscashtransactionphp)
  - [app/Models/Category.php](#file-appmodelscategoryphp)
  - [app/Models/Customer.php](#file-appmodelscustomerphp)
  - [app/Models/CustomerTimeline.php](#file-appmodelscustomertimelinephp)
  - [app/Models/Delivery.php](#file-appmodelsdeliveryphp)
  - [app/Models/DeliveryEvent.php](#file-appmodelsdeliveryeventphp)
  - [app/Models/Fee.php](#file-appmodelsfeephp)
  - [app/Models/FeeEntry.php](#file-appmodelsfeeentryphp)
  - [app/Models/FiscalPeriod.php](#file-appmodelsfiscalperiodphp)
  - [app/Models/Gudang.php](#file-appmodelsgudangphp)
  - [app/Models/JournalEntry.php](#file-appmodelsjournalentryphp)
  - [app/Models/JournalLine.php](#file-appmodelsjournallinephp)
  - [app/Models/Order.php](#file-appmodelsorderphp)
  - [app/Models/OrderChangeLog.php](#file-appmodelsorderchangelogphp)
  - [app/Models/OrderItem.php](#file-appmodelsorderitemphp)
  - [app/Models/Payment.php](#file-appmodelspaymentphp)
  - [app/Models/Product.php](#file-appmodelsproductphp)
  - [app/Models/ProductMedia.php](#file-appmodelsproductmediaphp)
  - [app/Models/ProductVariant.php](#file-appmodelsproductvariantphp)
  - [app/Models/Receipt.php](#file-appmodelsreceiptphp)
  - [app/Models/Setting.php](#file-appmodelssettingphp)
  - [app/Models/User.php](#file-appmodelsuserphp)
  - [app/Models/VariantStock.php](#file-appmodelsvariantstockphp)

- [Policies (app/Policies)](#policies-apppolicies)
  - [app/Policies/AccountPolicy.php](#file-apppoliciesaccountpolicyphp)
  - [app/Policies/BackupPolicy.php](#file-apppoliciesbackuppolicyphp)
  - [app/Policies/CabangPolicy.php](#file-apppoliciescabangpolicyphp)
  - [app/Policies/CashHolderPolicy.php](#file-apppoliciescashholderpolicyphp)
  - [app/Policies/CashMovePolicy.php](#file-apppoliciescashmovepolicyphp)
  - [app/Policies/CategoryPolicy.php](#file-apppoliciescategorypolicyphp)
  - [app/Policies/CustomerPolicy.php](#file-apppoliciescustomerpolicyphp)
  - [app/Policies/DashboardPolicy.php](#file-apppoliciesdashboardpolicyphp)
  - [app/Policies/DeliveryPolicy.php](#file-apppoliciesdeliverypolicyphp)
  - [app/Policies/FeeEntryPolicy.php](#file-apppoliciesfeeentrypolicyphp)
  - [app/Policies/FeePolicy.php](#file-apppoliciesfeepolicyphp)
  - [app/Policies/FiscalPeriodPolicy.php](#file-apppoliciesfiscalperiodpolicyphp)
  - [app/Policies/GudangPolicy.php](#file-apppoliciesgudangpolicyphp)
  - [app/Policies/JournalEntryPolicy.php](#file-apppoliciesjournalentrypolicyphp)
  - [app/Policies/OrderPolicy.php](#file-apppoliciesorderpolicyphp)
  - [app/Policies/ProductMediaPolicy.php](#file-apppoliciesproductmediapolicyphp)
  - [app/Policies/ProductPolicy.php](#file-apppoliciesproductpolicyphp)
  - [app/Policies/ProductVariantPolicy.php](#file-apppoliciesproductvariantpolicyphp)
  - [app/Policies/SettingPolicy.php](#file-apppoliciessettingpolicyphp)
  - [app/Policies/UserPolicy.php](#file-apppoliciesuserpolicyphp)
  - [app/Policies/VariantStockPolicy.php](#file-apppoliciesvariantstockpolicyphp)

- [Form Requests (app/Http/Requests)](#form-requests-apphttprequests)
  - [app/Http/Requests/AccountStoreRequest.php](#file-apphttprequestsaccountstorerequestphp)
  - [app/Http/Requests/AccountUpdateRequest.php](#file-apphttprequestsaccountupdaterequestphp)
  - [app/Http/Requests/Auth/LoginRequest.php](#file-apphttprequestsauthloginrequestphp)
  - [app/Http/Requests/AuthLoginRequest.php](#file-apphttprequestsauthloginrequestphp)
  - [app/Http/Requests/CabangStoreRequest.php](#file-apphttprequestscabangstorerequestphp)
  - [app/Http/Requests/CabangUpdateRequest.php](#file-apphttprequestscabangupdaterequestphp)
  - [app/Http/Requests/CashHolderStoreRequest.php](#file-apphttprequestscashholderstorerequestphp)
  - [app/Http/Requests/CashMoveApproveRequest.php](#file-apphttprequestscashmoveapproverequestphp)
  - [app/Http/Requests/CashMoveRejectRequest.php](#file-apphttprequestscashmoverejectrequestphp)
  - [app/Http/Requests/CashMoveStoreRequest.php](#file-apphttprequestscashmovestorerequestphp)
  - [app/Http/Requests/Category/IndexCategoryRequest.php](#file-apphttprequestscategoryindexcategoryrequestphp)
  - [app/Http/Requests/Category/StoreCategoryRequest.php](#file-apphttprequestscategorystorecategoryrequestphp)
  - [app/Http/Requests/Category/UpdateCategoryRequest.php](#file-apphttprequestscategoryupdatecategoryrequestphp)
  - [app/Http/Requests/Customer/CustomerStoreRequest.php](#file-apphttprequestscustomercustomerstorerequestphp)
  - [app/Http/Requests/Customer/CustomerUpdateRequest.php](#file-apphttprequestscustomercustomerupdaterequestphp)
  - [app/Http/Requests/Dashboard/CommonQuery.php](#file-apphttprequestsdashboardcommonqueryphp)
  - [app/Http/Requests/Deliveries/SendDeliveryNoteRequest.php](#file-apphttprequestsdeliveriessenddeliverynoterequestphp)
  - [app/Http/Requests/DeliveryAssignRequest.php](#file-apphttprequestsdeliveryassignrequestphp)
  - [app/Http/Requests/DeliveryEventStoreRequest.php](#file-apphttprequestsdeliveryeventstorerequestphp)
  - [app/Http/Requests/DeliveryStatusRequest.php](#file-apphttprequestsdeliverystatusrequestphp)
  - [app/Http/Requests/DeliveryStoreRequest.php](#file-apphttprequestsdeliverystorerequestphp)
  - [app/Http/Requests/ExportRequest.php](#file-apphttprequestsexportrequestphp)
  - [app/Http/Requests/FeeEntryIndexRequest.php](#file-apphttprequestsfeeentryindexrequestphp)
  - [app/Http/Requests/FeeEntryPayRequest.php](#file-apphttprequestsfeeentrypayrequestphp)
  - [app/Http/Requests/FeeStoreRequest.php](#file-apphttprequestsfeestorerequestphp)
  - [app/Http/Requests/FeeUpdateRequest.php](#file-apphttprequestsfeeupdaterequestphp)
  - [app/Http/Requests/GudangStoreRequest.php](#file-apphttprequestsgudangstorerequestphp)
  - [app/Http/Requests/GudangUpdateRequest.php](#file-apphttprequestsgudangupdaterequestphp)
  - [app/Http/Requests/ImportRequest.php](#file-apphttprequestsimportrequestphp)
  - [app/Http/Requests/JournalPostRequest.php](#file-apphttprequestsjournalpostrequestphp)
  - [app/Http/Requests/JournalStoreRequest.php](#file-apphttprequestsjournalstorerequestphp)
  - [app/Http/Requests/JournalUpdateRequest.php](#file-apphttprequestsjournalupdaterequestphp)
  - [app/Http/Requests/OrderCancelRequest.php](#file-apphttprequestsordercancelrequestphp)
  - [app/Http/Requests/OrderSetCashPositionRequest.php](#file-apphttprequestsordersetcashpositionrequestphp)
  - [app/Http/Requests/OrderStoreRequest.php](#file-apphttprequestsorderstorerequestphp)
  - [app/Http/Requests/OrderUpdateRequest.php](#file-apphttprequestsorderupdaterequestphp)
  - [app/Http/Requests/Orders/IndexOrdersRequest.php](#file-apphttprequestsordersindexordersrequestphp)
  - [app/Http/Requests/Orders/ReprintReceiptRequest.php](#file-apphttprequestsordersreprintreceiptrequestphp)
  - [app/Http/Requests/Orders/ResendWARequest.php](#file-apphttprequestsordersresendwarequestphp)
  - [app/Http/Requests/Orders/UpdateOrderItemsRequest.php](#file-apphttprequestsordersupdateorderitemsrequestphp)
  - [app/Http/Requests/PaymentStoreRequest.php](#file-apphttprequestspaymentstorerequestphp)
  - [app/Http/Requests/PeriodCloseRequest.php](#file-apphttprequestsperiodcloserequestphp)
  - [app/Http/Requests/ReorderProductMediaRequest.php](#file-apphttprequestsreorderproductmediarequestphp)
  - [app/Http/Requests/SetPrimaryProductMediaRequest.php](#file-apphttprequestssetprimaryproductmediarequestphp)
  - [app/Http/Requests/SettingBulkUpsertRequest.php](#file-apphttprequestssettingbulkupsertrequestphp)
  - [app/Http/Requests/SettingQueryRequest.php](#file-apphttprequestssettingqueryrequestphp)
  - [app/Http/Requests/SettingUpsertRequest.php](#file-apphttprequestssettingupsertrequestphp)
  - [app/Http/Requests/StoreProductRequest.php](#file-apphttprequestsstoreproductrequestphp)
  - [app/Http/Requests/StoreVariantRequest.php](#file-apphttprequestsstorevariantrequestphp)
  - [app/Http/Requests/UpdateProductRequest.php](#file-apphttprequestsupdateproductrequestphp)
  - [app/Http/Requests/UpdateVariantRequest.php](#file-apphttprequestsupdatevariantrequestphp)
  - [app/Http/Requests/UploadProductMediaRequest.php](#file-apphttprequestsuploadproductmediarequestphp)
  - [app/Http/Requests/UserStoreRequest.php](#file-apphttprequestsuserstorerequestphp)
  - [app/Http/Requests/UserUpdateRequest.php](#file-apphttprequestsuserupdaterequestphp)
  - [app/Http/Requests/VariantStockAdjustRequest.php](#file-apphttprequestsvariantstockadjustrequestphp)
  - [app/Http/Requests/VariantStockStoreRequest.php](#file-apphttprequestsvariantstockstorerequestphp)
  - [app/Http/Requests/VariantStockUpdateRequest.php](#file-apphttprequestsvariantstockupdaterequestphp)

- [Services (app/Services)](#services-appservices)
  - [app/Services/AccountingService.php](#file-appservicesaccountingservicephp)
  - [app/Services/Auth/AuthService.php](#file-appservicesauthauthservicephp)
  - [app/Services/CabangService.php](#file-appservicescabangservicephp)
  - [app/Services/CashService.php](#file-appservicescashservicephp)
  - [app/Services/CategoryService.php](#file-appservicescategoryservicephp)
  - [app/Services/CheckoutService.php](#file-appservicescheckoutservicephp)
  - [app/Services/CustomerService.php](#file-appservicescustomerservicephp)
  - [app/Services/DashboardService.php](#file-appservicesdashboardservicephp)
  - [app/Services/DeliveryService.php](#file-appservicesdeliveryservicephp)
  - [app/Services/FeeService.php](#file-appservicesfeeservicephp)
  - [app/Services/GudangService.php](#file-appservicesgudangservicephp)
  - [app/Services/OrderService.php](#file-appservicesorderservicephp)
  - [app/Services/Products/ProductMediaService.php](#file-appservicesproductsproductmediaservicephp)
  - [app/Services/Products/ProductService.php](#file-appservicesproductsproductservicephp)
  - [app/Services/QuoteService.php](#file-appservicesquoteservicephp)
  - [app/Services/SalesInventoryService.php](#file-appservicessalesinventoryservicephp)
  - [app/Services/SettingService.php](#file-appservicessettingservicephp)
  - [app/Services/User/UserService.php](#file-appservicesuseruserservicephp)
  - [app/Services/VariantStockService.php](#file-appservicesvariantstockservicephp)
  - [app/Services/XenditService.php](#file-appservicesxenditservicephp)

- [routes/api.php](#routesapiphp)

- [AuthServiceProvider.php](#authserviceproviderphp)



## Controllers (app/Http/Controllers/Api)

### app/Http/Controllers/Api/AccountController.php

- SHA: `21414da7ac5b`  
- Ukuran: 1 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `AccountController` extends `Controller`**

Metode Publik:
- **index**(Request $r)
- **store**(AccountStoreRequest $req)
- **update**(AccountUpdateRequest $req, Account $account)
- **destroy**(Account $account)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\{AccountStoreRequest, AccountUpdateRequest};
use App\Models\Account;
use Illuminate\Http\Request;

class AccountController extends Controller
{
    public function index(Request $r)
    {
        $this->authorize('viewAny', Account::class);
        $q = Account::query()
            ->when($r->filled('cabang_id'), fn($x) => $x->where('cabang_id', $r->integer('cabang_id')))
            ->when($r->boolean('only_active', false), fn($x) => $x->where('is_active', true))
            ->orderBy('code');
        return response()->json(['data' => $q->get(), 'meta' => [], 'message' => 'OK', 'errors' => []]);
    }

    public function store(AccountStoreRequest $req)
    {
        $this->authorize('create', Account::class);
        $acc = Account::create($req->validated());
        return response()->json(['data' => $acc, 'meta' => [], 'message' => 'Created', 'errors' => []], 201);
    }

    public function update(AccountUpdateRequest $req, Account $account)
    {
        $this->authorize('update', $account);
        $account->update($req->validated());
        return response()->json(['data' => $account->refresh(), 'meta' => [], 'message' => 'Updated', 'errors' => []]);
    }

    public function destroy(Account $account)
    {
        $this->authorize('delete', $account);
        $account->delete();
        return response()->json(['data' => null, 'meta' => [], 'message' => 'Deleted', 'errors' => []]);
    }
}

```
</details>

### app/Http/Controllers/Api/AccountingReportController.php

- SHA: `c25d446ea57e`  
- Ukuran: 2 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `AccountingReportController` extends `Controller`**

Metode Publik:
- **__construct**(private readonly AccountingService $svc)
- **trialBalance**(Request $r)
- **generalLedger**(Request $r)
- **profitLoss**(Request $r)
- **balanceSheet**(Request $r)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\AccountingService;
use Illuminate\Http\Request;

class AccountingReportController extends Controller
{
    public function __construct(private readonly AccountingService $svc) {}

    public function trialBalance(Request $r)
    {
        $this->authorize('viewAny', \App\Models\JournalEntry::class);
        $rows = $this->svc->trialBalance($r->integer('cabang_id'), $r->integer('year'), $r->integer('month'));
        return response()->json(['data' => $rows, 'meta' => [], 'message' => 'OK', 'errors' => []]);
    }

    public function generalLedger(Request $r)
    {
        $this->authorize('viewAny', \App\Models\JournalEntry::class);
        $rows = $this->svc->generalLedger($r->integer('cabang_id'), $r->integer('account_id'), $r->integer('year'), $r->integer('month'));
        return response()->json(['data' => $rows, 'meta' => [], 'message' => 'OK', 'errors' => []]);
    }

    public function profitLoss(Request $r)
    {
        $this->authorize('viewAny', \App\Models\JournalEntry::class);
        $rows = $this->svc->profitLoss($r->integer('cabang_id'), $r->integer('year'), $r->integer('month'));
        return response()->json(['data' => $rows, 'meta' => [], 'message' => 'OK', 'errors' => []]);
    }

    public function balanceSheet(Request $r)
    {
        $this->authorize('viewAny', \App\Models\JournalEntry::class);
        $rows = $this->svc->balanceSheet($r->integer('cabang_id'), $r->integer('year'), $r->integer('month'));
        return response()->json(['data' => $rows, 'meta' => [], 'message' => 'OK', 'errors' => []]);
    }
}

```
</details>

### app/Http/Controllers/Api/AuthController.php

- SHA: `81f14019af54`  
- Ukuran: 1 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `AuthController` extends `Controller`**

Metode Publik:
- **__construct**(private readonly AuthService $auth)
- **login**(AuthLoginRequest $request)
- **me**(Request $request)
- **logout**(Request $request)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

// app/Http/Controllers/Api/AuthController.php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\AuthLoginRequest;
use App\Services\Auth\AuthService;
use Illuminate\Http\Request;

class AuthController extends Controller
{
    public function __construct(
        private readonly AuthService $auth
    ) {}

    // POST /api/v1/auth/login (public)
    public function login(AuthLoginRequest $request)
    {
        $data = $this->auth->login(
            email: $request->string('email')->toString(),
            password: $request->string('password')->toString(),
        );

        return response()->json([
            'token'      => $data['token'],
            'token_type' => $data['token_type'],
            'user'       => $data['user'],
        ]);
    }

    // GET /api/v1/auth/me (auth:sanctum)
    public function me(Request $request)
    {
        return response()->json([
            'user' => $this->auth->me($request->user()),
        ]);
    }

    // POST /api/v1/auth/logout (auth:sanctum)
    public function logout(Request $request)
    {
        $this->auth->logout($request->user());
        return response()->json(['message' => 'Logged out']);
    }
}

```
</details>

### app/Http/Controllers/Api/CabangController.php

- SHA: `622dd1efc17a`  
- Ukuran: 3 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `CabangController` extends `Controller`**

Metode Publik:
- **__construct**(private CabangService $service)
- **index**(Request $request) : *JsonResponse*
- **store**(CabangStoreRequest $request) : *JsonResponse*
- **show**(Request $request, Cabang $cabang) : *JsonResponse*
- **update**(CabangUpdateRequest $request, Cabang $cabang) : *JsonResponse*
- **destroy**(Request $request, Cabang $cabang) : *JsonResponse*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\CabangStoreRequest;
use App\Http\Requests\CabangUpdateRequest;
use App\Models\Cabang;
use App\Services\CabangService;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class CabangController extends Controller
{
    public function __construct(private CabangService $service) {}

    public function index(Request $request): JsonResponse
    {
        $this->authorize('viewAny', Cabang::class);

        $q        = $request->string('q')->toString();
        $kota     = $request->string('kota')->toString();
        $isActive = $request->has('is_active') ? filter_var($request->input('is_active'), FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE) : null;
        $perPage  = (int)($request->input('per_page', 10));
        $sort     = $request->input('sort', '-id'); // default: terbaru

        $query = $this->service->queryIndexForUser($request->user())
            ->when($q !== '', fn($qr) => $qr->where(function($w) use ($q) {
                $w->where('nama', 'like', "%{$q}%")
                  ->orWhere('kota', 'like', "%{$q}%")
                  ->orWhere('alamat', 'like', "%{$q}%");
            }))
            ->when($kota !== '', fn($qr) => $qr->where('kota', $kota))
            ->when(!is_null($isActive), fn($qr) => $qr->where('is_active', $isActive));

        // Sorting: "field" atau "-field" (desc)
        if (is_string($sort) && $sort !== '') {
            $direction = str_starts_with($sort, '-') ? 'desc' : 'asc';
            $field = ltrim($sort, '-');
            in_array($field, ['id','nama','kota','is_active','created_at']) || $field = 'id';
            $query->orderBy($field, $direction);
        }

        $paginator = $query->paginate($perPage);
        return response()->json([
            'success' => true,
            'data' => $paginator->items(),
            'meta' => [
                'current_page' => $paginator->currentPage(),
                'per_page'     => $paginator->perPage(),
                'total'        => $paginator->total(),
                'last_page'    => $paginator->lastPage(),
            ],
        ]);
    }

    public function store(CabangStoreRequest $request): JsonResponse
    {
        $this->authorize('create', Cabang::class);
        $cabang = $this->service->create($request->validated());
        return response()->json([
            'success' => true,
            'data' => $cabang,
        ], 201);
    }

    public function show(Request $request, Cabang $cabang): JsonResponse
    {
        $this->authorize('view', $cabang);
        return response()->json([
            'success' => true,
            'data' => $cabang->load('gudangs'),
        ]);
    }

    public function update(CabangUpdateRequest $request, Cabang $cabang): JsonResponse
    {
        $this->authorize('update', $cabang);
        $cabang = $this->service->update($cabang, $request->validated());
        return response()->json([
            'success' => true,
            'data' => $cabang,
        ]);
    }

    public function destroy(Request $request, Cabang $cabang): JsonResponse
    {
        $this->authorize('delete', $cabang);
        $this->service->delete($cabang);
        return response()->json([
            'success' => true,
        ], 204);
    }
}

```
</details>

### app/Http/Controllers/Api/CashController.php

- SHA: `80058b5a7222`  
- Ukuran: 3 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `CashController` extends `Controller`**

Metode Publik:
- **__construct**(private CashService $svc)
- **holders**(Request $r) : *JsonResponse*
- **storeHolder**(CashHolderStoreRequest $req) : *JsonResponse*
- **moves**(Request $r) : *JsonResponse*
- **store**(CashMoveStoreRequest $req) : *JsonResponse*
- **approve**(CashMoveApproveRequest $req, CashMove $move) : *JsonResponse*
- **reject**(CashMoveRejectRequest $req, CashMove $move) : *JsonResponse*
- **destroy**(Request $req, CashMove $move) : *JsonResponse*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\{CashMoveStoreRequest, CashMoveApproveRequest, CashMoveRejectRequest, CashHolderStoreRequest};
use App\Models\{CashHolder, CashMove};
use App\Services\CashService;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class CashController extends Controller
{
    public function __construct(private CashService $svc) {}

    // GET /api/v1/cash/holders
    public function holders(Request $r): JsonResponse
    {
        $this->authorize('viewAny', CashHolder::class);
        $q = CashHolder::query()
            ->when($r->filled('cabang_id'), fn($qq) => $qq->where('cabang_id', $r->integer('cabang_id')));
        // scope by branch unless superadmin handled in global scopes/Policies (kept simple here)
        return response()->json($q->orderBy('name')->paginate((int)$r->input('per_page', 15)));
    }

    public function storeHolder(CashHolderStoreRequest $req): JsonResponse
    {
        $this->authorize('create', CashHolder::class);
        $data = $req->validated();
        $holder = new CashHolder([
            'cabang_id' => $data['cabang_id'],
            'name'      => $data['name'],
            'balance'   => $data['opening_balance'] ?? 0,
        ]);
        $holder->save();
        return response()->json($holder, 201);
    }

    // GET /api/v1/cash/moves
    public function moves(Request $r): JsonResponse
    {
        $q = CashMove::query()
            ->with(['from', 'to', 'submitter', 'approver'])
            ->when($r->filled('status'), fn($qq) => $qq->where('status', $r->string('status')))
            ->orderByDesc('id');
        $this->authorize('viewAny', CashMove::class);
        return response()->json($q->paginate((int)$r->input('per_page', 15)));
    }

    // POST /api/v1/cash/moves (submit)
    public function store(CashMoveStoreRequest $req): JsonResponse
    {
        $this->authorize('create', CashMove::class);
        $move = $this->svc->submitMove($req->validated(), $req->user()->id);
        return response()->json($move, 201);
    }

    // POST /api/v1/cash/moves/{move}/approve
    public function approve(CashMoveApproveRequest $req, CashMove $move): JsonResponse
    {
        $this->authorize('approve', $move);
        $approved = $this->svc->approveMove($move, $req->input('approved_at'), $req->user()->id);
        return response()->json($approved);
    }

    // POST /api/v1/cash/moves/{move}/reject
    public function reject(CashMoveRejectRequest $req, CashMove $move): JsonResponse
    {
        $this->authorize('reject', $move);
        $rejected = $this->svc->rejectMove($move, $req->string('reason')->toString(), $req->user()->id);
        return response()->json($rejected);
    }

    // DELETE /api/v1/cash/moves/{move}
    public function destroy(Request $req, CashMove $move): JsonResponse
    {
        $this->authorize('delete', $move);
        $move->delete();
        return response()->json(['message' => 'Deleted']);
    }
}

```
</details>

### app/Http/Controllers/Api/CategoryController.php

- SHA: `a7e5d581affa`  
- Ukuran: 3 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `CategoryController` extends `Controller`**

Metode Publik:
- **__construct**(private CategoryService $service)
- **index**(IndexCategoryRequest $request) : *JsonResponse*
- **store**(StoreCategoryRequest $request) : *JsonResponse*
- **show**(Request $request, Category $category) : *JsonResponse*
- **update**(UpdateCategoryRequest $request, Category $category) : *JsonResponse*
- **destroy**(Request $request, Category $category) : *JsonResponse*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Category\IndexCategoryRequest;
use App\Http\Requests\Category\StoreCategoryRequest;
use App\Http\Requests\Category\UpdateCategoryRequest;
use App\Models\Category;
use App\Services\CategoryService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    public function __construct(private CategoryService $service) {}

    public function index(IndexCategoryRequest $request): JsonResponse
    {
        $this->authorize('viewAny', Category::class);

        [$col, $dir] = $request->sort();
        $paginator = $this->service->paginate([
            'q'        => $request->input('q'),
            'is_active'=> $request->input('is_active'),
            'per_page' => $request->perPage(),
            'sort'     => [$col, $dir],
        ]);

        return response()->json([
            'success' => true,
            'data'    => $paginator->items(),
            'meta'    => [
                'current_page' => $paginator->currentPage(),
                'per_page'     => $paginator->perPage(),
                'total'        => $paginator->total(),
                'last_page'    => $paginator->lastPage(),
            ],
        ]);
    }

    public function store(StoreCategoryRequest $request): JsonResponse
    {
        $this->authorize('create', Category::class);

        $category = $this->service->create($request->payload());

        return response()->json([
            'success' => true,
            'data'    => $category,
            'message' => 'Kategori berhasil dibuat',
        ], 201);
    }

    public function show(Request $request, Category $category): JsonResponse
    {
        $this->authorize('view', $category);

        return response()->json([
            'success' => true,
            'data'    => $category, // bisa ->loadCount('products') nanti
        ]);
    }

    public function update(UpdateCategoryRequest $request, Category $category): JsonResponse
    {
        $this->authorize('update', $category);

        $category = $this->service->update($category, $request->payload());

        return response()->json([
            'success' => true,
            'data'    => $category,
            'message' => 'Kategori berhasil diupdate',
        ]);
    }

    public function destroy(Request $request, Category $category): JsonResponse
    {
        $this->authorize('delete', $category);

        // Catatan: ketika relasi produk sudah aktif, service akan cegah hapus jika masih dipakai (sesuai UI-UX “Kategori yang sudah memiliki produk tidak bisa dihapus”).
        $this->service->delete($category); // hard delete sesuai SOP

        return response()->json([
            'success' => true,
            'message' => 'Kategori berhasil dihapus',
        ]);
    }
}

```
</details>

### app/Http/Controllers/Api/CustomersController.php

- SHA: `0e39efca2ef3`  
- Ukuran: 3 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `CustomersController` extends `Controller`**

Metode Publik:
- **__construct**(private readonly CustomerService $svc)
- **index**(Request $req)
- **show**(Request $req, Customer $customer)
- **store**(CustomerStoreRequest $req)
- **update**(CustomerUpdateRequest $req, Customer $customer)
- **destroy**(Request $req, Customer $customer)
- **history**(Request $req, Customer $customer)
- **setStage**(Request $req, Customer $customer)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Customer\CustomerStoreRequest;
use App\Http\Requests\Customer\CustomerUpdateRequest;
use App\Models\Customer;
use App\Services\CustomerService;
use Illuminate\Http\Request;

class CustomersController extends Controller
{
    public function __construct(private readonly CustomerService $svc) {}

    public function index(Request $req)
    {
        $this->authorize('viewAny', Customer::class);
        $cabangId = $this->resolveCabangId($req);

        $data = $this->svc->list($cabangId, [
            'q'        => $req->query('q'),
            'stage'    => $req->query('stage'),
            'from'     => $req->query('from'),
            'to'       => $req->query('to'),
            'per_page' => $req->integer('per_page', 15),
        ]);

        return response()->json($data);
        // Note: if you use a Resource, adapt accordingly.
    }

    public function show(Request $req, Customer $customer)
    {
        $this->authorize('view', $customer);
        return response()->json($this->svc->detail($customer));
    }

    public function store(CustomerStoreRequest $req)
    {
        $cabangId = $this->resolveCabangId($req);
        $this->authorize('create', Customer::class);

        $customer = $this->svc->upsertByPhone($cabangId, $req->validated());
        return response()->json($customer, 201);
    }

    public function update(CustomerUpdateRequest $req, Customer $customer)
    {
        $this->authorize('update', $customer);

        $customer->fill($req->validated())->save();
        return response()->json($customer->refresh());
    }

    public function destroy(Request $req, Customer $customer)
    {
        $this->authorize('delete', $customer);
        $customer->delete(); // SOP says hard-delete OK unless you prefer soft delete
        return response()->json(['ok' => true]);
    }

    public function history(Request $req, Customer $customer)
    {
        $this->authorize('view', $customer);
        $limit = $req->integer('limit', 20);
        $detail = $this->svc->detail($customer, $limit);
        $detail['timelines'] = $customer->timelines()->orderByDesc('happened_at')->limit($limit)->get();
        return response()->json($detail);
    }

    public function setStage(Request $req, Customer $customer)
    {
        $this->authorize('update', $customer);
        $req->validate(['stage' => 'required|in:LEAD,ACTIVE,CHURN']);
        $updated = $this->svc->setStage($customer, $req->string('stage'));
        return response()->json($updated);
    }

    private function resolveCabangId(Request $req): int
    {
        $user = $req->user();
        // Kasir & Sales: wajib cabang user (branch-scoped)
        if ($user->hasRole(['kasir', 'sales'])) {
            if (!$user->cabang_id) {
                abort(422, 'User tidak memiliki cabang_id; hubungi admin.');
            }
            return (int) $user->cabang_id;
        }
        // Superadmin/Admin Cabang: boleh pilih via input, fallback ke cabang user bila ada
        $fromInput = $req->integer('cabang_id');
        if ($fromInput) {
            return $fromInput;
        }
        if ($user->cabang_id) {
            return (int) $user->cabang_id;
        }
        // Jika superadmin tanpa cabang & tanpa input: ini keputusan bisnis → izinkan 0/semua atau hard fail.
        abort(422, 'Mohon tentukan cabang_id.');
    }
}

```
</details>

### app/Http/Controllers/Api/DashboardController.php

- SHA: `2fe82c52809d`  
- Ukuran: 3 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `DashboardController` extends `Controller`**

Metode Publik:
- **__construct**(private DashboardService $svc)
- **kpis**(CommonQuery $rq)
- **chart7d**(Request $rq)
- **topProducts**(CommonQuery $rq)
- **lowStock**(CommonQuery $rq)
- **quickActions**(Request $rq)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Dashboard\CommonQuery;
use App\Services\DashboardService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class DashboardController extends Controller
{
    public function __construct(private DashboardService $svc) {}

    private function ok($data, $meta = [], $message = 'OK')
    {
        return response()->json([
            'data' => $data,
            'meta' => $meta,
            'message' => $message,
            'errors' => (object) [],
        ]);
    }

    public function kpis(CommonQuery $rq)
    {
        Gate::authorize('view', 'dashboard');
        [$from, $to] = $rq->dateRange();
        $cabangId = $rq->branchIdOrUser(); // still reading "branch_id" from query param
        $out = $this->svc->kpis($cabangId, $from, $to);

        $this->auditView('dashboard.kpis', ['cabang_id' => $cabangId, 'from' => $from, 'to' => $to]);
        return $this->ok($out, ['from' => $from->toDateTimeString(), 'to' => $to->toDateTimeString()]);
    }

    public function chart7d(Request $rq)
    {
        Gate::authorize('view', 'dashboard');
        $cabangId = $rq->integer('cabang_id')
            ?: $rq->integer('branch_id')
            ?: ($rq->user()->cabang_id ?? null);
        $out = $this->svc->chart7d($cabangId);

        $this->auditView('dashboard.chart7d', ['cabang_id' => $cabangId]);
        return $this->ok($out);
    }

    public function topProducts(CommonQuery $rq)
    {
        Gate::authorize('view', 'dashboard');
        $cabangId = $rq->branchIdOrUser();
        $limit = (int) ($rq->integer('limit') ?? 5);
        $out = $this->svc->topProducts($cabangId, $limit);

        $this->auditView('dashboard.topProducts', ['cabang_id' => $cabangId, 'limit' => $limit]);
        return $this->ok($out, ['limit' => $limit]);
    }

    public function lowStock(CommonQuery $rq)
    {
        Gate::authorize('view', 'dashboard');
        $cabangId = $rq->branchIdOrUser();
        $threshold = $rq->input('threshold') !== null ? (float) $rq->input('threshold') : null;
        $out = $this->svc->lowStock($cabangId, $threshold);

        $this->auditView('dashboard.lowStock', ['cabang_id' => $cabangId, 'threshold' => $threshold]);
        return $this->ok($out, ['threshold' => $threshold]);
    }

    public function quickActions(Request $rq)
    {
        Gate::authorize('view', 'dashboard');
        $cabangId = $rq->integer('branch_id') ?: ($rq->user()->cabang_id ?? null);
        $out = $this->svc->quickActions($cabangId);

        $this->auditView('dashboard.quickActions', ['cabang_id' => $cabangId]);
        return $this->ok($out);
    }

    private function auditView(string $action, array $meta = []): void
    {
        try {
            DB::table('audit_logs')->insert([
                'actor_type' => 'USER',
                'actor_id'   => Auth::id(),
                'action'     => strtoupper($action),
                'model'      => 'dashboard',
                'model_id'   => 0,
                'diff_json'  => json_encode($meta),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        } catch (\Throwable $e) {
            // ignore audit failures for reads
        }
    }
}

```
</details>

### app/Http/Controllers/Api/DeliveriesController.php

- SHA: `b804f1a9c1cb`  
- Ukuran: 7 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `DeliveriesController` extends `Controller`**

Metode Publik:
- **__construct**(private DeliveryService $svc)
- **index**(Request $req)
- **show**(Request $req, int $id)
- **store**(DeliveryStoreRequest $request)
- **assign**(DeliveryAssignRequest $request, int $id)
- **updateStatus**(DeliveryStatusRequest $request, int $id)
- **addEvent**(DeliveryEventStoreRequest $request, int $id)
- **note**(int $id)
- **sendWa**(SendDeliveryNoteRequest $request, int $id)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\{DeliveryAssignRequest, DeliveryEventStoreRequest, DeliveryStatusRequest, DeliveryStoreRequest};
use App\Http\Requests\Deliveries\SendDeliveryNoteRequest;
use App\Models\{Delivery, Order};
use App\Services\DeliveryService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DeliveriesController extends Controller
{
    public function __construct(private DeliveryService $svc)
    {
        $this->middleware('auth:sanctum');
    }

    public function index(Request $req)
    {
        $this->authorize('viewAny', Delivery::class);

        $q = Delivery::query()
            ->with([
                'order' => fn($qo) => $qo->select('id', DB::raw('kode as code'), 'cabang_id'),
                'courier:id,name',
                'events'
            ])
            ->when($req->filled('status'), fn($x) => $x->where('status', $req->string('status')))
            ->when($req->filled('assigned_to'), fn($x) => $x->where('assigned_to', $req->integer('assigned_to')))
            ->when($req->filled('order_id'), fn($x) => $x->where('order_id', $req->integer('order_id')))
            ->when($req->filled('date'), fn($x) => $x->whereDate('requested_at', $req->date('date')))
            ->orderByDesc('id');

        // batasi scope by cabang untuk admin cabang/kasir
        $user = $req->user();
        if ($user->hasAnyRole(['admin cabang', 'kasir'])) {
            $q->whereHas('order', fn($o) => $o->where('cabang_id', $user->cabang_id));
        }
        if ($user->hasRole('kurir')) {
            $q->where('assigned_to', $user->id);
        }

        return response()->json($q->paginate(10));
    }

    public function show(Request $req, int $id)
    {
        $delivery = Delivery::with([
            'order'   => fn($qo) => $qo->select('id', DB::raw('kode as code'), 'cabang_id'),
            'courier:id,name',
            'events'
        ])->findOrFail($id);
        $this->authorize('view', $delivery);
        return response()->json($delivery);
    }

    public function store(DeliveryStoreRequest $request)
    {
        $order = Order::with('cabang')->findOrFail($request->integer('order_id'));
        $this->authorize('create', [Delivery::class, $order]);

        $delivery = $this->svc->createForOrder(
            $order->id,
            $request->string('type'),
            $request->validated()
        );

        // Auto-assign opsional (?auto_assign=1)
        if ($request->boolean('auto_assign')) {
            $delivery->load([
                'order' => fn($qo) => $qo->select('id', DB::raw('kode as code'), 'cabang_id'),
                'courier:id,name',
                'events'
            ]);
            $delivery = $this->svc->autoAssign($delivery);
        }

        return response()->json($delivery->fresh(['order', 'courier', 'events']), 201);
    }

    public function assign(DeliveryAssignRequest $request, int $id)
    {
        $delivery = Delivery::with('order')->findOrFail($id);
        $this->authorize('assign', $delivery);

        if ($request->boolean('auto')) {
            // pilih kurir otomatis
            $delivery = $this->svc->autoAssign($delivery);
        } else {
            $delivery = $this->svc->assign($delivery, $request->integer('assigned_to'));
        }

        // balikan lengkap (biar FE bisa refresh tanpa call lain)
        $delivery->load([
            'order'   => fn($qo) => $qo->select('id', DB::raw('kode as code'), 'cabang_id'),
            'courier:id,name',
            'events',
        ]);

        return response()->json($delivery);
    }

    public function updateStatus(DeliveryStatusRequest $request, int $id)
    {
        $delivery = Delivery::with('order')->findOrFail($id);
        $this->authorize('updateStatus', $delivery);

        $delivery = $this->svc->updateStatus(
            $delivery,
            $request->string('status'),
            $request->input('note'),
            $request->file('photo')
        );

        return response()->json($delivery);
    }

    public function addEvent(DeliveryEventStoreRequest $request, int $id)
    {
        $delivery = Delivery::with('order')->findOrFail($id);
        $this->authorize('addEvent', $delivery);

        $event = $this->svc->addEvent(
            $delivery,
            $request->string('status'),
            $request->input('note'),
            $request->file('photo')
        );

        return response()->json($event, 201);
    }

    public function note(int $id)
    {
        $delivery = Delivery::with([
            'order' => fn($qo) => $qo->select('id', DB::raw('kode as code'), 'cabang_id', 'subtotal', 'discount', 'grand_total', 'paid_total', 'status', 'created_at')
                ->with([
                    // ⬇⬇ perbaiki di sini
                    'items' => fn($qi) => $qi->select(
                        'id',
                        'order_id',
                        DB::raw('name_snapshot AS name'),
                        'qty',
                        'price',
                        DB::raw('NULL::text AS note')
                    ),
                    'customer:id,name,phone,address',
                    'cabang:id,code,name,address,phone'
                ]),
            'courier:id,name,phone',
        ])->findOrFail($id);

        $this->authorize('view', $delivery);

        if (is_null($delivery->assigned_to)) {
            return response()->json([
                'message' => 'Surat Jalan tersedia setelah kurir di-assign.'
            ], 422);
        }

        $html = $this->svc->buildSuratJalanHtml($delivery);
        return response($html, 200)->header('Content-Type', 'text/html; charset=UTF-8');
    }

    public function sendWa(SendDeliveryNoteRequest $request, int $id)
    {
        $delivery = Delivery::with([
            'order' => fn($qo) => $qo->select('id', DB::raw('kode as code'), 'cabang_id', 'subtotal', 'discount', 'grand_total', 'paid_total', 'status', 'created_at')
                ->with([
                    // ⬇⬇ perbaiki di sini
                    'items' => fn($qi) => $qi->select(
                        'id',
                        'order_id',
                        DB::raw('name_snapshot AS name'),
                        'qty',
                        'price',
                        DB::raw('NULL::text AS note')
                    ),
                    'customer:id,name,phone,address',
                    'cabang:id,code,name,address,phone'
                ]),
            'courier:id,name,phone',
        ])->findOrFail($id);

        $this->authorize('sendSuratJalan', $delivery);

        $message = $request->validated()['message'] ?? null;
        $res = $this->svc->resendWASuratJalan($delivery, $message);

        if (empty($res['wa_url'])) {
            return response()->json($res, 422);
        }
        return response()->json($res);
    }
}

```
</details>

### app/Http/Controllers/Api/FeeController.php

- SHA: `84b0167f7e57`  
- Ukuran: 2 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `FeeController` extends `Controller`**

Metode Publik:
- **__construct**(FeeService $service) — @var FeeService
- **index**(Request $request) — @var FeeService
- **show**(Fee $fee) — @var FeeService
- **store**(FeeStoreRequest $request) — @var FeeService
- **update**(FeeUpdateRequest $request, Fee $fee) — @var FeeService
- **destroy**(Fee $fee) — @var FeeService
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\FeeStoreRequest;
use App\Http\Requests\FeeUpdateRequest;
use App\Http\Resources\FeeResource;
use App\Models\Fee;
use App\Services\FeeService;
use Illuminate\Http\Request;

class FeeController extends Controller
{
    /** @var FeeService */
    protected FeeService $service;

    public function __construct(FeeService $service)
    {
        $this->service = $service;
    }

    public function index(Request $request)
    {
        $this->authorize('viewAny', Fee::class);

        $filters = [
            'cabang_id' => $request->integer('cabang_id'),
            'kind'      => $request->string('kind')->toString() ?: null,
            'base'      => $request->string('base')->toString() ?: null,
            'is_active' => $request->has('is_active') ? $request->boolean('is_active') : null,
            'q'         => $request->string('q')->toString() ?: null,
            'sort'      => $request->string('sort')->toString() ?: null,
        ];

        $perPage   = min(max($request->integer('per_page', 15), 5), 100);
        $paginator = $this->service->paginate($filters, $perPage);

        return FeeResource::collection($paginator)->additional([
            'meta' => [
                'current_page' => $paginator->currentPage(),
                'per_page'     => $paginator->perPage(),
                'total'        => $paginator->total(),
                'last_page'    => $paginator->lastPage(),
            ],
        ]);
    }

    public function show(Fee $fee)
    {
        $this->authorize('view', $fee);
        return new FeeResource($fee);
    }

    public function store(FeeStoreRequest $request)
    {
        $this->authorize('create', Fee::class);
        $fee = $this->service->create($request->validated());
        return (new FeeResource($fee))
            ->additional(['message' => 'Fee created'])
            ->response()
            ->setStatusCode(201);
    }

    public function update(FeeUpdateRequest $request, Fee $fee)
    {
        $this->authorize('update', $fee);
        $fee = $this->service->update($fee, $request->validated());
        return (new FeeResource($fee))
            ->additional(['message' => 'Fee updated']);
    }

    public function destroy(Fee $fee)
    {
        $this->authorize('delete', $fee);
        $this->service->delete($fee);
        return response()->json(['message' => 'Fee deleted']);
    }
}

```
</details>

### app/Http/Controllers/Api/FeeEntryController.php

- SHA: `66aebd9be197`  
- Ukuran: 1 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `FeeEntryController` extends `Controller`**

Metode Publik:
- **__construct**(private FeeService $fees)
- **index**(FeeEntryIndexRequest $req)
- **export**(FeeEntryIndexRequest $req)
- **pay**(FeeEntryPayRequest $req)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\FeeEntryIndexRequest;
use App\Http\Requests\FeeEntryPayRequest;
use App\Models\FeeEntry;
use App\Services\FeeService;
use Illuminate\Http\Request;

class FeeEntryController extends Controller
{
    public function __construct(private FeeService $fees) {}

    public function index(FeeEntryIndexRequest $req)
    {
        $this->authorize('viewAny', FeeEntry::class);
        $data = $this->fees->listEntries($req->user(), $req->validated());
        return response()->json($data);
    }

    public function export(FeeEntryIndexRequest $req)
    {
        $this->authorize('export', FeeEntry::class);
        return $this->fees->exportCsv($req->user(), $req->validated());
    }

    public function pay(FeeEntryPayRequest $req)
    {
        $entryIds = $req->validated('entry_ids');
        $status   = $req->validated('status');
        $paidAmt  = (string) ($req->validated()['paid_amount'] ?? '0');
        $paidAt   = $req->validated()['paid_at'] ?? null;

        // policy per-entry (simple check using first entry)
        $first = FeeEntry::findOrFail($entryIds[0]);
        $this->authorize('updateStatus', $first);

        $count = $this->fees->markPaid($entryIds, $status, $paidAmt, $paidAt);
        return response()->json(['updated' => $count]);
    }
}

```
</details>

### app/Http/Controllers/Api/FiscalPeriodController.php

- SHA: `75662420d7b9`  
- Ukuran: 1 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `FiscalPeriodController` extends `Controller`**

Metode Publik:
- **__construct**(private readonly AccountingService $svc)
- **index**(Request $r)
- **open**(PeriodCloseRequest $req)
- **close**(PeriodCloseRequest $req)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\PeriodCloseRequest;
use App\Models\FiscalPeriod;
use App\Policies\FiscalPeriodPolicy;
use App\Services\AccountingService;
use Illuminate\Http\Request;

class FiscalPeriodController extends Controller
{
    public function __construct(private readonly AccountingService $svc) {}

    public function index(Request $r)
    {
        $this->authorize('viewAny', FiscalPeriod::class);
        $q = FiscalPeriod::query()
            ->when($r->filled('cabang_id'), fn($x) => $x->where('cabang_id', $r->integer('cabang_id')))
            ->orderByDesc('year')->orderByDesc('month');
        return response()->json(['data' => $q->get(), 'meta' => [], 'message' => 'OK', 'errors' => []]);
    }

    public function open(PeriodCloseRequest $req)
    {
        $this->authorize('open', FiscalPeriod::class);
        $fp = $this->svc->openPeriod($req->integer('cabang_id'), $req->integer('year'), $req->integer('month'));
        return response()->json(['data' => $fp, 'meta' => [], 'message' => 'OPEN', 'errors' => []]);
    }

    public function close(PeriodCloseRequest $req)
    {
        // authorize on class; additional guard happens in service
        $this->authorize('open', FiscalPeriod::class);
        $fp = $this->svc->closePeriod($req->integer('cabang_id'), $req->integer('year'), $req->integer('month'));
        return response()->json(['data' => $fp, 'meta' => [], 'message' => 'CLOSED', 'errors' => []]);
    }
}

```
</details>

### app/Http/Controllers/Api/GudangController.php

- SHA: `5193b9e1ff5f`  
- Ukuran: 3 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `GudangController` extends `Controller`**

Metode Publik:
- **__construct**(private GudangService $service)
- **index**(Request $request) : *JsonResponse*
- **store**(GudangStoreRequest $request) : *JsonResponse*
- **show**(Request $request, Gudang $gudang) : *JsonResponse*
- **update**(GudangUpdateRequest $request, Gudang $gudang) : *JsonResponse*
- **destroy**(Request $request, Gudang $gudang) : *JsonResponse*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\GudangStoreRequest;
use App\Http\Requests\GudangUpdateRequest;
use App\Models\Gudang;
use App\Services\GudangService;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class GudangController extends Controller
{
    public function __construct(private GudangService $service) {}

    public function index(Request $request): JsonResponse
    {
        $this->authorize('viewAny', Gudang::class);

        $q        = $request->string('q')->toString();
        $cabangId = $request->input('cabang_id');
        $isActive = $request->has('is_active') ? filter_var($request->input('is_active'), FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE) : null;
        $perPage  = (int)($request->input('per_page', 10));
        $sort     = $request->input('sort', '-id');

        $query = $this->service->queryIndexForUser($request->user())
            ->when($q !== '', fn($qr) => $qr->where('nama', 'like', "%{$q}%"))
            ->when($cabangId, fn($qr) => $qr->where('cabang_id', $cabangId))
            ->when(!is_null($isActive), fn($qr) => $qr->where('is_active', $isActive));

        if (is_string($sort) && $sort !== '') {
            $direction = str_starts_with($sort, '-') ? 'desc' : 'asc';
            $field = ltrim($sort, '-');
            in_array($field, ['id','cabang_id','nama','is_default','is_active','created_at']) || $field = 'id';
            $query->orderBy($field, $direction);
        }

        $paginator = $query->paginate($perPage);
        return response()->json([
            'success' => true,
            'data' => $paginator->items(),
            'meta' => [
                'current_page' => $paginator->currentPage(),
                'per_page'     => $paginator->perPage(),
                'total'        => $paginator->total(),
                'last_page'    => $paginator->lastPage(),
            ],
        ]);
    }

    public function store(GudangStoreRequest $request): JsonResponse
    {
        $this->authorize('create', Gudang::class);
        $gudang = $this->service->create($request->validated(), $request->user());
        return response()->json([
            'success' => true,
            'data' => $gudang,
        ], 201);
    }

    public function show(Request $request, Gudang $gudang): JsonResponse
    {
        $this->authorize('view', $gudang);
        return response()->json([
            'success' => true,
            'data' => $gudang->load('cabang'),
        ]);
    }

    public function update(GudangUpdateRequest $request, Gudang $gudang): JsonResponse
    {
        $this->authorize('update', $gudang);
        $gudang = $this->service->update($gudang, $request->validated(), $request->user());
        return response()->json([
            'success' => true,
            'data' => $gudang,
        ]);
    }

    public function destroy(Request $request, Gudang $gudang): JsonResponse
    {
        $this->authorize('delete', $gudang);
        $this->service->delete($gudang, $request->user());
        return response()->json([
            'success' => true,
        ], 204);
    }
}

```
</details>

### app/Http/Controllers/Api/JournalController.php

- SHA: `02b81b58aedf`  
- Ukuran: 3 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `JournalController` extends `Controller`**

Metode Publik:
- **__construct**(private readonly AccountingService $svc)
- **index**(Request $r)
- **store**(JournalStoreRequest $req)
- **update**(JournalUpdateRequest $req, JournalEntry $journal)
- **post**(JournalPostRequest $req, JournalEntry $journal)
- **destroy**(JournalEntry $journal)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\{JournalStoreRequest, JournalUpdateRequest, JournalPostRequest};
use App\Models\JournalEntry;
use App\Services\AccountingService;
use Illuminate\Http\Request;

class JournalController extends Controller
{
    public function __construct(private readonly AccountingService $svc) {}

    public function index(Request $r)
    {
        $this->authorize('viewAny', JournalEntry::class);
        $q = JournalEntry::query()
            ->when($r->filled('cabang_id'), fn($x) => $x->where('cabang_id', $r->integer('cabang_id')))
            ->when($r->filled('status'), fn($x) => $x->where('status', $r->string('status')))
            ->when($r->filled('from'), fn($x) => $x->whereDate('journal_date', '>=', $r->date('from')))
            ->when($r->filled('to'), fn($x) => $x->whereDate('journal_date', '<=', $r->date('to')))
            ->orderByDesc('journal_date')->orderBy('number');

        return response()->json(['data' => $q->paginate(20), 'meta' => [], 'message' => 'OK', 'errors' => []]);
        // catatan: bisa ditambah filter by account_id via join journal_lines bila diperlukan
    }

    public function store(JournalStoreRequest $req)
    {
        $this->authorize('create', JournalEntry::class);
        $entry = $this->svc->upsertDraft($req->validated());
        return response()->json(['data' => $entry->load('lines'), 'meta' => [], 'message' => 'Saved DRAFT', 'errors' => []], 201);
    }

    public function update(JournalUpdateRequest $req, JournalEntry $journal)
    {
        $this->authorize('update', $journal);
        $payload = array_merge(['cabang_id' => $journal->cabang_id, 'number' => $journal->number], $req->validated());
        $payload['journal_date'] = $req->validated()['journal_date'] ?? $journal->journal_date;
        $entry = $this->svc->upsertDraft($payload);
        return response()->json(['data' => $entry->load('lines'), 'meta' => [], 'message' => 'Updated DRAFT', 'errors' => []]);
    }

    public function post(JournalPostRequest $req, JournalEntry $journal)
    {
        $this->authorize('post', $journal);
        $entry = $this->svc->post($journal, $req->string('idempotency_key')->toString());
        return response()->json(['data' => $entry->load('lines'), 'meta' => [], 'message' => 'POSTED', 'errors' => []]);
    }

    public function destroy(JournalEntry $journal)
    {
        $this->authorize('delete', $journal);
        $journal->delete();
        return response()->json(['data' => null, 'meta' => [], 'message' => 'Deleted', 'errors' => []]);
    }
}

```
</details>

### app/Http/Controllers/Api/OrderController.php

- SHA: `740cc38d3f97`  
- Ukuran: 15 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `OrderController` extends `Controller`**

Metode Publik:
- **__construct**(private QuoteService $quote, private CheckoutService $checkout)
- **index**(IndexOrdersRequest $req)
- **show**(Order $order)
- **quote**(Request $req)
- **checkout**(OrderStoreRequest $req)
- **update**(OrderUpdateRequest $req, Order $order)
- **addPayment**(PaymentStoreRequest $req, Order $order)
- **cancel**(OrderCancelRequest $req, Order $order)
- **setCashPosition**(OrderSetCashPositionRequest $req, Order $order)
- **print**(Order $order)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\OrderSetCashPositionRequest;
use App\Http\Requests\Orders\IndexOrdersRequest;
use App\Http\Requests\OrderStoreRequest;
use App\Http\Requests\OrderUpdateRequest;
use App\Http\Requests\PaymentStoreRequest;
use App\Http\Requests\OrderCancelRequest;
use App\Models\Order;
use App\Services\CheckoutService;
use App\Services\QuoteService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class OrderController extends Controller
{
    public function __construct(
        private QuoteService $quote,
        private CheckoutService $checkout
    ) {}

    // GET /api/v1/orders  (list by cabang user; gunakan Policy via scope/Resource Policy)
    public function index(IndexOrdersRequest $req)
    {
        Gate::authorize('viewAny', Order::class);

        $actor = $req->user();
        $v = $req->validated();

        $sort = $v['sort'] ?? 'ordered_at';
        $dir  = $v['dir']  ?? 'desc';
        if (is_string($sort)) {
            if (str_starts_with($sort, '-')) {
                $sort = ltrim($sort, '-');
                $dir = 'desc';
            } elseif (str_starts_with($sort, '+')) {
                $sort = ltrim($sort, '+');
                $dir = 'asc';
            }
        }
        // Kolom yang boleh di-sort (sesuaikan bila perlu)
        $allowedSorts = ['ordered_at', 'kode', 'grand_total', 'status', 'created_at', 'cash_position'];
        if (!in_array($sort, $allowedSorts, true)) {
            $sort = 'ordered_at';
        }
        $dir = strtolower($dir) === 'asc' ? 'asc' : 'desc';

        $q = Order::query()
            ->with(['items', 'payments'])
            // auto-branch scoping for non-central users
            ->when(method_exists($actor, 'isCentral') && !$actor->isCentral(), fn($qq) => $qq->where('cabang_id', $actor->cabang_id))
            // manual filters (still allowed)
            ->when(!empty($v['cabang_id']), fn($qq, $cid) => $qq->where('cabang_id', $cid))
            ->when(!empty($v['status']), fn($qq, $st) => $qq->where('status', (string)$st))
            ->when(!empty($v['cash_position']), fn($qq, $cp) => $qq->where('cash_position', (string)$cp))
            ->when(!empty($v['q']), fn($qq, $kw) => $qq->where(function ($w) use ($kw) {
                $w->where('kode', 'like', "%{$kw}%")->orWhere('note', 'like', "%{$kw}%");
            }))
            ->when(!empty($v['start_date']), fn($qq, $d) => $qq->whereDate('ordered_at', '>=', $d))
            ->when(!empty($v['end_date']), fn($qq, $d) => $qq->whereDate('ordered_at', '<=', $d))
            ->orderBy($sort, $dir);

        return response()->json($q->paginate($v['per_page'] ?? 10));
    }
    // GET /api/v1/orders/{order}
    public function show(Order $order)
    {
        Gate::authorize('view', $order);
        return response()->json($order->load(['items', 'payments']));
    }

    // POST /api/v1/cart/quote  (hitung total dari items saja - tanpa simpan)
    public function quote(Request $req)
    {
        Gate::authorize('create', Order::class);

        Log::debug('AUTH DEBUG', [
            'user' => $req->user()?->only(['id', 'name', 'email', 'cabang_id']),
            'roles' => method_exists($req->user(), 'getRoleNames') ? $req->user()->getRoleNames() : [],
            'can_create_order' => $req->user()?->can('create', Order::class),
        ]);

        $data = $req->validate([
            'items' => ['required', 'array', 'min:1'],
            'items.*.variant_id' => ['required', 'integer', 'min:1'],
            'items.*.qty' => ['required', 'numeric', 'gt:0'],
            'items.*.discount' => ['nullable', 'numeric', 'min:0'],
            'items.*.price_hint' => ['nullable', 'numeric', 'min:0'],
        ]);

        $result = $this->quote->quoteItems($data['items']);
        return response()->json($result);
    }

    // POST /api/v1/checkout  (buat order + optional immediate payment)
    public function checkout(OrderStoreRequest $req)
    {
        Gate::authorize('create', Order::class);

        $payload = $req->validated();
        $cashierId = (int) $req->user()->id;

        $order = $this->checkout->checkout($payload, $cashierId);
        return response()->json($order->load(['items', 'payments']), Response::HTTP_CREATED);
    }

    // PUT /api/v1/orders/{order}  (edit item pada DRAFT/UNPAID)
    public function update(OrderUpdateRequest $req, Order $order)
    {
        Gate::authorize('update', $order);

        if (!$order->isEditable()) {
            return response()->json(['message' => 'Order tidak dapat diedit.'], 422);
        }

        $payload = $req->validated();

        return DB::transaction(function () use ($order, $payload) {
            $before = [
                'items'  => $order->items()->get(['variant_id', 'name_snapshot as name', 'price', 'discount', 'qty', 'line_total'])->toArray(),
                'totals' => $order->only(['subtotal', 'discount', 'tax', 'service_fee', 'grand_total', 'paid_total']),
                'status' => $order->status,
            ];

            $q = $this->quote->quoteItems($payload['items']);

            // simplest safe path: replace all items
            $order->items()->delete();
            foreach ($q['items'] as $line) {
                $order->items()->create($line + ['order_id' => $order->id]);
            }

            // recalc totals
            $order->fill($q['totals'])->save();

            $after = [
                'items'  => $order->items()->get(['variant_id', 'name_snapshot as name', 'price', 'discount', 'qty', 'line_total'])->toArray(),
                'totals' => $order->only(['subtotal', 'discount', 'tax', 'service_fee', 'grand_total', 'paid_total']),
                'status' => $order->status,
            ];

            $settlement = null;
            if ($order->status === 'PAID' && (float)$order->grand_total !== (float)$order->paid_total) {
                $settlement = [
                    'needed'  => $order->grand_total - $order->paid_total,
                    'message' => 'Total changed after payment; settlement required.',
                ];
            }

            \App\Models\OrderChangeLog::create([
                'order_id'   => $order->id,
                'actor_id'   => Auth::id(),
                'action'     => 'ITEM_EDIT',
                'diff_json'  => ['before' => $before, 'after' => $after, 'settlement' => $settlement],
                'note'       => $payload['note'] ?? null,
                'occurred_at' => now(),
            ]);

            return response()->json($order->fresh(['items', 'payments']));
        });
    }

    // POST /api/v1/orders/{order}/payments  (tambah pembayaran/split tender)
    public function addPayment(PaymentStoreRequest $req, Order $order)
    {
        Gate::authorize('addPayment', $order);

        $data = $req->validated();
        $order = $this->checkout->addPayment($order, $data);
        return response()->json($order->load(['items', 'payments']));
    }

    // POST /api/v1/orders/{order}/cancel
    public function cancel(OrderCancelRequest $req, Order $order)
    {
        Gate::authorize('cancel', $order);

        if ($order->isPaid()) {
            // kebijakan: hanya AdminCabang/Superadmin di policy yg lolos; di sini force VOID
            $order->status = 'VOID';
            $order->note = trim(($order->note ? $order->note . "\n" : '') . 'CANCEL: ' . $req->string('reason'));
            $order->save();
        } else {
            $order->status = 'VOID';
            $order->note = trim(($order->note ? $order->note . "\n" : '') . 'CANCEL: ' . $req->string('reason'));
            $order->save();
            // (opsional) hapus payments pending
        }

        return response()->json($order->fresh(['items', 'payments']));
    }

    public function setCashPosition(OrderSetCashPositionRequest $req, Order $order)
    {
        Gate::authorize('setCashPosition', $order);

        $v = $req->validated();

        return DB::transaction(function () use ($order, $v) {
            $before = $order->cash_position;

            $order->cash_position = $v['cash_position']; // CUSTOMER | CASHIER | SALES | ADMIN
            $order->save();

            // Audit ringkas (opsional, gunakan tabel log yang sudah ada)
            if (class_exists(\App\Models\OrderChangeLog::class)) {
                \App\Models\OrderChangeLog::create([
                    'order_id'    => $order->id,
                    'actor_id'    => Auth::id(),
                    'action'      => 'SET_CASH_POSITION',
                    'diff_json'   => ['before' => $before, 'after' => $order->cash_position],
                    'occurred_at' => now(),
                ]);
            }

            return response()->json($order->fresh(['items', 'payments']));
        });
    }

    // GET /api/v1/orders/{order}/print  -> HTML struk (58/80mm), tanpa file blade
    public function print(Order $order)
    {
        Gate::authorize('print', $order);

        $order->load(['items', 'payments', 'cabang', 'gudang', 'cashier']);
        $html = $this->renderReceiptHtml($order);

        try {
            \App\Models\OrderChangeLog::create([
                'order_id'    => $order->id,
                'actor_id'    => Auth::id(),
                'action'      => 'REPRINT',
                'diff_json'   => ['format' => 58], // bisa integer
                'occurred_at' => now(),
            ]);
        } catch (\Throwable $e) {
            Log::warning('Order reprint log failed', [
                'order_id' => $order->id,
                'error'    => $e->getMessage(),
            ]);
        }

        if (class_exists(\App\Models\Receipt::class)) {
            \App\Models\Receipt::create([
                'order_id'      => $order->id,
                'print_format'  => 58,            // <— integer
                'html_snapshot' => $html,
                'printed_at'    => now(),
                'printed_by'    => Auth::id(),    // <— opsional bagus
            ]);
        }

        return response($html, 200)->header('Content-Type', 'text/html; charset=UTF-8');
    }

    // ===== Helpers =====

    protected function renderReceiptHtml(Order $order): string
    {
        // Pastikan relasi sudah diload: items, payments, cabang, gudang, cashier
        $css = <<<CSS
    <style>
    *{box-sizing:border-box}
    body{font-family:ui-monospace,Menlo,Consolas,monospace;font-size:12px;margin:0;padding:0;color:#111}
    .wrap{width:58mm;max-width:58mm;margin:0 auto;padding:6px}
    h1,h2,h3,p{margin:0;padding:0}
    .center{text-align:center}
    .right{text-align:right}
    .muted{color:#555}
    .row{display:flex;justify-content:space-between;gap:8px}
    .hr{border-top:1px dashed #333;margin:6px 0}
    table{width:100%;border-collapse:collapse}
    td{vertical-align:top;padding:2px 0}
    .small{font-size:11px}
    .tot td{padding-top:4px}
    .tot .lbl{width:60%}
    .tot .val{width:40%;text-align:right}
    </style>
    CSS;

        // Baris item
        $lines = '';
        foreach ($order->items as $it) {
            $name = e($it->name_snapshot);
            $qty  = rtrim(rtrim(number_format((float)$it->qty, 2, '.', ''), '0'), '.');
            $price = number_format((float)$it->price, 2, '.', '');
            $disc = (float)$it->discount > 0 ? " (-" . number_format((float)$it->discount, 2, '.', '') . ")" : "";
            $lineTotal = number_format((float)$it->line_total, 2, '.', '');
            $lines .= "<tr><td colspan='2'>{$name}</td></tr>";
            $lines .= "<tr><td class='small'>{$qty} x {$price}{$disc}</td><td class='right'>{$lineTotal}</td></tr>";
        }

        // Hitung paid (SUCCESS saja), sisa, dan kembalian
        $paidSuccess = (float) $order->payments->where('status', 'SUCCESS')->sum('amount');
        $grand       = (float) $order->grand_total;
        $remaining   = max(0, $grand - $paidSuccess);   // Sisa Bayar
        $change      = max(0, $paidSuccess - $grand);   // Kembalian (hanya kas)
        $paidStr     = number_format($paidSuccess, 2, '.', '');
        $remainingStr = number_format($remaining, 2, '.', '');
        $changeStr   = number_format($change, 2, '.', '');

        // Meta header
        $metaTop = sprintf(
            '<div class="small muted">%s • %s</div>',
            e(optional($order->cabang)->nama ?? 'Cabang'),
            e(optional($order->gudang)->nama ?? 'Gudang')
        );
        $cashierName = e(optional($order->cashier)->name ?? '—'); // FIX: jangan pakai {e(...)} di heredoc

        // Badge status
        $statusBadge = $order->status === 'PAID' ? 'PAID' : ($order->status === 'VOID' ? 'VOID' : $order->status);

        // Tabel totals (selalu tampil Subtotal..GrandTotal + Paid)
        $totalsRows = '';
        $totalsRows .= sprintf(
            '<tr><td class="lbl">Subtotal</td><td class="val">%s</td></tr>',
            number_format((float)$order->subtotal, 2, '.', '')
        );
        $totalsRows .= sprintf(
            '<tr><td class="lbl">Discount</td><td class="val">%s</td></tr>',
            number_format((float)$order->discount, 2, '.', '')
        );
        $totalsRows .= sprintf(
            '<tr><td class="lbl">Service</td><td class="val">%s</td></tr>',
            number_format((float)$order->service_fee, 2, '.', '')
        );
        $totalsRows .= sprintf(
            '<tr><td class="lbl">Tax</td><td class="val">%s</td></tr>',
            number_format((float)$order->tax, 2, '.', '')
        );
        $totalsRows .= sprintf(
            '<tr><td class="lbl"><b>Grand Total</b></td><td class="val"><b>%s</b></td></tr>',
            number_format($grand, 2, '.', '')
        );
        $totalsRows .= sprintf('<tr><td class="lbl">Paid</td><td class="val">%s</td></tr>', $paidStr);

        // Tampilkan Sisa Bayar jika masih kurang
        if ($remaining > 0) {
            $totalsRows .= sprintf('<tr><td class="lbl"><b>Sisa Bayar</b></td><td class="val"><b>%s</b></td></tr>', $remainingStr);
        }

        // Tampilkan Change hanya jika ada kembalian
        if ($change > 0) {
            $totalsRows .= sprintf('<tr><td class="lbl">Change</td><td class="val">%s</td></tr>', $changeStr);
        }

        // (Opsional) Tampilkan ringkas DP jika paidSuccess > 0 namun belum lunas
        if ($paidSuccess > 0 && $remaining > 0) {
            $totalsRows .= sprintf('<tr><td class="lbl small muted">DP</td><td class="val small muted">%s</td></tr>', $paidStr);
        }

        $totals = "<table class=\"tot\">{$totalsRows}</table>";

        $orderedAt = $order->ordered_at ? e($order->ordered_at->format('Y-m-d H:i')) : '—';
        $kode = e($order->kode ?? '—');

        $html = <<<HTML
    <!doctype html><html><head><meta charset="utf-8">$css</head>
    <body onload="setTimeout(()=>{window.print&&window.print()},10)">
      <div class="wrap">
        <div class="center">
          <h2>POS PRIME</h2>
          {$metaTop}
          <div class="small">No: <b>{$kode}</b> • {$orderedAt}</div>
          <div class="small">Kasir: {$cashierName}</div>
          <div class="hr"></div>
        </div>

        <table>$lines</table>
        <div class="hr"></div>

        {$totals}
        <div class="hr"></div>

        <div class="center small">Status: <b>{$statusBadge}</b></div>
        <div class="center small muted">Terima kasih 🙏</div>
      </div>
    </body></html>
    HTML;

        return $html;
    }
}

```
</details>

### app/Http/Controllers/Api/OrdersController.php

- SHA: `f41c2838e3eb`  
- Ukuran: 3 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `OrdersController` extends `Controller`**

Metode Publik:
- **__construct**(private OrderService $service)
- **index**(IndexOrdersRequest $req)
- **show**(Request $req, Order $order)
- **updateItems**(UpdateOrderItemsRequest $req, Order $order)
- **reprint**(ReprintReceiptRequest $req, Order $order)
- **setCashPosition**(OrderSetCashPositionRequest $req, Order $order)
- **resendWA**(ResendWARequest $req, Order $order)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\OrderSetCashPositionRequest;
use App\Http\Requests\Orders\IndexOrdersRequest;
use App\Http\Requests\Orders\UpdateOrderItemsRequest;
use App\Http\Requests\Orders\ReprintReceiptRequest;
use App\Http\Requests\Orders\ResendWARequest;
use App\Models\Order;
use App\Services\OrderService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;

class OrdersController extends Controller
{
    public function __construct(private OrderService $service) {}

    public function index(IndexOrdersRequest $req)
    {
        $this->authorize('viewAny', Order::class);
        $user = $req->user();
        $paginator = $this->service->list(
            $req->validated(),
            $user->role === 'superadmin' ? null : $user->cabang_id
        );
        // Jika $paginator instanceof LengthAwarePaginator, kembalikan langsung agar shape sesuai harapan frontend
        return response()->json($paginator);
    }

    public function show(Request $req, Order $order)
    {
        $this->authorize('view', $order);
        return response()->json(['data' => $order->load(['items', 'payments'])]);
    }

    public function updateItems(UpdateOrderItemsRequest $req, Order $order)
    {
        $this->authorize('update', $order);
        $updated = $this->service->updateItems($order, $req->validated(), $req->user()->id);
        return response()->json(['message' => 'Order updated', 'data' => $updated]);
    }

    public function reprint(ReprintReceiptRequest $req, Order $order)
    {
        $this->authorize('reprint', $order);
        $payload = $this->service->reprintReceipt($order, $req->validated()['format'] ?? null, $req->user()->id);
        return response()->json(['message' => 'Receipt generated', 'data' => $payload]);
    }

    public function setCashPosition(OrderSetCashPositionRequest $req, Order $order)
    {
        $this->authorize('setCashPosition', $order);

        $v = $req->validated();

        return DB::transaction(function () use ($order, $v) {
            $before = $order->cash_position;
            $order->cash_position = $v['cash_position']; // CUSTOMER | CASHIER | SALES | ADMIN
            $order->save();

            if (class_exists(\App\Models\OrderChangeLog::class)) {
                \App\Models\OrderChangeLog::create([
                    'order_id'    => $order->id,
                    'actor_id'    => Auth::id(),
                    'action'      => 'SET_CASH_POSITION',
                    'diff_json'   => ['before' => $before, 'after' => $order->cash_position],
                    'occurred_at' => now(),
                ]);
            }

            return response()->json($order->fresh(['items', 'payments']));
        });
    }

    public function resendWA(ResendWARequest $req, Order $order)
    {
        $this->authorize('resendWA', $order);
        $payload = $this->service->resendWA(
            $order,
            $req->validated()['phone'],
            $req->validated()['message'] ?? null,
            $req->user()->id
        );
        return response()->json(['message' => 'WA link created', 'data' => $payload]);
    }
}

```
</details>

### app/Http/Controllers/Api/PaymentWebhookController.php

- SHA: `caac01c8a834`  
- Ukuran: 2 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `PaymentWebhookController` extends `Controller`**

Metode Publik:
- **invoice**(Request $req)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use App\Models\Payment;
use App\Models\Order;
use Carbon\Carbon;

class PaymentWebhookController extends Controller
{
    public function invoice(Request $req)
    {
        // Validasi token sederhana (Xendit mengirim X-Callback-Token bila diaktifkan)
        $expected = (string) env('XENDIT_CALLBACK_TOKEN');
        $token = (string) $req->header('X-Callback-Token', '');

        if ($expected !== '' && !hash_equals($expected, $token)) {
            abort(403, 'Invalid callback token');
        }

        $payload = $req->all();
        $status  = strtoupper((string)($payload['status'] ?? ''));
        $extId   = (string)($payload['external_id'] ?? '');

        if ($extId === '') {
            throw ValidationException::withMessages(['external_id' => 'Missing external_id']);
        }

        return DB::transaction(function () use ($status, $extId, $payload) {
            /** @var Payment|null $payment */
            $payment = Payment::lockForUpdate()
                ->where('method', 'XENDIT')
                ->where('ref_no', $extId)
                ->first();

            if (!$payment) {
                abort(404, 'Payment not found');
            }

            /** @var Order $order */
            $order = Order::lockForUpdate()->findOrFail($payment->order_id);

            if ($status === 'PAID') {
                $payment->status   = 'SUCCESS';
                $payment->paid_at  = Carbon::now();
                $payment->payload_json = $payload;
                $payment->save();

                // akumulasi ke order
                $order->paid_total = (float) $order->paid_total + (float) $payment->amount;
                if ($order->paid_total >= $order->grand_total) {
                    $order->status = 'PAID';
                    $order->paid_at = Carbon::now();
                } else {
                    $order->status = 'UNPAID';
                }
                $order->save();
            } elseif (in_array($status, ['EXPIRED', 'VOID', 'FAILED'], true)) {
                $payment->status   = $status === 'FAILED' ? 'FAILED' : 'FAILED';
                $payment->payload_json = $payload;
                $payment->save();
            }

            return response()->json(['ok' => true]);
        });
    }
}

```
</details>

### app/Http/Controllers/Api/ProductController.php

- SHA: `26fdf663d6ba`  
- Ukuran: 2 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `ProductController` extends `Controller`**

Metode Publik:
- **__construct**(private ProductService $svc)
- **index**(Request $request)
- **store**(StoreProductRequest $request)
- **show**(Product $product)
- **update**(UpdateProductRequest $request, Product $product)
- **destroy**(Product $product)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreProductRequest;
use App\Http\Requests\UpdateProductRequest;
use App\Models\Product;
use App\Services\Products\ProductService;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function __construct(private ProductService $svc) {}

    public function index(Request $request)
    {
        $this->authorize('viewAny', Product::class);

        $term = $request->query('q', $request->query('search'));

        $items = $this->svc->list(
            search: $term,
            perPage: (int) $request->query('per_page', 24)
        );

        return response()->json($items);
    }

    public function store(StoreProductRequest $request)
    {
        $this->authorize('create', Product::class);

        $product = $this->svc->create($request->validated());

        return response()->json([
            'message' => 'Product created',
            'data' => $product,
        ], 201);
    }

    public function show(Product $product)
    {
        $this->authorize('view', $product);
        // ✅ include primaryMedia as well for clients that prefer it
        return response()->json(
            $product->load(['variants', 'media', 'primaryMedia:id,product_id,path,is_primary,sort_order'])
        );
    }

    public function update(UpdateProductRequest $request, Product $product)
    {
        $this->authorize('update', $product);

        $updated = $this->svc->update($product, $request->validated());

        return response()->json([
            'message' => 'Product updated',
            'data' => $updated,
        ]);
    }

    public function destroy(Product $product)
    {
        $this->authorize('delete', $product);

        $this->svc->delete($product);

        return response()->json(['message' => 'Product deleted']);
    }
}

```
</details>

### app/Http/Controllers/Api/ProductMediaController.php

- SHA: `bdccd6c83d5a`  
- Ukuran: 3 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `ProductMediaController` extends `Controller`**

Metode Publik:
- **__construct**(private ProductMediaService $svc)
- **index**(Product $product)
- **store**(UploadProductMediaRequest $request, Product $product)
- **setPrimary**(SetPrimaryProductMediaRequest $request, Product $product)
- **reorder**(ReorderProductMediaRequest $request, Product $product)
- **destroy**(Product $product, ProductMedia $media)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\UploadProductMediaRequest;
use App\Http\Requests\ReorderProductMediaRequest;
use App\Http\Requests\SetPrimaryProductMediaRequest;
use App\Models\Product;
use App\Models\ProductMedia;
use App\Services\Products\ProductMediaService;
use Illuminate\Http\Request;

class ProductMediaController extends Controller
{
    public function __construct(private ProductMediaService $svc) {}

    // List media by product
    public function index(Product $product)
    {
        $this->authorize('view', $product);

        return response()->json(
            $product->media()->orderByDesc('is_primary')->orderBy('sort_order')->get()
        );
    }

    // Upload multiple files
    public function store(UploadProductMediaRequest $request, Product $product)
    {
        $this->authorize('update', $product);

        // Accept *either* single 'file' or array 'files[]'
        $files = [];

        if ($request->hasFile('file')) {
            $files = [$request->file('file')]; // single
        } elseif ($request->hasFile('files')) {
            $files = $request->file('files');  // multiple
        }

        // Safety: either path must pass UploadProductMediaRequest rules (files.*)
        // If you want both paths validated, adjust rules to allow 'file' too (see below).

        $created = [];
        foreach ($files as $uploaded) {
            $path = $uploaded->store("products/{$product->id}", 'public');

            $media = \App\Models\ProductMedia::create([
                'product_id' => $product->id,
                'disk'       => 'public',
                'path'       => $path,
                'mime'       => $uploaded->getClientMimeType(),
                'size_kb'    => (int) round(($uploaded->getSize() ?? 0) / 1024),
                'is_primary' => !\App\Models\ProductMedia::where('product_id', $product->id)->exists(),
                'sort_order' => 0,
            ]);

            // convenience URLs
            $media->url = asset('storage/' . $media->path);
            $created[] = $media;
        }

        return response()->json(['data' => $created], 201);
    }

    // Set primary image
    public function setPrimary(SetPrimaryProductMediaRequest $request, Product $product)
    {
        $this->authorize('update', $product);

        $media = ProductMedia::where('product_id', $product->id)
            ->where('id', $request->validated()['media_id'])
            ->firstOrFail();

        $this->svc->setPrimary($product, $media);

        return response()->json(['message' => 'Primary image set']);
    }

    // Reorder (sort_order)
    public function reorder(ReorderProductMediaRequest $request, Product $product)
    {
        $this->authorize('update', $product);

        $this->svc->reorder($product, $request->validated()['orders']);

        return response()->json(['message' => 'Media reordered']);
    }

    // Delete media
    public function destroy(Product $product, ProductMedia $media)
    {
        $this->authorize('update', $product);
        $this->authorize('delete', $media);
        abort_unless($media->product_id === $product->id, 404);

        $this->svc->delete($media);

        return response()->json(['message' => 'Media deleted']);
    }
}

```
</details>

### app/Http/Controllers/Api/ProductVariantController.php

- SHA: `f9b0ca0b2d23`  
- Ukuran: 5 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `ProductVariantController` extends `Controller`**

Metode Publik:
- **__construct**(private ProductService $svc)
- **search**(Request $req)
- **index**(Product $product)
- **store**(StoreVariantRequest $request, Product $product)
- **show**(Product $product, ProductVariant $variant)
- **update**(UpdateVariantRequest $request, Product $product, ProductVariant $variant)
- **destroy**(Product $product, ProductVariant $variant)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreVariantRequest;
use App\Http\Requests\UpdateVariantRequest;
use App\Models\Product;
use App\Models\ProductVariant;
use App\Services\Products\ProductService;
use Illuminate\Http\Request;

class ProductVariantController extends Controller
{
    public function __construct(private ProductService $svc) {}

    public function search(Request $req)
    {
        // Pastikan policy Anda punya ability 'viewAny' untuk ProductVariant
        $this->authorize('viewAny', ProductVariant::class);

        // Validasi ringan
        $validated = $req->validate([
            'q'            => ['nullable', 'string', 'max:100'],
            'warehouse_id' => ['nullable', 'integer', 'min:1'],
            'per_page'     => ['nullable', 'integer', 'min:1', 'max:50'],
        ]);

        $term        = trim((string)($validated['q'] ?? ''));
        $warehouseId = $validated['warehouse_id'] ?? null;
        $perPage     = (int)($validated['per_page'] ?? 10);

        $query = ProductVariant::query()
            ->with(['product:id,nama,is_active'])          // untuk tampilkan nama produk
            ->where('is_active', true)
            ->whereHas('product', fn($q) => $q->where('is_active', true));

        // Pencarian fleksibel: sku / size / type / nama produk
        if ($term !== '') {
            $like = '%' . str_replace(['%', '_'], ['\%', '\_'], $term) . '%';
            $query->where(function ($w) use ($like) {
                $w->where('sku', 'like', $like)
                    ->orWhere('size', 'like', $like)
                    ->orWhere('type', 'like', $like)
                    ->orWhereHas('product', fn($p) => $p->where('nama', 'like', $like));
            });
        }

        // Filter gudang opsional: hanya varian yang punya stok di gudang tsb
        if (!empty($warehouseId)) {
            $query->whereExists(function ($sub) use ($warehouseId) {
                $sub->from('variant_stocks')
                    ->whereColumn('variant_stocks.product_variant_id', 'product_variants.id')
                    ->where('variant_stocks.gudang_id', $warehouseId);
            });
        }

        $paginator = $query->orderByDesc('id')->paginate($perPage);

        // Bentuk data seperti yang UI harapkan
        $data = $paginator->getCollection()->map(function (ProductVariant $v) {
            $namaProduk = $v->product->nama ?? '';
            return [
                'id'        => $v->id,
                'sku'       => $v->sku,
                'harga'     => (float) $v->harga,
                'nama'      => $namaProduk,
                'full_name' => trim($namaProduk . ' ' . $v->size . ' ' . $v->type),
                // 'barcode' => $v->barcode ?? null, // aktifkan jika ada kolom barcode
            ];
        });

        return response()->json([
            'data'         => $data,
            'current_page' => $paginator->currentPage(),
            'per_page'     => $paginator->perPage(),
            'total'        => $paginator->total(),
            'last_page'    => $paginator->lastPage(),
        ]);
    }

    // List varian by product
    public function index(Product $product)
    {
        $this->authorize('view', $product);

        $items = $product->variants()->orderByDesc('id')->get();

        return response()->json([
            'data' => $items,
        ]);
    }

    // Create varian
    public function store(StoreVariantRequest $request, Product $product)
    {
        $this->authorize('update', $product);

        $variant = $this->svc->createVariant($product, $request->validated());

        return response()->json([
            'message' => 'Variant created',
            'data' => $variant,
        ], 201);
    }

    // Show varian
    public function show(Product $product, ProductVariant $variant)
    {
        $this->authorize('view', $product);
        $this->authorize('view', $variant);

        // Opsional: validasi varian milik product
        abort_unless($variant->product_id === $product->id, 404);

        return response()->json($variant);
    }

    // Update varian
    public function update(UpdateVariantRequest $request, Product $product, ProductVariant $variant)
    {
        $this->authorize('update', $product);
        $this->authorize('update', $variant);
        abort_unless($variant->product_id === $product->id, 404);

        $updated = $this->svc->updateVariant($variant, $request->validated());

        return response()->json([
            'message' => 'Variant updated',
            'data' => $updated,
        ]);
    }

    // Delete varian
    public function destroy(Product $product, ProductVariant $variant)
    {
        $this->authorize('update', $product);
        $this->authorize('delete', $variant);
        abort_unless($variant->product_id === $product->id, 404);

        $this->svc->deleteVariant($variant);

        return response()->json(['message' => 'Variant deleted']);
    }
}

```
</details>

### app/Http/Controllers/Api/SettingsController.php

- SHA: `a3898c984722`  
- Ukuran: 4 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `SettingsController` extends `Controller`**

Metode Publik:
- **__construct**(private SettingService $svc)
- **index**(SettingQueryRequest $req) — GET /api/v1/settings
- **upsert**(SettingUpsertRequest $req) — GET /api/v1/settings
- **bulkUpsert**(SettingBulkUpsertRequest $req) — GET /api/v1/settings
- **destroy**(Setting $setting) — GET /api/v1/settings
- **export**(ExportRequest $req) — GET /api/v1/settings
- **import**(ImportRequest $req) — GET /api/v1/settings
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api; // keep this to match your folder casing

use App\Http\Controllers\Controller;
use App\Http\Requests\SettingQueryRequest;
use App\Http\Requests\SettingUpsertRequest;
use App\Http\Requests\SettingBulkUpsertRequest;
use App\Http\Requests\ExportRequest;
use App\Http\Requests\ImportRequest;
use App\Models\Setting;
use App\Services\SettingService;

class SettingsController extends Controller
{
    public function __construct(private SettingService $svc) {}

    /** GET /api/v1/settings */
    public function index(SettingQueryRequest $req)
    {
        $this->authorize('viewAny', Setting::class);

        $v = $req->validated();
        $scope   = $v['scope']    ?? null;                 // 'GLOBAL' | 'BRANCH' | 'USER' | null
        $scopeId = $v['scope_id'] ?? null;                 // int|null
        $keys    = $v['keys']     ?? null;                 // array<string>|null

        $data = $this->svc->export($scope, $scopeId, $keys);

        return response()->json([
            'data' => $data,
            'meta' => [],
            'message' => 'OK',
            'errors' => null,
        ]);
    }

    /** POST /api/v1/settings/upsert */
    public function upsert(SettingUpsertRequest $req)
    {
        $this->authorize('create', Setting::class);

        $v = $req->validated();
        $setting = $this->svc->upsert(
            $v['scope'],
            $v['scope_id'] ?? null,
            $v['key'],
            $v['value'] // array
        );

        // confirm user is allowed to update this particular row (branch scoping)
        $this->authorize('update', $setting);

        return response()->json([
            'data' => $setting,
            'meta' => [],
            'message' => 'Saved',
            'errors' => null,
        ]);
    }

    /** POST /api/v1/settings/bulk-upsert */
    public function bulkUpsert(SettingBulkUpsertRequest $req)
    {
        $this->authorize('create', Setting::class);

        $v = $req->validated();
        $count = $this->svc->bulkUpsert($v['items']);

        return response()->json([
            'data' => ['count' => $count],
            'meta' => [],
            'message' => 'Saved',
            'errors' => null,
        ]);
    }

    /** DELETE /api/v1/settings/{setting} */
    public function destroy(Setting $setting)
    {
        $this->authorize('delete', $setting);

        $this->svc->delete($setting);

        return response()->json([
            'data' => null,
            'meta' => [],
            'message' => 'Deleted',
            'errors' => null,
        ]);
    }

    /** GET /api/v1/settings/export */
    public function export(ExportRequest $req)
    {
        $this->authorize('export', Setting::class);

        $v = $req->validated();
        $scope   = $v['scope']    ?? null;
        $scopeId = $v['scope_id'] ?? null;
        $keys    = $v['keys']     ?? null;

        $items = $this->svc->export($scope, $scopeId, $keys);

        return response()->json([
            'data' => ['items' => $items],
            'meta' => ['format' => 'json'],
            'message' => 'OK',
            'errors' => null,
        ]);
    }

    /** POST /api/v1/settings/import */
    public function import(ImportRequest $req)
    {
        $this->authorize('import', Setting::class);

        $v = $req->validated();
        $result = $this->svc->import(
            $v['items'],
            $v['mode'] ?? 'merge' // replace | merge | skip
        );

        return response()->json([
            'data' => $result,
            'meta' => [],
            'message' => 'Imported',
            'errors' => null,
        ]);
    }
}

```
</details>

### app/Http/Controllers/Api/UserController.php

- SHA: `5ce08cece238`  
- Ukuran: 2 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `UserController` extends `Controller`**

Metode Publik:
- **__construct**(private readonly UserService $users)
- **index**(Request $request)
- **store**(UserStoreRequest $request)
- **show**(int $id)
- **update**(UserUpdateRequest $request, int $id)
- **destroy**(int $id)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

// app/Http/Controllers/api/UserController.php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\UserStoreRequest;
use App\Http\Requests\UserUpdateRequest;
use App\Models\User;
use App\Services\User\UserService;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function __construct(
        private readonly UserService $users
    ) {}

    // GET /api/v1/users
    public function index(Request $request)
    {
        $this->authorize('viewAny', User::class);

        $actor = $request->user();

        // siapkan filters dari query
        $filters = [
            'q'         => $request->query('q'),
            'role'      => $request->query('role'),
            'cabang_id' => $request->integer('cabang_id') ?: null,
            'is_active' => $request->has('is_active')
                ? filter_var($request->query('is_active'), FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE)
                : null,
            'per_page'  => $request->integer('per_page') ?: 15,
        ];

        // force scope by cabang untuk admin_cabang & kasir
        if (in_array($actor->role, ['admin_cabang', 'kasir', 'gudang'], true)) {
            $filters['cabang_id'] = $actor->cabang_id; // override apapun dari query
        }

        $data = $this->users->paginate($filters);

        return response()->json($data);
    }

    // POST /api/v1/users
    public function store(UserStoreRequest $request)
    {
        $this->authorize('create', User::class);

        $user = $this->users->create($request->validated());

        return response()->json($user, 201);
    }

    // GET /api/v1/users/{id}
    public function show(int $id)
    {
        $target = $this->users->findOrFail($id);
        $this->authorize('view', $target);

        return response()->json($target);
    }

    // PUT /api/v1/users/{id}
    public function update(UserUpdateRequest $request, int $id)
    {
        $target = $this->users->findOrFail($id);
        $this->authorize('update', $target);

        $updated = $this->users->update($target, $request->validated());
        return response()->json($updated);
    }

    // DELETE /api/v1/users/{id}
    public function destroy(int $id)
    {
        $target = $this->users->findOrFail($id);
        $this->authorize('delete', $target);

        $this->users->delete($target);
        return response()->json(['message' => 'Deleted']);
    }
}

```
</details>

### app/Http/Controllers/Api/VariantStockController.php

- SHA: `203e50c86bff`  
- Ukuran: 4 KB  
- Namespace: `App\Http\Controllers\Api`

**Class `VariantStockController` extends `Controller`**

Metode Publik:
- **__construct**(private VariantStockService $service)
- **index**(Request $request) — GET /api/v1/stocks
- **show**(VariantStock $stock) — GET /api/v1/stocks
- **store**(VariantStockStoreRequest $request) — GET /api/v1/stocks
- **update**(VariantStockUpdateRequest $request, VariantStock $stock) — GET /api/v1/stocks
- **adjust**(VariantStockAdjustRequest $request, VariantStock $stock) — GET /api/v1/stocks
- **destroy**(VariantStock $stock) — GET /api/v1/stocks
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\VariantStockStoreRequest;
use App\Http\Requests\VariantStockAdjustRequest;
use App\Http\Requests\VariantStockUpdateRequest;
use App\Models\VariantStock;
use App\Services\VariantStockService;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class VariantStockController extends Controller
{
    public function __construct(private VariantStockService $service)
    {
        // pastikan pakai sanctum di route group
    }

    /**
     * GET /api/v1/stocks
     * Query: cabang_id?, gudang_id?, product_variant_id?, low=1?
     */
    public function index(Request $request)
    {
        $this->authorize('viewAny', VariantStock::class);

        $q = VariantStock::query()->with(['gudang','variant','cabang']);

        if ($request->filled('cabang_id')) {
            $q->where('cabang_id', (int)$request->integer('cabang_id'));
        }
        if ($request->filled('gudang_id')) {
            $q->where('gudang_id', (int)$request->integer('gudang_id'));
        }
        if ($request->filled('product_variant_id')) {
            $q->where('product_variant_id', (int)$request->integer('product_variant_id'));
        }
        if ($request->boolean('low')) {
            $q->whereColumn('qty', '<', 'min_stok');
        }

        $perPage = max(1, (int)$request->integer('per_page', 10));
        $data = $q->orderBy('id','desc')->paginate($perPage);

        // tambah flag is_low_stock per item
        $data->getCollection()->transform(function ($row) {
            $row->is_low_stock = $row->qty < $row->min_stok;
            return $row;
        });

        return response()->json($data);
    }

    /**
     * GET /api/v1/stocks/{id}
     */
    public function show(VariantStock $stock)
    {
        $this->authorize('view', $stock);
        $stock->load(['gudang','variant','cabang']);
        $stock->is_low_stock = $stock->qty < $stock->min_stok;

        return response()->json([
            'data' => $stock
        ]);
    }

    /**
     * POST /api/v1/stocks  (set stok awal / upsert unik)
     */
    public function store(VariantStockStoreRequest $request)
    {
        $this->authorize('create', VariantStock::class);

        $stock = $this->service->setInitialStock(
            gudangId: (int)$request->integer('gudang_id'),
            variantId: (int)$request->integer('product_variant_id'),
            qty: (int)$request->integer('qty'),
            minStok: $request->has('min_stok') ? (int)$request->integer('min_stok') : null
        );

        $stock->is_low_stock = $stock->qty < $stock->min_stok;

        return response()->json([
            'message' => 'Stok awal diset.',
            'data' => $stock
        ], Response::HTTP_CREATED);
    }

    /**
     * PATCH /api/v1/stocks/{stock}  (ubah min_stok saja)
     */
    public function update(VariantStockUpdateRequest $request, VariantStock $stock)
    {
        $this->authorize('update', $stock);

        $updated = $this->service->updateMinStok($stock, (int)$request->integer('min_stok'));
        $updated->is_low_stock = $updated->qty < $updated->min_stok;

        return response()->json([
            'message' => 'Threshold low-stock diperbarui.',
            'data' => $updated
        ]);
    }

    /**
     * POST /api/v1/stocks/{stock}/adjust  (tambah/kurang stok manual)
     */
    public function adjust(VariantStockAdjustRequest $request, VariantStock $stock)
    {
        $this->authorize('adjust', $stock);

        $updated = $this->service->adjust(
            stock: $stock,
            type: $request->input('type'),
            amount: (int)$request->integer('amount'),
            note: $request->input('note')
        );
        $updated->is_low_stock = $updated->qty < $updated->min_stok;

        return response()->json([
            'message' => 'Stok berhasil disesuaikan.',
            'data' => $updated
        ]);
    }

    /**
     * DELETE /api/v1/stocks/{stock}
     */
    public function destroy(VariantStock $stock)
    {
        $this->authorize('delete', $stock);
        $stock->delete();

        return response()->json([
            'message' => 'Data stok dihapus.'
        ]);
    }
}

```
</details>



## Models (app/Models)

### app/Models/Account.php

- SHA: `4c4729aeb52a`  
- Ukuran: 653 B  
- Namespace: `App\Models`

**Class `Account` extends `Model`**

Metode Publik:
- **parent**()
- **children**()
- **lines**()
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Account extends Model
{
    protected $fillable = [
        'cabang_id',
        'code',
        'name',
        'type',
        'normal_balance',
        'parent_id',
        'is_active'
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    public function parent()
    {
        return $this->belongsTo(Account::class, 'parent_id');
    }
    public function children()
    {
        return $this->hasMany(Account::class, 'parent_id');
    }
    public function lines()
    {
        return $this->hasMany(JournalLine::class, 'account_id');
    }
}

```
</details>

### app/Models/AuditLog.php

- SHA: `57b73456403b`  
- Ukuran: 295 B  
- Namespace: `App\Models`

**Class `AuditLog` extends `Model`**
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AuditLog extends Model
{
    protected $fillable = ['actor_type', 'actor_id', 'action', 'model', 'model_id', 'diff_json', 'occurred_at'];
    protected $casts = ['diff_json' => 'array', 'occurred_at' => 'datetime'];
}

```
</details>

### app/Models/Backup.php

- SHA: `c4d5493eabea`  
- Ukuran: 294 B  
- Namespace: `App\Models`

**Class `Backup` extends `Model`**
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Backup extends Model
{
    public $timestamps = false;
    protected $fillable = ['storage_path', 'kind', 'size_bytes', 'created_at'];
    protected $casts = ['size_bytes' => 'integer', 'created_at' => 'datetime'];
}

```
</details>

### app/Models/Cabang.php

- SHA: `ab57074d2744`  
- Ukuran: 662 B  
- Namespace: `App\Models`

**Class `Cabang` extends `Model`**

Metode Publik:
- **gudangs**()
- **users**()
- **scopeActive**($q) — Scope: hanya cabang aktif
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cabang extends Model
{
    use HasFactory;

    protected $fillable = [
        'nama', 'kota', 'alamat', 'telepon', 'jam_operasional', 'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    public function gudangs()
    {
        return $this->hasMany(Gudang::class);
    }

    public function users()
    {
        return $this->hasMany(User::class);
    }

    /** Scope: hanya cabang aktif */
    public function scopeActive($q)
    {
        return $q->where('is_active', true);
    }
}

```
</details>

### app/Models/CashHolder.php

- SHA: `7e52741f9e3a`  
- Ukuran: 630 B  
- Namespace: `App\Models`

**Class `CashHolder` extends `Model`**

Metode Publik:
- **cabang**() : *BelongsTo*
- **outgoingMoves**() : *HasMany*
- **incomingMoves**() : *HasMany*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class CashHolder extends Model
{
    protected $fillable = ['cabang_id', 'name', 'balance'];

    public function cabang(): BelongsTo
    {
        return $this->belongsTo(Cabang::class, 'cabang_id');
    }
    public function outgoingMoves(): HasMany
    {
        return $this->hasMany(CashMove::class, 'from_holder_id');
    }
    public function incomingMoves(): HasMany
    {
        return $this->hasMany(CashMove::class, 'to_holder_id');
    }
}

```
</details>

### app/Models/CashMove.php

- SHA: `f19d3b96be4e`  
- Ukuran: 1 KB  
- Namespace: `App\Models`

**Class `CashMove` extends `Model`**

Metode Publik:
- **from**() : *BelongsTo*
- **to**() : *BelongsTo*
- **submitter**() : *BelongsTo*
- **approver**() : *BelongsTo*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class CashMove extends Model
{
    protected $fillable = [
        'from_holder_id',
        'to_holder_id',
        'amount',
        'note',
        'moved_at',
        'status',
        'submitted_by',
        'approved_by',
        'approved_at',
        'rejected_at',
        'reject_reason',
        'idempotency_key'
    ];
    protected $casts = [
        'amount'    => 'decimal:2',
        'moved_at'  => 'datetime',
        'approved_at' => 'datetime',
        'rejected_at' => 'datetime',
    ];
    public function from(): BelongsTo
    {
        return $this->belongsTo(CashHolder::class, 'from_holder_id');
    }
    public function to(): BelongsTo
    {
        return $this->belongsTo(CashHolder::class, 'to_holder_id');
    }
    public function submitter(): BelongsTo
    {
        return $this->belongsTo(User::class, 'submitted_by');
    }
    public function approver(): BelongsTo
    {
        return $this->belongsTo(User::class, 'approved_by');
    }
}

```
</details>

### app/Models/CashSession.php

- SHA: `4e48a0942ea5`  
- Ukuran: 898 B  
- Namespace: `App\Models`

**Class `CashSession` extends `Model`**

Metode Publik:
- **cabang**() : *BelongsTo*
- **cashier**() : *BelongsTo*
- **transactions**() : *HasMany*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class CashSession extends Model
{
    protected $fillable = [
        'cabang_id',
        'cashier_id',
        'opening_amount',
        'closing_amount',
        'status',
        'opened_at',
        'closed_at'
    ];
    protected $casts = ['opening_amount' => 'decimal:2', 'closing_amount' => 'decimal:2', 'opened_at' => 'datetime', 'closed_at' => 'datetime'];
    public function cabang(): BelongsTo
    {
        return $this->belongsTo(Cabang::class, 'cabang_id');
    }
    public function cashier(): BelongsTo
    {
        return $this->belongsTo(User::class, 'cashier_id');
    }
    public function transactions(): HasMany
    {
        return $this->hasMany(CashTransaction::class, 'session_id');
    }
}

```
</details>

### app/Models/CashTransaction.php

- SHA: `1b75cbd334e2`  
- Ukuran: 479 B  
- Namespace: `App\Models`

**Class `CashTransaction` extends `Model`**

Metode Publik:
- **session**() : *BelongsTo*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class CashTransaction extends Model
{
    protected $fillable = ['session_id', 'type', 'amount', 'source', 'ref_type', 'ref_id', 'note', 'occurred_at'];
    protected $casts = ['amount' => 'decimal:2', 'occurred_at' => 'datetime'];
    public function session(): BelongsTo
    {
        return $this->belongsTo(CashSession::class, 'session_id');
    }
}

```
</details>

### app/Models/Category.php

- SHA: `c742eb5ece7f`  
- Ukuran: 1 KB  
- Namespace: `App\Models`

**Class `Category` extends `Model`**

Metode Publik:
- **scopeActive**($q) — Scope: hanya kategori aktif
- **scopeSearch**($q, ?string $term) — Scope: hanya kategori aktif
- **products**() — Scope: hanya kategori aktif
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;

    protected $table = 'categories';

    protected $fillable = [
        'nama',
        'slug',
        'deskripsi',
        'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    /** Scope: hanya kategori aktif */
    public function scopeActive($q)
    {
        return $q->where('is_active', true);
    }

    /** Scope pencarian sederhana pada nama/slug */
    public function scopeSearch($q, ?string $term)
    {
        $term = trim((string) $term);
        if ($term === '') return $q;

        return $q->where(function ($w) use ($term) {
            $w->where('nama', 'like', "%{$term}%")
              ->orWhere('slug', 'like', "%{$term}%");
        });
    }

    /** Relasi ke produk — akan diaktifkan saat modul Produk tersedia */
    // public function products()
    // {
    //     return $this->hasMany(Product::class, 'category_id');
    // }
}

```
</details>

### app/Models/Customer.php

- SHA: `af5d99560b4e`  
- Ukuran: 1 KB  
- Namespace: `App\Models`

**Class `Customer` extends `Model`**

Metode Publik:
- **orders**() : *HasMany*
- **timelines**() : *HasMany*
- **scopeForCabang**($q, int $cabangId) — Scope data by cabang (branch).
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasManyThrough;

class Customer extends Model
{
    protected $table = 'customers';

    protected $fillable = [
        'cabang_id',
        'nama',
        'phone',
        'email',
        'alamat',
        'catatan',
        'stage',
        'last_order_at',
        'total_spent',
        'total_orders',
    ];

    protected $casts = [
        'last_order_at' => 'datetime',
        'total_spent'   => 'decimal:2',
        'total_orders'  => 'integer',
    ];

    public function orders(): HasMany
    {
        return $this->hasMany(Order::class, 'customer_id');
    }

    public function timelines(): HasMany
    {
        return $this->hasMany(CustomerTimeline::class, 'customer_id');
    }

    /** Scope data by cabang (branch). */
    public function scopeForCabang($q, int $cabangId)
    {
        return $q->where('cabang_id', $cabangId);
    }
}

```
</details>

### app/Models/CustomerTimeline.php

- SHA: `4790a2b5f3dd`  
- Ukuran: 414 B  
- Namespace: `App\Models`

**Class `CustomerTimeline` extends `Model`**
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CustomerTimeline extends Model
{
    protected $table = 'customer_timelines';

    protected $fillable = [
        'customer_id',
        'event_type',
        'title',
        'note',
        'meta',
        'happened_at',
    ];

    protected $casts = [
        'meta'        => 'array',
        'happened_at' => 'datetime',
    ];
}

```
</details>

### app/Models/Delivery.php

- SHA: `6bfb09b74275`  
- Ukuran: 1 KB  
- Namespace: `App\Models`

**Class `Delivery` extends `Model`**

Metode Publik:
- **order**()
- **courier**() : *BelongsTo*
- **events**() : *HasMany*
- **scopeStatus**($q, string $status)
- **scopeCourier**($q, int $userId)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\{BelongsTo, HasMany};
use Illuminate\Support\Facades\DB;

class Delivery extends Model
{
    protected $fillable = [
        'order_id',
        'assigned_to',
        'type',
        'status',
        'pickup_address',
        'delivery_address',
        'pickup_lat',
        'pickup_lng',
        'delivery_lat',
        'delivery_lng',
        'requested_at',
        'completed_at',
    ];

    protected $casts = [
        'requested_at' => 'datetime',
        'completed_at' => 'datetime',
        'pickup_lat' => 'decimal:7',
        'pickup_lng' => 'decimal:7',
        'delivery_lat' => 'decimal:7',
        'delivery_lng' => 'decimal:7',
    ];

    public function order()
    {
        return $this->belongsTo(Order::class)->select([
            'id',
            DB::raw('"kode" as code'),
            'cabang_id',
        ]);
    }

    public function courier(): BelongsTo
    {
        return $this->belongsTo(User::class, 'assigned_to');
    }

    public function events(): HasMany
    {
        return $this->hasMany(DeliveryEvent::class);
    }

    // Quick scopes
    public function scopeStatus($q, string $status)
    {
        return $q->where('status', $status);
    }
    public function scopeCourier($q, int $userId)
    {
        return $q->where('assigned_to', $userId);
    }
}

```
</details>

### app/Models/DeliveryEvent.php

- SHA: `ec925007ced9`  
- Ukuran: 474 B  
- Namespace: `App\Models`

**Class `DeliveryEvent` extends `Model`**

Metode Publik:
- **delivery**() : *BelongsTo*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class DeliveryEvent extends Model
{
    protected $fillable = [
        'delivery_id',
        'status',
        'note',
        'photo_url',
        'occurred_at',
    ];

    protected $casts = [
        'occurred_at' => 'datetime',
    ];

    public function delivery(): BelongsTo
    {
        return $this->belongsTo(Delivery::class);
    }
}

```
</details>

### app/Models/Fee.php

- SHA: `69efa1f26b91`  
- Ukuran: 1 KB  
- Namespace: `App\Models`

**Class `Fee` extends `Model`**

Metode Publik:
- **cabang**()
- **entries**()
- **scopeActive**(Builder $q, ?bool $isActive = true) : *Builder*
- **scopeCabang**(Builder $q, $cabangId) : *Builder*
- **scopeSearch**(Builder $q, ?string $term) : *Builder*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Fee extends Model
{
    protected $fillable = [
        'cabang_id',
        'name',
        'kind',
        'calc_type',
        'rate',
        'base',
        'is_active',
        'created_by',
        'updated_by'
    ];

    protected $casts = [
        'is_active' => 'boolean',
        'rate' => 'decimal:2',
    ];

    public function cabang()
    {
        return $this->belongsTo(Cabang::class, 'cabang_id');
    }

    public function entries()
    {
        return $this->hasMany(FeeEntry::class, 'fee_id');
    }

    /* ===== Scopes ===== */
    public function scopeActive(Builder $q, ?bool $isActive = true): Builder
    {
        if ($isActive === null) return $q;
        return $q->where('is_active', $isActive);
    }

    public function scopeCabang(Builder $q, $cabangId): Builder
    {
        if (!$cabangId) return $q;
        return $q->where('cabang_id', $cabangId);
    }

    public function scopeSearch(Builder $q, ?string $term): Builder
    {
        if (!$term) return $q;
        return $q->where(function ($qq) use ($term) {
            $qq->where('name', 'like', "%{$term}%");
        });
    }
}

```
</details>

### app/Models/FeeEntry.php

- SHA: `c8cd808b475d`  
- Ukuran: 794 B  
- Namespace: `App\Models`

**Class `FeeEntry` extends `Model`**

Metode Publik:
- **fee**() : *BelongsTo*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class FeeEntry extends Model
{
    protected $fillable = [
        'fee_id',
        'cabang_id',
        'period_date',
        'ref_type',
        'ref_id',
        'owner_user_id',
        'base_amount',
        'fee_amount',
        'pay_status',
        'paid_amount',
        'paid_at',
        'notes',
        'created_by',
        'updated_by'
    ];

    protected $casts = [
        'period_date' => 'date',
        'base_amount' => 'decimal:2',
        'fee_amount' => 'decimal:2',
        'paid_amount' => 'decimal:2',
        'paid_at' => 'datetime',
    ];

    public function fee(): BelongsTo
    {
        return $this->belongsTo(Fee::class);
    }
}

```
</details>

### app/Models/FiscalPeriod.php

- SHA: `bbfa7e3c6412`  
- Ukuran: 375 B  
- Namespace: `App\Models`

**Class `FiscalPeriod` extends `Model`**

Metode Publik:
- **scopeCabang**($q, $cabangId)
- **isOpen**() : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FiscalPeriod extends Model
{
    protected $fillable = ['cabang_id', 'year', 'month', 'status'];

    public function scopeCabang($q, $cabangId)
    {
        return $q->where('cabang_id', $cabangId);
    }

    public function isOpen(): bool
    {
        return $this->status === 'OPEN';
    }
}

```
</details>

### app/Models/Gudang.php

- SHA: `c85192cb137f`  
- Ukuran: 610 B  
- Namespace: `App\Models`

**Class `Gudang` extends `Model`**

Metode Publik:
- **cabang**()
- **stokVarian**()
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Gudang extends Model
{
    use HasFactory;

    protected $fillable = [
        'cabang_id',
        'nama',
        'is_default',
        'is_active',
    ];

    protected $casts = [
        'is_default' => 'boolean',
        'is_active' => 'boolean',
    ];

    public function cabang()
    {
        return $this->belongsTo(Cabang::class);
    }

    // Placeholder relasi stok: akan ditambahkan saat modul Stok Gudang dibuat.
    // public function stokVarian() { ... }
}

```
</details>

### app/Models/JournalEntry.php

- SHA: `2823cad761a4`  
- Ukuran: 399 B  
- Namespace: `App\Models`

**Class `JournalEntry` extends `Model`**

Metode Publik:
- **lines**()
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class JournalEntry extends Model
{
    protected $fillable = [
        'cabang_id',
        'journal_date',
        'number',
        'description',
        'status',
        'period_year',
        'period_month'
    ];

    public function lines()
    {
        return $this->hasMany(JournalLine::class, 'journal_id');
    }
}

```
</details>

### app/Models/JournalLine.php

- SHA: `f51d2bbc2ae3`  
- Ukuran: 495 B  
- Namespace: `App\Models`

**Class `JournalLine` extends `Model`**

Metode Publik:
- **journal**()
- **account**()
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class JournalLine extends Model
{
    protected $fillable = [
        'journal_id',
        'account_id',
        'cabang_id',
        'debit',
        'credit',
        'ref_type',
        'ref_id'
    ];

    public function journal()
    {
        return $this->belongsTo(JournalEntry::class, 'journal_id');
    }
    public function account()
    {
        return $this->belongsTo(Account::class, 'account_id');
    }
}

```
</details>

### app/Models/Order.php

- SHA: `c077871f554d`  
- Ukuran: 2 KB  
- Namespace: `App\Models`

**Class `Order` extends `Model`**

Metode Publik:
- **cabang**() : *BelongsTo*
- **gudang**() : *BelongsTo*
- **cashier**() : *BelongsTo*
- **items**() : *HasMany*
- **customer**()
- **payments**() : *HasMany*
- **isEditable**() : *bool*
- **isPaid**() : *bool*
- **scopeOfCabang**($q, $cabangId)
- **getCodeAttribute**() : *?string*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\{BelongsTo, HasMany};

class Order extends Model
{
    protected $fillable = [
        'kode',
        'cabang_id',
        'gudang_id',
        'cashier_id',
        'customer_id',
        'customer_name',
        'customer_phone',
        'customer_address',
        'status',
        'subtotal',
        'discount',
        'tax',
        'service_fee',
        'grand_total',
        'paid_total',
        'cash_position',
        'channel',
        'note',
        'ordered_at',
    ];

    protected $casts = [
        'subtotal'    => 'float',
        'discount'    => 'float',
        'tax'         => 'float',
        'service_fee' => 'float',
        'grand_total' => 'float',
        'paid_total'  => 'float',
        'cash_position' => 'string',
        'ordered_at'  => 'datetime',
    ];

    // Relations
    public function cabang(): BelongsTo
    {
        return $this->belongsTo(Cabang::class, 'cabang_id');
    }
    public function gudang(): BelongsTo
    {
        return $this->belongsTo(Gudang::class, 'gudang_id');
    }
    public function cashier(): BelongsTo
    {
        return $this->belongsTo(User::class, 'cashier_id');
    }
    public function items(): HasMany
    {
        return $this->hasMany(OrderItem::class);
    }
    public function customer()
    {
        return $this->belongsTo(Customer::class, 'customer_id');
    }
    public function payments(): HasMany
    {
        return $this->hasMany(Payment::class);
    }
    public function isEditable(): bool
    {
        return in_array($this->status, ['DRAFT', 'UNPAID'], true);
    }
    public function isPaid(): bool
    {
        return $this->status === 'PAID';
    }

    // Scope by branch (for Admin Cabang / Kasir)
    public function scopeOfCabang($q, $cabangId)
    {
        return $q->where('cabang_id', $cabangId);
    }

    public function getCodeAttribute(): ?string
    {
        // jika kolom 'kode' ada, expose sebagai 'code'
        return $this->attributes['kode'] ?? null;
    }
}

```
</details>

### app/Models/OrderChangeLog.php

- SHA: `5a9129811a7d`  
- Ukuran: 471 B  
- Namespace: `App\Models`

**Class `OrderChangeLog` extends `Model`**

Metode Publik:
- **order**()
- **actor**()
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OrderChangeLog extends Model
{
    protected $fillable = ['order_id', 'actor_id', 'action', 'diff_json', 'note', 'occurred_at'];
    protected $casts = ['diff_json' => 'array', 'occurred_at' => 'datetime'];
    public function order()
    {
        return $this->belongsTo(Order::class);
    }
    public function actor()
    {
        return $this->belongsTo(User::class, 'actor_id');
    }
}

```
</details>

### app/Models/OrderItem.php

- SHA: `bcb36ae8399d`  
- Ukuran: 1 KB  
- Namespace: `App\Models`

**Class `OrderItem` extends `Model`**

Metode Publik:
- **getNameAttribute**() : *?string*
- **getNoteAttribute**() : *?string*
- **order**() : *BelongsTo*
- **variant**() : *BelongsTo*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class OrderItem extends Model
{
    protected $fillable = [
        'order_id',
        'variant_id',
        'name_snapshot',
        'price',
        'discount',
        'qty',
        'line_total'
    ];

    protected $casts = [
        'price'      => 'float',
        'discount'   => 'float',
        'qty'        => 'float',
        'line_total' => 'float',
    ];

    // ⬇⬇ tambahkan agar muncul di JSON response
    protected $appends = ['name', 'note'];

    // alias "name" → ke name_snapshot
    public function getNameAttribute(): ?string
    {
        return $this->attributes['name_snapshot'] ?? null;
    }

    // sistem tidak punya kolom note di order_items → default null
    public function getNoteAttribute(): ?string
    {
        return null;
    }

    public function order(): BelongsTo
    {
        return $this->belongsTo(Order::class);
    }

    public function variant(): BelongsTo
    {
        return $this->belongsTo(ProductVariant::class, 'variant_id');
    }
}

```
</details>

### app/Models/Payment.php

- SHA: `407ab78b3e21`  
- Ukuran: 559 B  
- Namespace: `App\Models`

**Class `Payment` extends `Model`**

Metode Publik:
- **order**() : *BelongsTo*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Payment extends Model
{
    protected $fillable = [
        'order_id',
        'method',
        'amount',
        'status',
        'ref_no',
        'payload_json',
        'paid_at'
    ];

    protected $casts = [
        'amount' => 'decimal:2',
        'payload_json' => 'array',
        'paid_at' => 'datetime',
    ];

    public function order(): BelongsTo
    {
        return $this->belongsTo(Order::class);
    }
}

```
</details>

### app/Models/Product.php

- SHA: `4f4fc6a66bec`  
- Ukuran: 3 KB  
- Namespace: `App\Models`

**Class `Product` extends `Model`**

Metode Publik:
- **category**() — 🔹 Make image_url appear in JSON automatically
- **variants**() — 🔹 Make image_url appear in JSON automatically
- **media**() — 🔹 Make image_url appear in JSON automatically
- **primaryMedia**() — 🔹 Make image_url appear in JSON automatically
- **scopeActive**($q) — 🔹 Make image_url appear in JSON automatically
- **scopeSearch**($q, ?string $term) — 🔹 Make image_url appear in JSON automatically
- **getImageUrlAttribute**() : *?string* — 🔹 Make image_url appear in JSON automatically
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;
use Illuminate\Filesystem\FilesystemAdapter;

class Product extends Model
{
    protected $fillable = [
        'category_id',
        'nama',
        'slug',
        'deskripsi',
        'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    /** 🔹 Make image_url appear in JSON automatically */
    protected $appends = ['image_url'];

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function variants()
    {
        return $this->hasMany(ProductVariant::class);
    }

    public function media()
    {
        return $this->hasMany(ProductMedia::class)
            ->orderBy('is_primary', 'desc')
            ->orderBy('sort_order');
    }

    /** 🔹 The single primary media (fast to eager-load) */
    public function primaryMedia()
    {
        return $this->hasOne(ProductMedia::class)
            ->where('is_primary', true)
            ->orderBy('sort_order');
    }

    /** Scope aktif */
    public function scopeActive($q)
    {
        return $q->where('is_active', true);
    }

    /** Scope pencarian nama/slug */
    public function scopeSearch($q, ?string $term)
    {
        $term = trim((string) $term);
        if ($term === '') return $q;

        return $q->where(
            fn($w) =>
            $w->where('nama', 'like', "%{$term}%")
                ->orWhere('slug', 'like', "%{$term}%")
        );
    }

    /** 🔹 JSON accessor for the POS thumbnail URL */
    public function getImageUrlAttribute(): ?string
    {
        // Prefer eager-loaded primaryMedia; otherwise pick the first from media()
        $media = $this->relationLoaded('primaryMedia')
            ? $this->getRelation('primaryMedia')
            : $this->primaryMedia()->first();

        if (!$media) {
            // fallback: first non-primary media if exists
            $media = $this->relationLoaded('media')
                ? ($this->getRelation('media')->first() ?: null)
                : $this->media()->first();
        }

        if (!$media || empty($media->path)) return null;

        // Build a stable public URL (FILES_BASE_URL falls back to APP_URL)
        $base = rtrim(env('FILES_BASE_URL', config('app.url')), '/');
        $path = ltrim($media->path, '/'); // stored on "public" disk as e.g. products/xx.jpg

        /** @var FilesystemAdapter $disk */
        $disk = Storage::disk('public');

        return $disk->url($media->path);
    }
}

```
</details>

### app/Models/ProductMedia.php

- SHA: `dd7a854bb294`  
- Ukuran: 544 B  
- Namespace: `App\Models`

**Class `ProductMedia` extends `Model`**

Metode Publik:
- **product**()
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductMedia extends Model
{
    protected $table = 'product_media';

    protected $fillable = [
        'product_id',
        'disk',
        'path',
        'mime',
        'size_kb',
        'is_primary',
        'sort_order',
    ];

    protected $casts = [
        'is_primary' => 'boolean',
        'size_kb' => 'integer',
        'sort_order' => 'integer',
    ];

    public function product()
    {
        return $this->belongsTo(Product::class);
    }
}

```
</details>

### app/Models/ProductVariant.php

- SHA: `c3aeddab0fbd`  
- Ukuran: 666 B  
- Namespace: `App\Models`

**Class `ProductVariant` extends `Model`**

Metode Publik:
- **product**()
- **stocks**()
- **scopeActive**($q) — Scope aktif
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductVariant extends Model
{
    protected $fillable = [
        'product_id',
        'size',
        'type',
        'tester',
        'sku',
        'harga',
        'is_active',
    ];

    protected $casts = [
        'harga' => 'decimal:2',
        'is_active' => 'boolean',
    ];

    public function product()
    {
        return $this->belongsTo(Product::class);
    }

    // Placeholder relasi stok per gudang (M5)
    // public function stocks() { ... }

    /** Scope aktif */
    public function scopeActive($q)
    {
        return $q->where('is_active', true);
    }
}

```
</details>

### app/Models/Receipt.php

- SHA: `6bf9676573f7`  
- Ukuran: 699 B  
- Namespace: `App\Models`

**Class `Receipt` extends `Model`**

Metode Publik:
- **order**()
- **printer**()
- **parent**()
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Receipt extends Model
{
    protected $fillable = [
        'order_id',
        'print_format',
        'html_snapshot',
        'wa_url',
        'printed_by',
        'printed_at',
        'reprint_of_id',
    ];

    protected $casts = [
        'print_format' => 'integer',
        'printed_at'   => 'datetime',
    ];

    public function order()
    {
        return $this->belongsTo(Order::class);
    }
    public function printer()
    {
        return $this->belongsTo(User::class, 'printed_by');
    }
    public function parent()
    {
        return $this->belongsTo(Receipt::class, 'reprint_of_id');
    }
}

```
</details>

### app/Models/Setting.php

- SHA: `87fbb052d6ae`  
- Ukuran: 604 B  
- Namespace: `App\Models`

**Class `Setting` extends `Model`**

Metode Publik:
- **scopeGlobal**($q)
- **scopeBranch**($q, int $branchId)
- **scopeUser**($q, int $userId)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Setting extends Model
{
    protected $fillable = ['scope', 'scope_id', 'key', 'value_json'];
    protected $casts = ['value_json' => 'array'];

    // Scope helpers
    public function scopeGlobal($q)
    {
        return $q->where('scope', 'GLOBAL');
    }
    public function scopeBranch($q, int $branchId)
    {
        return $q->where(['scope' => 'BRANCH', 'scope_id' => $branchId]);
    }
    public function scopeUser($q, int $userId)
    {
        return $q->where(['scope' => 'USER', 'scope_id' => $userId]);
    }
}

```
</details>

### app/Models/User.php

- SHA: `42007d99ad50`  
- Ukuran: 2 KB  
- Namespace: `App\Models`

**Class `User` extends `Authenticatable`**

Metode Publik:
- **scopeForCabang**($query, ?int $cabangId)
- **cabang**()
- **deliveries**()
- **hasRoleCompat**(string $role) : *bool*
- **hasAnyRoleCompat**(array $roles) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

// app/Models/User.php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Spatie\Permission\Traits\HasRoles;

class User extends Authenticatable
{
    use HasApiTokens, Notifiable, HasFactory;
    use HasRoles;

    protected $guard_name = 'web';

    protected $fillable = [
        'name',
        'email',
        'phone',
        'password',
        'cabang_id',
        'role',
        'is_active',
    ];

    protected $hidden = ['password', 'remember_token'];

    protected $casts = [
        'is_active' => 'boolean',
        'email_verified_at' => 'datetime',
    ];

    // Scope: batasi query per cabang (digunakan di controller/service)
    public function scopeForCabang($query, ?int $cabangId)
    {
        if ($cabangId) {
            $query->where('cabang_id', $cabangId);
        }
        return $query;
    }

    public function cabang()
    {
        return $this->belongsTo(Cabang::class);
    }

    public function deliveries()
    {
        // tugas delivery yang di-assign ke user (kurir)
        return $this->hasMany(\App\Models\Delivery::class, 'assigned_to');
    }

    public function hasRoleCompat(string $role): bool
    {
        $norm = fn($s) => str_replace([' ', '-'], '_', strtolower($s));
        $want = $norm($role);

        // 1) Cek Spatie
        if (method_exists($this, 'hasRole') && $this->hasRole($role)) {
            return true;
        }
        // 2) Cek kolom `role`
        return $norm((string) $this->role) === $want;
    }

    public function hasAnyRoleCompat(array $roles): bool
    {
        foreach ($roles as $r) {
            if ($this->hasRoleCompat($r)) return true;
        }
        return false;
    }
}

```
</details>

### app/Models/VariantStock.php

- SHA: `19f73772c2d4`  
- Ukuran: 1 KB  
- Namespace: `App\Models`

**Class `VariantStock` extends `Model`**

Metode Publik:
- **cabang**()
- **gudang**()
- **variant**()
- **scopeOfCabang**($q, $cabangId)
- **scopeLowStock**($q)
- **getIsLowStockAttribute**() : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class VariantStock extends Model
{
    protected $fillable = [
        'cabang_id',
        'gudang_id',
        'product_variant_id',
        'qty',
        'min_stok',
    ];

    protected $casts = [
        'qty' => 'integer',
        'min_stok' => 'integer',
    ];

    // RELATIONS
    public function cabang()
    {
        return $this->belongsTo(Cabang::class, 'cabang_id');
    }

    public function gudang()
    {
        return $this->belongsTo(Gudang::class, 'gudang_id');
    }

    public function variant()
    {
        return $this->belongsTo(ProductVariant::class, 'product_variant_id');
    }

    // SCOPES
    public function scopeOfCabang($q, $cabangId)
    {
        return $q->where('cabang_id', $cabangId);
    }

    public function scopeLowStock($q)
    {
        return $q->whereColumn('qty', '<', 'min_stok');
    }

    public function getIsLowStockAttribute(): bool
    {
        return $this->qty < $this->min_stok;
    }
}

```
</details>



## Policies (app/Policies)

### app/Policies/AccountPolicy.php

- SHA: `67f73ec081f1`  
- Ukuran: 859 B  
- Namespace: `App\Policies`

**Class `AccountPolicy`**

Metode Publik:
- **viewAny**(User $u) : *bool*
- **view**(User $u, Account $m) : *bool*
- **create**(User $u) : *bool*
- **update**(User $u, Account $m) : *bool*
- **delete**(User $u, Account $m) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\User;
use App\Models\Account;

class AccountPolicy
{
    public function viewAny(User $u): bool
    {
        return $u->hasAnyRoleCompat(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang', 'kasir']);
    }

    public function view(User $u, Account $m): bool
    {
        return $this->viewAny($u);
    }

    public function create(User $u): bool
    {
        return $u->hasAnyRoleCompat(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang']);
    }

    public function update(User $u, Account $m): bool
    {
        return $u->hasAnyRoleCompat(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang']);
    }

    public function delete(User $u, Account $m): bool
    {
        return $u->hasAnyRoleCompat(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang']);
    }
}

```
</details>

### app/Policies/BackupPolicy.php

- SHA: `67a11d8d02c2`  
- Ukuran: 487 B  
- Namespace: `App\Policies`

**Class `BackupPolicy`**

Metode Publik:
- **create**(User $user) : *bool*
- **viewAny**(User $user) : *bool*
- **restore**(User $user) : *bool*
- **delete**(User $user) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\User;

class BackupPolicy
{
    public function create(User $user): bool
    {
        return $user->hasRole('Superadmin');
    }
    public function viewAny(User $user): bool
    {
        return $user->hasRole('Superadmin');
    }
    public function restore(User $user): bool
    {
        return $user->hasRole('Superadmin');
    }
    public function delete(User $user): bool
    {
        return $user->hasRole('Superadmin');
    }
}

```
</details>

### app/Policies/CabangPolicy.php

- SHA: `b548414e0c66`  
- Ukuran: 2 KB  
- Namespace: `App\Policies`

**Class `CabangPolicy`**

Metode Publik:
- **before**(User $user, string $ability)
- **viewAny**(User $user) : *bool*
- **view**(User $user, Cabang $cabang) : *bool*
- **create**(User $user) : *bool*
- **update**(User $user, Cabang $cabang) : *bool*
- **delete**(User $user, Cabang $cabang) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\Cabang;
use App\Models\User;

class CabangPolicy
{
    public function before(User $user, string $ability)
    {
        if ($user->role === 'superadmin') {
            return true;
        }
        return null;
    }

    public function viewAny(User $user): bool
    {
        // Semua role boleh melihat daftar cabang,
        // tapi Admin Cabang dan role non-superadmin hanya melihat cabangnya sendiri (dibatasi di query/controller).
        return in_array($user->role, ['admin_cabang', 'gudang', 'kasir', 'sales', 'kurir', 'superadmin'], true);
    }

    public function view(User $user, Cabang $cabang): bool
    {
        if ($user->role === 'admin_cabang') {
            return $user->cabang_id === $cabang->id;
        }
        // role lain (gudang/kasir/sales/kurir) hanya boleh lihat kalau 1 cabang yang sama
        if (in_array($user->role, ['gudang','kasir','sales','kurir'], true)) {
            return $user->cabang_id === $cabang->id;
        }
        return false;
    }

    public function create(User $user): bool
    {
        // hanya superadmin (handled by before) atau admin_cabang? -> cabang baru biasanya dibuat pusat
        // jika ingin izinkan admin_cabang membuat sub-cabang, ubah ke true sesuai kebutuhan
        return false;
    }

    public function update(User $user, Cabang $cabang): bool
    {
        if ($user->role === 'admin_cabang') {
            return $user->cabang_id === $cabang->id;
        }
        return false;
    }

    public function delete(User $user, Cabang $cabang): bool
    {
        if ($user->role === 'admin_cabang') {
            // Admin cabang tidak boleh hapus cabangnya sendiri (umumnya kebijakan bisnis)
            return false;
        }
        return false;
    }
}

```
</details>

### app/Policies/CashHolderPolicy.php

- SHA: `53c6ad27051d`  
- Ukuran: 617 B  
- Namespace: `App\Policies`

**Class `CashHolderPolicy`**

Metode Publik:
- **viewAny**(User $user) : *bool*
- **create**(User $user) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\User;
use App\Models\CashHolder;

class CashHolderPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->hasAnyRole([
            'superadmin',
            'admin cabang',
            'admin_cabang',
            'admin-cabang',
            'kasir',
            'sales',
            'kurir',
        ]) || $user->can('cash.view');
    }

    public function create(User $user): bool
    {
        return $user->hasAnyRole(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang'])
            || $user->can('cash.holder.create');
    }
}

```
</details>

### app/Policies/CashMovePolicy.php

- SHA: `c97ad0af949e`  
- Ukuran: 1 KB  
- Namespace: `App\Policies`

**Class `CashMovePolicy`**

Metode Publik:
- **viewAny**(User $user) : *bool*
- **view**(User $user, CashMove $m) : *bool*
- **create**(User $user) : *bool*
- **approve**(User $user, CashMove $m) : *bool*
- **reject**(User $user, CashMove $m) : *bool*
- **delete**(User $user, CashMove $m) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\User;
use App\Models\CashMove;

class CashMovePolicy
{
    public function viewAny(User $user): bool
    {
        return $user->hasAnyRole([
            'superadmin',
            'admin cabang',
            'admin_cabang',
            'admin-cabang',
            'kasir',
            'sales',
            'kurir',
        ]) || $user->can('cash.view');
    }
    public function view(User $user, CashMove $m): bool
    {
        return $this->viewAny($user);
    }
    public function create(User $user): bool
    {
        return $user->hasAnyRole(['kasir', 'sales', 'kurir'])
            || $user->can('cash.create');
    }
    public function approve(User $user, CashMove $m): bool
    {
        return $user->hasAnyRole(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang'])
            || $user->can('cash.approve');
    }
    public function reject(User $user, CashMove $m): bool
    {
        return $this->approve($user, $m);
    }
    public function delete(User $user, CashMove $m): bool
    {
        return $user->hasAnyRole(['superadmin']) || $user->can('cash.delete');
    }
}

```
</details>

### app/Policies/CategoryPolicy.php

- SHA: `3008597e322f`  
- Ukuran: 1 KB  
- Namespace: `App\Policies`

**Class `CategoryPolicy`**

Metode Publik:
- **before**(User $user, string $ability) : *bool|null*
- **viewAny**(User $user) : *bool*
- **view**(User $user, Category $category) : *bool*
- **create**(User $user) : *bool*
- **update**(User $user, Category $category) : *bool*
- **delete**(User $user, Category $category) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\Category;
use App\Models\User;

class CategoryPolicy
{
    public function before(User $user, string $ability): bool|null
    {
        // superadmin full access
        if ($user->role === 'superadmin') {
            return true;
        }
        return null;
    }

    public function viewAny(User $user): bool
    {
        // semua role boleh melihat daftar kategori
        return in_array($user->role, ['superadmin', 'admin_cabang', 'gudang', 'kasir', 'sales', 'kurir'], true);
    }

    public function view(User $user, Category $category): bool
    {
        return $this->viewAny($user);
    }

    public function create(User $user): bool
    {
        return in_array($user->role, ['superadmin', 'admin_cabang'], true);
    }

    public function update(User $user, Category $category): bool
    {
        return in_array($user->role, ['superadmin', 'admin_cabang'], true);
    }

    public function delete(User $user, Category $category): bool
    {
        return in_array($user->role, ['superadmin', 'admin_cabang'], true);
    }
}

```
</details>

### app/Policies/CustomerPolicy.php

- SHA: `f5de37418352`  
- Ukuran: 4 KB  
- Namespace: `App\Policies`

**Class `CustomerPolicy`**

Metode Publik:
- **before**(User $user, $ability)
- **viewAny**(User $user) : *bool*
- **view**(User $user, Customer $customer) : *bool*
- **create**(User $user) : *bool*
- **update**(User $user, Customer $customer) : *bool*
- **delete**(User $user, Customer $customer) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\User;
use App\Models\Customer;

class CustomerPolicy
{
    public function before(User $user, $ability)
    {
        // superadmin selalu boleh
        if (method_exists($user, 'hasRole') && $user->hasRole('superadmin')) {
            return true;
        }
        // jika pakai compat dan ada alias 'super admin' dsb
        if (method_exists($user, 'hasRoleCompat') && $user->hasRoleCompat('superadmin')) {
            return true;
        }
        return null;
    }

    public function viewAny(User $user): bool
    {
        $roles = ['superadmin','admin_cabang','admin cabang','admin-cabang','kasir','sales','kurir','gudang'];

        if (method_exists($user, 'hasAnyRoleCompat')) {
            return $user->hasAnyRoleCompat($roles);
        }
        if (method_exists($user, 'hasAnyRole')) {
            // Spatie: nama harus persis
            return $user->hasAnyRole(['superadmin','admin_cabang','kasir','sales','kurir','gudang']);
        }
        return in_array(strtolower((string)$user->role), ['superadmin','admin_cabang','kasir','sales','kurir','gudang'], true);
    }

    public function view(User $user, Customer $customer): bool
    {
        // admin_cabang boleh lihat semua (di cabangnya—opsional: batasi cabang jika mau)
        if (
            (method_exists($user, 'hasAnyRoleCompat') && $user->hasAnyRoleCompat(['admin_cabang','admin cabang','admin-cabang'])) ||
            (method_exists($user, 'hasRole') && $user->hasRole('admin_cabang')) ||
            (strtolower((string)$user->role) === 'admin_cabang')
        ) {
            return true;
        }

        // kasir & sales: hanya customer di cabang yang sama
        $isKasirAtauSales =
            (method_exists($user, 'hasAnyRoleCompat') && $user->hasAnyRoleCompat(['kasir','sales'])) ||
            (method_exists($user, 'hasAnyRole') && $user->hasAnyRole(['kasir','sales'])) ||
            in_array(strtolower((string)$user->role), ['kasir','sales'], true);

        if ($isKasirAtauSales) {
            return (int)$user->cabang_id === (int)$customer->cabang_id; // <- perbaiki branch_id → cabang_id
        }

        return false;
    }

    public function create(User $user): bool
    {
        if (method_exists($user, 'hasAnyRoleCompat')) {
            return $user->hasAnyRoleCompat(['admin_cabang','admin cabang','admin-cabang','kasir','sales']);
        }
        if (method_exists($user, 'hasAnyRole')) {
            return $user->hasAnyRole(['admin_cabang','kasir','sales']);
        }
        return in_array(strtolower((string)$user->role), ['admin_cabang','kasir','sales'], true);
    }

    public function update(User $user, Customer $customer): bool
    {
        // hanya admin_cabang, dan harus di cabang yang sama
        $isAdminCabang =
            (method_exists($user, 'hasAnyRoleCompat') && $user->hasAnyRoleCompat(['admin_cabang','admin cabang','admin-cabang'])) ||
            (method_exists($user, 'hasRole') && $user->hasRole('admin_cabang')) ||
            (strtolower((string)$user->role) === 'admin_cabang');

        return $isAdminCabang && (int)$user->cabang_id === (int)$customer->cabang_id;
    }

    public function delete(User $user, Customer $customer): bool
    {
        // konsisten dengan update()
        $isAdminCabang =
            (method_exists($user, 'hasAnyRoleCompat') && $user->hasAnyRoleCompat(['admin_cabang','admin cabang','admin-cabang'])) ||
            (method_exists($user, 'hasRole') && $user->hasRole('admin_cabang')) ||
            (strtolower((string)$user->role) === 'admin_cabang');

        return $isAdminCabang && (int)$user->cabang_id === (int)$customer->cabang_id;
    }
}

```
</details>

### app/Policies/DashboardPolicy.php

- SHA: `9a80e128e714`  
- Ukuran: 436 B  
- Namespace: `App\Policies`

**Class `DashboardPolicy`**

Metode Publik:
- **view**(User $user) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\User;

class DashboardPolicy
{
    public function view(User $user): bool
    {
        // Selaras dengan FE: superadmin, admin_cabang, kasir, sales
        if (method_exists($user, 'hasAnyRole')) {
            return $user->hasAnyRole(['superadmin', 'admin_cabang', 'kasir', 'sales']);
        }

        // fallback sederhana bila helper role tidak tersedia
        return true;
    }
}

```
</details>

### app/Policies/DeliveryPolicy.php

- SHA: `dd5e5d98e312`  
- Ukuran: 4 KB  
- Namespace: `App\Policies`

**Class `DeliveryPolicy`**

Metode Publik:
- **before**(User $user, string $ability) : *bool|null* — Superadmin boleh semua via Spatie helper kamu
- **viewAny**(User $actor) : *bool* — Superadmin boleh semua via Spatie helper kamu
- **view**(User $actor, Delivery $delivery) : *bool* — Superadmin boleh semua via Spatie helper kamu
- **create**(User $user, Order $order) : *bool* — Superadmin boleh semua via Spatie helper kamu
- **assign**(User $actor, Delivery $delivery) : *bool* — Superadmin boleh semua via Spatie helper kamu
- **updateStatus**(User $actor, Delivery $delivery) : *bool* — Superadmin boleh semua via Spatie helper kamu
- **addEvent**(User $user, Delivery $delivery) : *bool* — Superadmin boleh semua via Spatie helper kamu
- **note**(User $actor, Delivery $delivery) : *bool* — Superadmin boleh semua via Spatie helper kamu
- **sendSuratJalan**(User $actor, Delivery $delivery) : *bool* — Superadmin boleh semua via Spatie helper kamu
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\{Delivery, Order, User};

class DeliveryPolicy
{
    /** Superadmin boleh semua via Spatie helper kamu */
    public function before(User $user, string $ability): bool|null
    {
        return $user->hasRoleCompat('superadmin') ? true : null;
    }

    /** List deliveries (FE index). Kurir hanya akan melihat miliknya via query scope/controller. */
    public function viewAny(User $actor): bool
    {
        return in_array($actor->role, ['superadmin', 'admin_cabang', 'kasir', 'kurir', 'gudang'], true);
    }

    /** Lihat 1 delivery */
    public function view(User $actor, Delivery $delivery): bool
    {
        // admin_cabang/kasir/gudang: harus satu cabang dgn order
        if (in_array($actor->role, ['admin_cabang', 'kasir', 'gudang'], true)) {
            return $this->sameBranch($actor, $delivery);
        }

        // kurir: hanya yang ditugaskan
        if ($actor->role === 'kurir') {
            return (int)$delivery->assigned_to === (int)$actor->id;
        }

        return false;
    }

    /**
     * Buat delivery untuk sebuah order.
     * Dipakai dengan Gate::authorize('create', [Delivery::class, $order])
     */
    public function create(User $user, Order $order): bool
    {
        if ($user->hasAnyRoleCompat(['admin_cabang', 'kasir', 'admin', 'gudang'])) {
            return (int)$order->cabang_id === (int)$user->cabang_id;
        }
        return $user->hasRoleCompat('superadmin');
    }

    /** Assign kurir */
    public function assign(User $actor, Delivery $delivery): bool
    {
        if (in_array($actor->role, ['admin_cabang', 'kasir', 'gudang'], true)) {
            return $this->sameBranch($actor, $delivery) && !$this->isFinal($delivery);
        }
        return false;
    }

    /** Update status (kurir miliknya, admin/kasir/gudang di cabangnya) */
    public function updateStatus(User $actor, Delivery $delivery): bool
    {
        if ($actor->role === 'kurir') {
            return (int)$delivery->assigned_to === (int)$actor->id;
        }
        if (in_array($actor->role, ['admin_cabang', 'kasir', 'gudang'], true)) {
            return $this->sameBranch($actor, $delivery);
        }
        return false;
    }

    /** Tambah event tracking → ikut aturan updateStatus */
    public function addEvent(User $user, Delivery $delivery): bool
    {
        return $this->updateStatus($user, $delivery);
    }

    /**
     * ====== Tambahan untuk SURAT JALAN ======
     * Lihat/cetak Surat Jalan (HTML). Syarat: boleh view & sudah assigned.
     */
    public function note(User $actor, Delivery $delivery): bool
    {
        if (!$this->view($actor, $delivery)) return false;
        return !is_null($delivery->assigned_to);
    }

    /**
     * Kirim WA Surat Jalan ke kurir. Syarat: cabang sesuai (atau kurir sendiri) & sudah assigned.
     * FE akan memanggil POST /deliveries/{id}/send-wa
     */
    public function sendSuratJalan(User $actor, Delivery $delivery): bool
    {
        // kurir boleh kirim link SJ untuk dirinya sendiri
        if ($actor->role === 'kurir') {
            return (int)$delivery->assigned_to === (int)$actor->id;
        }
        // admin_cabang/kasir/gudang boleh jika satu cabang
        if (in_array($actor->role, ['admin_cabang', 'kasir', 'gudang'], true)) {
            return $this->sameBranch($actor, $delivery) && !is_null($delivery->assigned_to);
        }
        return false;
    }

    /** ===== Helpers ===== */

    private function sameBranch(User $actor, Delivery $delivery): bool
    {
        // pastikan relasi order terload di controller: $delivery->loadMissing('order')
        if (!$actor->cabang_id || !$delivery->order) return false;
        return (int)$actor->cabang_id === (int)$delivery->order->cabang_id;
    }

    private function isFinal(Delivery $delivery): bool
    {
        // Sesuaikan dengan enum/status final di sistemmu
        return in_array($delivery->status, ['DELIVERED', 'FAILED', 'CANCELLED'], true);
    }
}

```
</details>

### app/Policies/FeeEntryPolicy.php

- SHA: `2e96d0eaf736`  
- Ukuran: 2 KB  
- Namespace: `App\Policies`

**Class `FeeEntryPolicy`**

Metode Publik:
- **viewAny**(User $user) : *bool*
- **view**(User $user, FeeEntry $entry) : *bool*
- **updateStatus**(User $user, FeeEntry $entry) : *bool*
- **export**(User $user) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\User;
use App\Models\FeeEntry;

class FeeEntryPolicy
{

    private function has(User $u, string $role): bool
    {
        // accept either Spatie role name OR users.role column
        return $u->hasRole($role) || ($u->role === $role);
    }
    private function isSuper(User $u): bool
    {
        return $this->has($u, 'superadmin');
    }
    private function isAdminCab(User $u): bool
    {
        return $this->has($u, 'admin_cabang');
    }
    private function isKasir(User $u): bool
    {
        return $this->has($u, 'kasir');
    }
    private function isKurir(User $u): bool
    {
        return $this->has($u, 'kurir');
    }
    private function isSales(User $u): bool
    {
        return $this->has($u, 'sales');
    }
    public function viewAny(User $user): bool
    {
        return $this->isSuper($user)
            || $this->isAdminCab($user)
            || $this->isSales($user)
            || $this->isKasir($user)
            || $this->isKurir($user);
    }

    public function view(User $user, FeeEntry $entry): bool
    {
        if ($this->isSales($user) || $this->isKasir($user) || $this->isKurir($user)) {
            return $entry->owner_user_id === $user->id;
        }
        // Admins: branch-level or superadmin
        return $this->isSuper($user)
            || ($this->isAdminCab($user) && ($user->cabang_id ?? null) === $entry->cabang_id);
    }

    public function updateStatus(User $user, FeeEntry $entry): bool
    {
        // Only admins can mark paid
        return $this->isSuper($user) || $this->isAdminCab($user);
    }

    public function export(User $user): bool
    {
        return $this->isSuper($user) || $this->isAdminCab($user);
    }
}

```
</details>

### app/Policies/FeePolicy.php

- SHA: `9f84acde3060`  
- Ukuran: 1 KB  
- Namespace: `App\Policies`

**Class `FeePolicy`**

Metode Publik:
- **before**(User $user, $ability)
- **viewAny**(User $user) : *bool*
- **view**(User $user, Fee $fee) : *bool*
- **create**(User $user) : *bool*
- **update**(User $user, Fee $fee) : *bool*
- **delete**(User $user, Fee $fee) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\Fee;
use App\Models\User;

class FeePolicy
{
    public function before(User $user, $ability)
    {
        // Jika punya role superadmin → full akses
        if ($user->hasRole('superadmin')) {
            return true;
        }
    }

    public function viewAny(User $user): bool
    {
        // admin_cabang boleh lihat fee cabangnya
        return $user->hasAnyRole(['admin_cabang','kasir','sales']);
    }

    public function view(User $user, Fee $fee): bool
    {
        if ($user->hasRole('admin_cabang')) {
            return $user->cabang_id === $fee->cabang_id;
        }
        return false;
    }

    public function create(User $user): bool
    {
        return $user->hasAnyRole(['admin_cabang']);
    }

    public function update(User $user, Fee $fee): bool
    {
        if ($user->hasRole('admin_cabang')) {
            return $user->cabang_id === $fee->cabang_id;
        }
        return false;
    }

    public function delete(User $user, Fee $fee): bool
    {
        if ($user->hasRole('admin_cabang')) {
            return $user->cabang_id === $fee->cabang_id;
        }
        return false;
    }
}

```
</details>

### app/Policies/FiscalPeriodPolicy.php

- SHA: `fc11ef48030e`  
- Ukuran: 617 B  
- Namespace: `App\Policies`

**Class `FiscalPeriodPolicy`**

Metode Publik:
- **viewAny**(User $u) : *bool*
- **view**(User $u, FiscalPeriod $m) : *bool*
- **open**(User $u) : *bool*
- **close**(User $u, FiscalPeriod $m) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\User;
use App\Models\FiscalPeriod;

class FiscalPeriodPolicy
{
    public function viewAny(User $u): bool
    {
        return $u->hasAnyRole(['superadmin', 'admin_cabang', 'kasir']);
    }
    public function view(User $u, FiscalPeriod $m): bool
    {
        return $this->viewAny($u);
    }

    public function open(User $u): bool
    {
        return $u->hasAnyRole(['superadmin', 'admin_cabang']);
    }
    public function close(User $u, FiscalPeriod $m): bool
    {
        return $u->hasAnyRole(['superadmin', 'admin_cabang']) && $m->status === 'OPEN';
    }
}

```
</details>

### app/Policies/GudangPolicy.php

- SHA: `607b9578d1f8`  
- Ukuran: 1 KB  
- Namespace: `App\Policies`

**Class `GudangPolicy`**

Metode Publik:
- **before**(User $user, string $ability)
- **viewAny**(User $user) : *bool*
- **view**(User $user, Gudang $gudang) : *bool*
- **create**(User $user) : *bool*
- **update**(User $user, Gudang $gudang) : *bool*
- **delete**(User $user, Gudang $gudang) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\Gudang;
use App\Models\User;

class GudangPolicy
{
    public function before(User $user, string $ability)
    {
        if ($user->role === 'superadmin') {
            return true;
        }
        return null;
    }

    public function viewAny(User $user): bool
    {
        return in_array($user->role, ['admin_cabang','gudang','kasir','sales','kurir','superadmin'], true);
    }

    public function view(User $user, Gudang $gudang): bool
    {
        if ($user->role === 'admin_cabang' || in_array($user->role, ['gudang','kasir','sales','kurir'], true)) {
            return $user->cabang_id === $gudang->cabang_id;
        }
        return false;
    }

    public function create(User $user): bool
    {
        return in_array ($user->role, ['admin_cabang','gudang'], true);
    }

    public function update(User $user, Gudang $gudang): bool
    {
        if ($user->role === 'admin_cabang') {
            return $user->cabang_id === $gudang->cabang_id;
        }
        return false;
    }

    public function delete(User $user, Gudang $gudang): bool
    {
        if ($user->role === 'admin_cabang') {
            return $user->cabang_id === $gudang->cabang_id;
        }
        return false;
    }
}

```
</details>

### app/Policies/JournalEntryPolicy.php

- SHA: `8135e312c2f8`  
- Ukuran: 1 KB  
- Namespace: `App\Policies`

**Class `JournalEntryPolicy`**

Metode Publik:
- **viewAny**(User $u) : *bool*
- **view**(User $u, JournalEntry $m) : *bool*
- **create**(User $u) : *bool*
- **update**(User $u, JournalEntry $m) : *bool*
- **post**(User $u, JournalEntry $m) : *bool*
- **delete**(User $u, JournalEntry $m) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\User;
use App\Models\JournalEntry;

class JournalEntryPolicy
{
    public function viewAny(User $u): bool
    {
        return $u->hasAnyRoleCompat(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang', 'kasir']);
    }

    public function view(User $u, JournalEntry $m): bool
    {
        return $this->viewAny($u);
    }

    public function create(User $u): bool
    {
        return $u->hasAnyRoleCompat(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang']);
    }

    public function update(User $u, JournalEntry $m): bool
    {
        return $u->hasAnyRoleCompat(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang'])
            && $m->status === 'DRAFT';
    }

    public function post(User $u, JournalEntry $m): bool
    {
        return $u->hasAnyRoleCompat(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang'])
            && $m->status === 'DRAFT';
    }

    public function delete(User $u, JournalEntry $m): bool
    {
        return $u->hasAnyRoleCompat(['superadmin', 'admin cabang', 'admin_cabang', 'admin-cabang'])
            && $m->status === 'DRAFT';
    }
}

```
</details>

### app/Policies/OrderPolicy.php

- SHA: `ece4fbf73306`  
- Ukuran: 5 KB  
- Namespace: `App\Policies`

**Class `OrderPolicy`**

Metode Publik:
- **before**(User $user, string $ability) : *?bool*
- **viewAny**(User $user) : *bool*
- **view**(User $user, Order $order) : *bool*
- **create**(User $user) : *bool*
- **update**(User $user, Order $order) : *bool*
- **addPayment**(User $user, Order $order) : *bool*
- **setCashPosition**(User $user, Order $order) : *bool*
- **cancel**(User $user, Order $order) : *bool*
- **print**(User $user, Order $order) : *bool*
- **reprint**(User $user, Order $order) : *bool*
- **resendWA**(User $user, Order $order) : *bool*
- **delete**(User $user, Order $order) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\Order;
use App\Models\User;
use Illuminate\Support\Str;

class OrderPolicy
{
    // SUPERADMIN bypass for all abilities
    public function before(User $user, string $ability): ?bool
    {
        if ($this->isSuper($user)) return true;
        return null;
    }

    protected function hasRoleInsensitive(User $user, string $expected): bool
    {
        $norm = fn(string $v) => Str::of($v)->lower()->replace([' ', '-'], '_')->value();
        $expectedN = $norm($expected);

        // 1) Spatie roles
        if (method_exists($user, 'getRoleNames')) {
            foreach ($user->getRoleNames() as $r) {
                if ($norm($r) === $expectedN) return true;
            }
        }

        // 2) Plain column fallback
        if (isset($user->role) && is_string($user->role) && $norm($user->role) === $expectedN) {
            return true;
        }

        // 3) Optional flags
        $flags = [
            'superadmin'    => (bool)($user->is_super        ?? false),
            'admin_cabang'  => (bool)($user->is_admin_cabang ?? false),
            'kasir'         => (bool)($user->is_kasir        ?? false),
            'sales'         => (bool)($user->is_sales        ?? false),
        ];
        if (($flags[$expectedN] ?? false) === true) return true;

        return false;
    }

    protected function hasAnyInsensitive(User $user, array $expected): bool
    {
        foreach ($expected as $e) if ($this->hasRoleInsensitive($user, $e)) return true;
        return false;
    }

    protected function sameCabang(User $user, ?Order $order = null): bool
    {
        if (!$order) return true;
        // jika order belum punya cabang_id, jangan gagalkan (atau ubah ke `return false;` kalau wajib sama)
        if (is_null($order->cabang_id)) return true;
        if (is_null($user->cabang_id))  return false;
        return (int)$user->cabang_id === (int)$order->cabang_id;
    }

    protected function isSuper(User $user): bool
    {
        return $this->hasRoleInsensitive($user, 'superadmin');
    }

    protected function isAdminCabang(User $user): bool
    {
        return $this->hasRoleInsensitive($user, 'admin_cabang')
            || $this->hasRoleInsensitive($user, 'admin'); // kalau kamu masih pakai plain 'admin'
    }

    protected function isKasir(User $user): bool
    {
        return $this->hasRoleInsensitive($user, 'kasir');
    }

    protected function isSales(User $user): bool
    {
        return $this->hasRoleInsensitive($user, 'sales');
    }

    public function viewAny(User $user): bool
    {
        return $this->isAdminCabang($user) || $this->isKasir($user) || $this->isSales($user);
    }

    public function view(User $user, Order $order): bool
    {
        return $this->sameCabang($user, $order)
            && ($this->isAdminCabang($user) || $this->isKasir($user) || $this->isSales($user));
    }

    // /cart/quote
    public function create(User $user): bool
    {
        return $this->isAdminCabang($user) || $this->isKasir($user) || $this->isSales($user);
    }

    public function update(User $user, Order $order): bool
    {
        if (!in_array($order->status, ['DRAFT', 'UNPAID'], true)) return false;
        return $this->sameCabang($user, $order) && ($this->isAdminCabang($user) || $this->isKasir($user));
    }

    public function addPayment(User $user, Order $order): bool
    {
        if (!in_array($order->status, ['DRAFT', 'UNPAID'], true)) return false;
        return $this->sameCabang($user, $order) && ($this->isAdminCabang($user) || $this->isKasir($user));
    }

    public function setCashPosition(User $user, Order $order): bool
    {
        if (in_array($order->status, ['VOID', 'REFUND'], true)) return false;

        $allowedRole = $this->isAdminCabang($user) || $this->isKasir($user) || $this->isSales($user);
        return $allowedRole && $this->sameCabang($user, $order);
    }

    public function cancel(User $user, Order $order): bool
    {
        // Tidak bisa cancel lagi kalau sudah VOID/REFUND
        if (in_array($order->status, ['VOID', 'REFUND'], true)) return false;

        // PAID: hanya admin cabang (superadmin sudah bypass di before)
        if ($order->status === 'PAID') return $this->isAdminCabang($user);

        return $this->sameCabang($user, $order) && ($this->isAdminCabang($user) || $this->isKasir($user));
    }

    public function print(User $user, Order $order): bool
    {
        return $this->view($user, $order);
    }

    public function reprint(User $user, Order $order): bool
    {
        return $this->view($user, $order);
    }

    public function resendWA(User $user, Order $order): bool
    {
        return $this->view($user, $order);
    }

    public function delete(User $user, Order $order): bool
    {
        return false;
    }
}

```
</details>

### app/Policies/ProductMediaPolicy.php

- SHA: `2c611ebf5b0e`  
- Ukuran: 989 B  
- Namespace: `App\Policies`

**Class `ProductMediaPolicy`**

Metode Publik:
- **viewAny**(User $user) : *bool*
- **view**(User $user, ProductMedia $media) : *bool*
- **create**(User $user) : *bool*
- **update**(User $user, ProductMedia $media) : *bool*
- **delete**(User $user, ProductMedia $media) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\User;
use App\Models\ProductMedia;

class ProductMediaPolicy
{
    private function isRole(User $user, array $roles): bool
    {
        // Spatie: return $user->hasAnyRole($roles);
        return in_array($user->role ?? '', $roles, true);
    }

    public function viewAny(User $user): bool
    {
        return $this->isRole($user, ['superadmin', 'admin_cabang', 'gudang', 'kasir', 'sales']);
    }

    public function view(User $user, ProductMedia $media): bool
    {
        return $this->viewAny($user);
    }

    public function create(User $user): bool
    {
        return $this->isRole($user, ['superadmin', 'admin_cabang']);
    }

    public function update(User $user, ProductMedia $media): bool
    {
        return $this->isRole($user, ['superadmin', 'admin_cabang']);
    }

    public function delete(User $user, ProductMedia $media): bool
    {
        return $this->isRole($user, ['superadmin', 'admin_cabang']);
    }
}

```
</details>

### app/Policies/ProductPolicy.php

- SHA: `54e947b18801`  
- Ukuran: 994 B  
- Namespace: `App\Policies`

**Class `ProductPolicy`**

Metode Publik:
- **viewAny**(User $user) : *bool*
- **view**(User $user, Product $product) : *bool*
- **create**(User $user) : *bool*
- **update**(User $user, Product $product) : *bool*
- **delete**(User $user, Product $product) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\User;
use App\Models\Product;

class ProductPolicy
{
    private function isRole(User $user, array $roles): bool
    {
        // Jika gunakan Spatie:
        // return $user->hasAnyRole($roles);
        return in_array($user->role ?? '', $roles, true);
    }

    public function viewAny(User $user): bool
    {
        return $this->isRole($user, ['superadmin', 'admin_cabang', 'gudang', 'kasir', 'sales']);
    }

    public function view(User $user, Product $product): bool
    {
        return $this->viewAny($user);
    }

    public function create(User $user): bool
    {
        return $this->isRole($user, ['superadmin', 'admin_cabang']);
    }

    public function update(User $user, Product $product): bool
    {
        return $this->isRole($user, ['superadmin', 'admin_cabang']);
    }

    public function delete(User $user, Product $product): bool
    {
        return $this->isRole($user, ['superadmin', 'admin_cabang']);
    }
}

```
</details>

### app/Policies/ProductVariantPolicy.php

- SHA: `d2d05bffd45d`  
- Ukuran: 1005 B  
- Namespace: `App\Policies`

**Class `ProductVariantPolicy`**

Metode Publik:
- **viewAny**(User $user) : *bool*
- **view**(User $user, ProductVariant $variant) : *bool*
- **create**(User $user) : *bool*
- **update**(User $user, ProductVariant $variant) : *bool*
- **delete**(User $user, ProductVariant $variant) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\User;
use App\Models\ProductVariant;

class ProductVariantPolicy
{
    private function isRole(User $user, array $roles): bool
    {
        // Spatie: return $user->hasAnyRole($roles);
        return in_array($user->role ?? '', $roles, true);
    }

    public function viewAny(User $user): bool
    {
        return $this->isRole($user, ['superadmin', 'admin_cabang', 'gudang', 'kasir', 'sales']);
    }

    public function view(User $user, ProductVariant $variant): bool
    {
        return $this->viewAny($user);
    }

    public function create(User $user): bool
    {
        return $this->isRole($user, ['superadmin', 'admin_cabang']);
    }

    public function update(User $user, ProductVariant $variant): bool
    {
        return $this->isRole($user, ['superadmin', 'admin_cabang']);
    }

    public function delete(User $user, ProductVariant $variant): bool
    {
        return $this->isRole($user, ['superadmin', 'admin_cabang']);
    }
}

```
</details>

### app/Policies/SettingPolicy.php

- SHA: `d775816c81ae`  
- Ukuran: 2 KB  
- Namespace: `App\Policies`

**Class `SettingPolicy`**

Metode Publik:
- **viewAny**(User $user) : *bool*
- **view**(User $user, Setting $setting) : *bool*
- **create**(User $user) : *bool*
- **update**(User $user, Setting $setting) : *bool*
- **delete**(User $user, Setting $setting) : *bool*
- **export**(User $user) : *bool*
- **import**(User $user) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\User;
use App\Models\Setting;

class SettingPolicy
{
    // Settings visible to superadmin & admin_cabang
    public function viewAny(User $user): bool
    {
        return $user->hasAnyRole(['superadmin', 'admin_cabang']);
    }

    public function view(User $user, Setting $setting): bool
    {
        if ($user->hasRole('superadmin')) {
            return true;
        }

        if ($user->hasRole('admin_cabang')) {
            // Jika kamu ingin admin_cabang bisa lihat GLOBAL juga, set true untuk GLOBAL
            if ($setting->scope === 'GLOBAL') {
                return true;
            }
            // Batasi item BRANCH ke cabang miliknya
            return $setting->scope === 'BRANCH'
                && (int) $setting->scope_id === (int) ($user->cabang_id ?? 0);
        }

        return false;
    }

    public function create(User $user): bool
    {
        return $user->hasAnyRole(['superadmin', 'admin_cabang']);
    }

    public function update(User $user, Setting $setting): bool
    {
        if ($user->hasRole('superadmin')) {
            return true;
        }

        if ($user->hasRole('admin_cabang')) {
            // Admin cabang hanya boleh ubah setting BRANCH miliknya
            return $setting->scope === 'BRANCH'
                && (int) $setting->scope_id === (int) ($user->cabang_id ?? 0);
        }

        return false;
    }

    public function delete(User $user, Setting $setting): bool
    {
        // Lebih ketat: hapus hanya superadmin
        return $user->hasRole('superadmin');
    }

    // Custom ops
    public function export(User $user): bool
    {
        return $this->viewAny($user);
    }

    public function import(User $user): bool
    {
        return $this->create($user);
    }
}

```
</details>

### app/Policies/UserPolicy.php

- SHA: `9d0c34681b83`  
- Ukuran: 2 KB  
- Namespace: `App\Policies`

**Class `UserPolicy`**

Metode Publik:
- **viewAny**(User $actor) : *bool*
- **view**(User $actor, User $target) : *bool*
- **create**(User $actor) : *bool*
- **update**(User $actor, User $target) : *bool*
- **delete**(User $actor, User $target) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

// app/Policies/UserPolicy.php
namespace App\Policies;

use App\Models\User;

class UserPolicy
{
    // superadmin = all; admin_cabang = same cabang (non-superadmin)
    public function viewAny(User $actor): bool
    {
        // sebelumnya hanya superadmin & admin_cabang
        // tambahkan kasir, karena kasir di FE boleh assign kurir
        return in_array($actor->role, ['superadmin', 'admin_cabang', 'kasir', 'gudang'], true);
    }

    public function view(User $actor, User $target): bool
    {
        if ($actor->role === 'superadmin')
            return true;
        if ($actor->role === 'admin_cabang') {
            return $actor->cabang_id && $actor->cabang_id === $target->cabang_id && $target->role !== 'superadmin';
        }
        // user biasa bisa lihat dirinya sendiri
        return $actor->id === $target->id;
    }

    public function create(User $actor): bool
    {
        return in_array($actor->role, ['superadmin', 'admin_cabang']);
    }

    public function update(User $actor, User $target): bool
    {
        if ($actor->role === 'superadmin')
            return true;
        if ($actor->role === 'admin_cabang') {
            return $actor->cabang_id && $actor->cabang_id === $target->cabang_id && $target->role !== 'superadmin';
        }
        // role selain dua di atas hanya boleh update dirinya sendiri (profil)
        return $actor->id === $target->id;
    }

    public function delete(User $actor, User $target): bool
    {
        if ($actor->id === $target->id)
            return false; // tidak boleh hapus diri sendiri
        if ($actor->role === 'superadmin')
            return true;
        if ($actor->role === 'admin_cabang') {
            return $actor->cabang_id && $actor->cabang_id === $target->cabang_id && $target->role !== 'superadmin';
        }
        return false;
    }

    // Tidak pakai restore/forceDelete khusus (hard delete only). Tambahkan jika perlu.
}

```
</details>

### app/Policies/VariantStockPolicy.php

- SHA: `09f523174cee`  
- Ukuran: 2 KB  
- Namespace: `App\Policies`

**Class `VariantStockPolicy`**

Metode Publik:
- **viewAny**(User $user) : *bool*
- **view**(User $user, VariantStock $stock) : *bool*
- **create**(User $user) : *bool*
- **update**(User $user, VariantStock $stock) : *bool*
- **adjust**(User $user, VariantStock $stock) : *bool*
- **delete**(User $user, VariantStock $stock) : *bool*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Policies;

use App\Models\User;
use App\Models\VariantStock;

class VariantStockPolicy
{
    // Role helper
    protected function canManage(User $user): bool
    {
        return in_array($user->role, ['superadmin','admin_cabang','gudang'], true);
    }

    public function viewAny(User $user): bool
    {
        // Lihat stok per cabang/gudang
        return $this->canManage($user);
    }

    public function view(User $user, VariantStock $stock): bool
    {
        if (!$this->canManage($user)) return false;
        // Admin Cabang/Gudang hanya cabangnya
        if ($user->role === 'superadmin') return true;
        return (int)$user->cabang_id === (int)$stock->cabang_id;
    }

    public function create(User $user): bool
    {
        // Set stok awal
        return $this->canManage($user);
    }

    public function update(User $user, VariantStock $stock): bool
    {
        if (!$this->canManage($user)) return false;
        if ($user->role === 'superadmin') return true;
        return (int)$user->cabang_id === (int)$stock->cabang_id;
    }

    public function adjust(User $user, VariantStock $stock): bool
    {
        // Penyesuaian manual (tambah/kurang)
        return $this->update($user, $stock);
    }

    public function delete(User $user, VariantStock $stock): bool
    {
        // Hard delete only (sesuai SOP)
        if (!$this->canManage($user)) return false;
        if ($user->role === 'superadmin') return true;
        return (int)$user->cabang_id === (int)$stock->cabang_id;
    }
}

```
</details>



## Form Requests (app/Http/Requests)

### app/Http/Requests/AccountStoreRequest.php

- SHA: `de14fc8b0fba`  
- Ukuran: 698 B  
- Namespace: `App\Http\Requests`

**Class `AccountStoreRequest` extends `FormRequest`**

Metode Publik:
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class AccountStoreRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'cabang_id'      => ['nullable', 'integer', 'exists:cabangs,id'],
            'code'           => ['required', 'string', 'max:32'],
            'name'           => ['required', 'string', 'max:160'],
            'type'           => ['required', 'in:Asset,Liability,Equity,Revenue,Expense'],
            'normal_balance' => ['required', 'in:DEBIT,CREDIT'],
            'parent_id'      => ['nullable', 'integer', 'exists:accounts,id'],
            'is_active'      => ['boolean'],
        ];
    }
}

```
</details>

### app/Http/Requests/AccountUpdateRequest.php

- SHA: `ed5a9f466298`  
- Ukuran: 558 B  
- Namespace: `App\Http\Requests`

**Class `AccountUpdateRequest` extends `FormRequest`**

Metode Publik:
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class AccountUpdateRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'name'           => ['sometimes', 'string', 'max:160'],
            'type'           => ['sometimes', 'in:Asset,Liability,Equity,Revenue,Expense'],
            'normal_balance' => ['sometimes', 'in:DEBIT,CREDIT'],
            'parent_id'      => ['nullable', 'integer', 'exists:accounts,id'],
            'is_active'      => ['boolean'],
        ];
    }
}

```
</details>

### app/Http/Requests/Auth/LoginRequest.php

- SHA: `8dd59b857462`  
- Ukuran: 2 KB  
- Namespace: `App\Http\Requests\Auth`

**Class `LoginRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool* — Determine if the user is authorized to make this request.
- **rules**() : *array* — Determine if the user is authorized to make this request.
- **authenticate**() : *void* — Determine if the user is authorized to make this request.
- **ensureIsNotRateLimited**() : *void* — Determine if the user is authorized to make this request.
- **throttleKey**() : *string* — Determine if the user is authorized to make this request.
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests\Auth;

use Illuminate\Auth\Events\Lockout;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class LoginRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'email' => ['required', 'string', 'email'],
            'password' => ['required', 'string'],
        ];
    }

    /**
     * Attempt to authenticate the request's credentials.
     *
     * @throws \Illuminate\Validation\ValidationException
     */
    public function authenticate(): void
    {
        $this->ensureIsNotRateLimited();

        if (! Auth::attempt($this->only('email', 'password'), $this->boolean('remember'))) {
            RateLimiter::hit($this->throttleKey());

            throw ValidationException::withMessages([
                'email' => __('auth.failed'),
            ]);
        }

        RateLimiter::clear($this->throttleKey());
    }

    /**
     * Ensure the login request is not rate limited.
     *
     * @throws \Illuminate\Validation\ValidationException
     */
    public function ensureIsNotRateLimited(): void
    {
        if (! RateLimiter::tooManyAttempts($this->throttleKey(), 5)) {
            return;
        }

        event(new Lockout($this));

        $seconds = RateLimiter::availableIn($this->throttleKey());

        throw ValidationException::withMessages([
            'email' => trans('auth.throttle', [
                'seconds' => $seconds,
                'minutes' => ceil($seconds / 60),
            ]),
        ]);
    }

    /**
     * Get the rate limiting throttle key for the request.
     */
    public function throttleKey(): string
    {
        return Str::transliterate(Str::lower($this->input('email')).'|'.$this->ip());
    }
}

```
</details>

### app/Http/Requests/AuthLoginRequest.php

- SHA: `f9b412bb9a18`  
- Ukuran: 444 B  
- Namespace: `App\Http\Requests`

**Class `AuthLoginRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

// app/Http/Requests/AuthLoginRequest.php
namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class AuthLoginRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }
    public function rules(): array
    {
        return [
            'email' => ['required', 'email', 'max:190'],
            'password' => ['required', 'string', 'min:6', 'max:190'],
        ];
    }
}

```
</details>

### app/Http/Requests/CabangStoreRequest.php

- SHA: `0b1312f42401`  
- Ukuran: 750 B  
- Namespace: `App\Http\Requests`

**Class `CabangStoreRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CabangStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        // hanya superadmin (handled by policy via controller) -> return true lalu controller->authorize('create', Cabang::class)
        return true;
    }

    public function rules(): array
    {
        return [
            'nama' => ['required','string','max:120'],
            'kota' => ['nullable','string','max:120'],
            'alamat' => ['nullable','string','max:255'],
            'telepon' => ['nullable','string','max:30'],
            'jam_operasional' => ['nullable','string','max:120'],
            'is_active' => ['sometimes','boolean'],
        ];
    }
}

```
</details>

### app/Http/Requests/CabangUpdateRequest.php

- SHA: `a7b3b80a7d31`  
- Ukuran: 670 B  
- Namespace: `App\Http\Requests`

**Class `CabangUpdateRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CabangUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'nama' => ['sometimes','string','max:120'],
            'kota' => ['sometimes','nullable','string','max:120'],
            'alamat' => ['sometimes','nullable','string','max:255'],
            'telepon' => ['sometimes','nullable','string','max:30'],
            'jam_operasional' => ['sometimes','nullable','string','max:120'],
            'is_active' => ['sometimes','boolean'],
        ];
    }
}

```
</details>

### app/Http/Requests/CashHolderStoreRequest.php

- SHA: `aa87782a9fd6`  
- Ukuran: 551 B  
- Namespace: `App\Http\Requests`

**Class `CashHolderStoreRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CashHolderStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->can('create', \App\Models\CashHolder::class);
    }

    public function rules(): array
    {
        return [
            'cabang_id'       => ['required', 'integer', 'exists:cabangs,id'],
            'name'            => ['required', 'string', 'max:120'],
            'opening_balance' => ['nullable', 'numeric', 'min:0'],
        ];
    }
}

```
</details>

### app/Http/Requests/CashMoveApproveRequest.php

- SHA: `42bfb15d0027`  
- Ukuran: 356 B  
- Namespace: `App\Http\Requests`

**Class `CashMoveApproveRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CashMoveApproveRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->can('approve', $this->route('move'));
    }
    public function rules(): array
    {
        return ['approved_at' => ['nullable', 'date']];
    }
}

```
</details>

### app/Http/Requests/CashMoveRejectRequest.php

- SHA: `59e23502f85f`  
- Ukuran: 363 B  
- Namespace: `App\Http\Requests`

**Class `CashMoveRejectRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CashMoveRejectRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->can('reject', $this->route('move'));
    }
    public function rules(): array
    {
        return ['reason' => ['required', 'string', 'max:1000']];
    }
}

```
</details>

### app/Http/Requests/CashMoveStoreRequest.php

- SHA: `fb64f695aa7f`  
- Ukuran: 768 B  
- Namespace: `App\Http\Requests`

**Class `CashMoveStoreRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CashMoveStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->can('create', \App\Models\CashMove::class);
    }
    public function rules(): array
    {
        return [
            'from_holder_id' => ['required', 'integer', 'exists:cash_holders,id'],
            'to_holder_id'   => ['required', 'integer', 'different:from_holder_id', 'exists:cash_holders,id'],
            'amount'         => ['required', 'numeric', 'gt:0'],
            'note'           => ['nullable', 'string'],
            'moved_at'       => ['required', 'date'],
            'idempotency_key' => ['nullable', 'string', 'max:64'],
        ];
    }
}

```
</details>

### app/Http/Requests/Category/IndexCategoryRequest.php

- SHA: `8b80e1b7aecb`  
- Ukuran: 925 B  
- Namespace: `App\Http\Requests\Category`

**Class `IndexCategoryRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
- **perPage**() : *int*
- **sort**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests\Category;

use Illuminate\Foundation\Http\FormRequest;

class IndexCategoryRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->can('viewAny', \App\Models\Category::class);
    }

    public function rules(): array
    {
        return [
            'q'        => ['nullable', 'string', 'max:120'],
            'is_active'=> ['nullable', 'in:0,1'],
            'per_page' => ['nullable', 'integer', 'min:5', 'max:100'],
            'sort'     => ['nullable', 'in:nama,-nama,created_at,-created_at'],
        ];
    }

    public function perPage(): int
    {
        return (int) ($this->input('per_page', 10));
    }

    public function sort(): array
    {
        $sort = $this->input('sort', 'nama');
        $dir  = str_starts_with($sort, '-') ? 'desc' : 'asc';
        $col  = ltrim($sort, '-');
        return [$col, $dir];
    }
}

```
</details>

### app/Http/Requests/Category/StoreCategoryRequest.php

- SHA: `3563c9a558ee`  
- Ukuran: 1019 B  
- Namespace: `App\Http\Requests\Category`

**Class `StoreCategoryRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
- **payload**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests\Category;

use Illuminate\Foundation\Http\FormRequest;

class StoreCategoryRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->can('create', \App\Models\Category::class);
    }

    public function rules(): array
    {
        return [
            'nama'       => ['required', 'string', 'max:120'],
            'deskripsi'  => ['nullable', 'string'],
            'is_active'  => ['nullable', 'boolean'],
            // slug tidak diwajibkan di input; akan dihasilkan otomatis oleh Service
            'slug'       => ['nullable', 'string', 'max:140', 'unique:categories,slug'],
        ];
    }

    public function payload(): array
    {
        return [
            'nama'      => $this->input('nama'),
            'deskripsi' => $this->input('deskripsi'),
            'is_active' => $this->boolean('is_active', true),
            'slug'      => $this->input('slug'), // optional; kalau kosong akan di-generate
        ];
    }
}

```
</details>

### app/Http/Requests/Category/UpdateCategoryRequest.php

- SHA: `ad9a116665d9`  
- Ukuran: 1 KB  
- Namespace: `App\Http\Requests\Category`

**Class `UpdateCategoryRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
- **payload**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests\Category;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateCategoryRequest extends FormRequest
{
    public function authorize(): bool
    {
        $category = $this->route('category'); // pastikan route model binding dipakai nantinya
        return $this->user()->can('update', $category);
    }

    public function rules(): array
    {
        $categoryId = $this->route('category')?->id;

        return [
            'nama'       => ['required', 'string', 'max:120'],
            'deskripsi'  => ['nullable', 'string'],
            'is_active'  => ['nullable', 'boolean'],
            'slug'       => [
                'nullable',
                'string',
                'max:140',
                Rule::unique('categories', 'slug')->ignore($categoryId),
            ],
        ];
    }

    public function payload(): array
    {
        return [
            'nama'      => $this->input('nama'),
            'deskripsi' => $this->input('deskripsi'),
            'is_active' => $this->boolean('is_active', true),
            'slug'      => $this->input('slug'), // optional; jika kosong, service bisa regenerate dari nama (opsional)
        ];
    }
}

```
</details>

### app/Http/Requests/Customer/CustomerStoreRequest.php

- SHA: `a5e2385e8d2b`  
- Ukuran: 1022 B  
- Namespace: `App\Http\Requests\Customer`

**Class `CustomerStoreRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
- **prepareForValidation**() : *void*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests\Customer;

use Illuminate\Foundation\Http\FormRequest;

class CustomerStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->can('create', \App\Models\Customer::class);
    }

    public function rules(): array
    {
        $cabangId = (int)($this->user()->cabang_id);

        return [
            'nama'   => ['required', 'string', 'max:120'],
            'phone'  => ['required', 'string', 'max:30', "unique:customers,phone,NULL,id,cabang_id,{$cabangId}"],
            'email'  => ['nullable', 'email', 'max:190'],
            'alamat' => ['nullable', 'string', 'max:255'],
            'catatan' => ['nullable', 'string', 'max:255'],
            'stage'  => ['nullable', 'in:LEAD,ACTIVE,CHURN'],
        ];
    }

    public function prepareForValidation(): void
    {
        $user = $this->user();
        if ($user->hasRole(['kasir', 'sales'])) {
            $this->merge(['cabang_id' => $user->cabang_id]);
        }
    }
}

```
</details>

### app/Http/Requests/Customer/CustomerUpdateRequest.php

- SHA: `74fbdc04ecd6`  
- Ukuran: 894 B  
- Namespace: `App\Http\Requests\Customer`

**Class `CustomerUpdateRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests\Customer;

use Illuminate\Foundation\Http\FormRequest;

class CustomerUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        $customer = $this->route('customer');
        return $this->user()->can('update', $customer);
    }

    public function rules(): array
    {
        $customer = $this->route('customer');
        $cabangId = (int)($this->user()->cabang_id);

        return [
            'nama'   => ['required', 'string', 'max:120'],
            'phone'  => ['required', 'string', 'max:30', "unique:customers,phone,{$customer->id},id,cabang_id,{$cabangId}"],
            'email'  => ['nullable', 'email', 'max:190'],
            'alamat' => ['nullable', 'string', 'max:255'],
            'catatan' => ['nullable', 'string', 'max:255'],
            'stage'  => ['nullable', 'in:LEAD,ACTIVE,CHURN'],
        ];
    }
}

```
</details>

### app/Http/Requests/Dashboard/CommonQuery.php

- SHA: `4950510dcdb3`  
- Ukuran: 1 KB  
- Namespace: `App\Http\Requests\Dashboard`

**Class `CommonQuery` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
- **branchIdOrUser**() : *?int*
- **dateRange**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests\Dashboard;

use Illuminate\Foundation\Http\FormRequest;

class CommonQuery extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'branch_id' => ['nullable', 'integer'], // accepted input name
            'from' => ['nullable', 'date'],
            'to' => ['nullable', 'date', 'after_or_equal:from'],
            'limit' => ['nullable', 'integer', 'between:1,50'],
            'threshold' => ['nullable', 'numeric', 'min:0'],
        ];
    }

    public function branchIdOrUser(): ?int
    {
        // prioritaskan cabang_id (frontend baru), fallback branch_id (legacy), lalu cabang user
        $fromInput = $this->integer('cabang_id') ?: $this->integer('branch_id');
        if ($fromInput) return (int) $fromInput;

        return $this->user()->cabang_id ? (int) $this->user()->cabang_id : null;
    }

    public function dateRange(): array
    {
        $from = $this->input('from');
        $to   = $this->input('to');
        return [
            $from ? now()->parse($from)->startOfDay() : now()->startOfDay(),
            $to ? now()->parse($to)->endOfDay() : now()->endOfDay()
        ];
    }
}

```
</details>

### app/Http/Requests/Deliveries/SendDeliveryNoteRequest.php

- SHA: `c0b9b7a5ce73`  
- Ukuran: 643 B  
- Namespace: `App\Http\Requests\Deliveries`

**Class `SendDeliveryNoteRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests\Deliveries;

use Illuminate\Foundation\Http\FormRequest;

class SendDeliveryNoteRequest extends FormRequest
{
    public function authorize(): bool
    {
        // Otorisasi pakai policy di controller (sendSuratJalan)
        return true;
    }

    protected function prepareForValidation(): void
    {
        if ($this->has('message')) {
            $this->merge([
                'message' => trim((string)$this->input('message')),
            ]);
        }
    }

    public function rules(): array
    {
        return [
            'message' => ['nullable', 'string', 'max:3000'],
        ];
    }
}

```
</details>

### app/Http/Requests/DeliveryAssignRequest.php

- SHA: `83d29e85fecc`  
- Ukuran: 2 KB  
- Namespace: `App\Http\Requests`

**Class `DeliveryAssignRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
- **messages**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use App\Models\Delivery;
use App\Models\User;

class DeliveryAssignRequest extends FormRequest
{
    public function authorize(): bool
    {
        // Controller sudah panggil $this->authorize('assign', $delivery)
        // jadi di sini boleh true.
        return true;
    }

    protected function prepareForValidation(): void
    {
        // Normalisasi input agar rules boolean/integer konsisten
        $auto = $this->input('auto', false);
        $assigned = $this->input('assigned_to', null);

        $this->merge([
            'auto' => filter_var($auto, FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE) ?? false,
            'assigned_to' => $assigned !== null && $assigned !== '' ? (int) $assigned : null,
        ]);
    }

    public function rules(): array
    {
        // Ambil delivery dari route param (deliveries/{id}/assign)
        $deliveryId = (int) $this->route('id');
        $delivery = Delivery::with('order:id,cabang_id')->find($deliveryId);

        return [
            'auto' => ['sometimes', 'boolean'],
            'assigned_to' => [
                // Wajib isi salah satu: assigned_to ATAU auto
                'nullable',
                'integer',
                'required_without:auto',
                // opsional: kalau kamu ingin memaksa user TIDAK mengisi keduanya bersamaan:
                // 'prohibited_if:auto,true',
                'exists:users,id',
                function (string $attr, $value, \Closure $fail) use ($delivery) {
                    if ($value === null) return;

                    $user = User::query()->select(['id', 'role', 'cabang_id'])->find($value);
                    if (!$user) return;

                    if ($user->role !== 'kurir') {
                        $fail('User yang dipilih bukan kurir.');
                        return;
                    }
                    if ($delivery && $delivery->order && $user->cabang_id !== $delivery->order->cabang_id) {
                        $fail('Kurir harus dari cabang yang sama dengan order.');
                    }
                },
            ],
        ];
    }

    public function messages(): array
    {
        return [
            'assigned_to.required_without' => 'Pilih kurir atau aktifkan auto-assign.',
            'assigned_to.exists' => 'Kurir tidak ditemukan.',
        ];
    }
}

```
</details>

### app/Http/Requests/DeliveryEventStoreRequest.php

- SHA: `cef0827298a4`  
- Ukuran: 586 B  
- Namespace: `App\Http\Requests`

**Class `DeliveryEventStoreRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class DeliveryEventStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'status' => ['required', Rule::in(['REQUESTED', 'ASSIGNED', 'PICKED_UP', 'ON_ROUTE', 'DELIVERED', 'FAILED', 'CANCELLED'])],
            'note'   => ['nullable', 'string'],
            'photo'  => ['nullable', 'file', 'mimes:jpg,jpeg,png,webp', 'max:4096'],
        ];
    }
}

```
</details>

### app/Http/Requests/DeliveryStatusRequest.php

- SHA: `a8c324081f97`  
- Ukuran: 497 B  
- Namespace: `App\Http\Requests`

**Class `DeliveryStatusRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class DeliveryStatusRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'status' => ['required', Rule::in(['REQUESTED', 'ASSIGNED', 'PICKED_UP', 'ON_ROUTE', 'DELIVERED', 'FAILED', 'CANCELLED'])],
            'note'   => ['nullable', 'string'],
        ];
    }
}

```
</details>

### app/Http/Requests/DeliveryStoreRequest.php

- SHA: `87135ba5203b`  
- Ukuran: 889 B  
- Namespace: `App\Http\Requests`

**Class `DeliveryStoreRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class DeliveryStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'order_id' => ['required', 'integer', 'exists:orders,id'],
            'type' => ['required', Rule::in(['PICKUP', 'DELIVERY', 'BOTH'])],
            'pickup_address' => ['nullable', 'string', 'max:255'],
            'delivery_address' => ['nullable', 'string', 'max:255'],
            'pickup_lat' => ['nullable', 'numeric', 'between:-90,90'],
            'pickup_lng' => ['nullable', 'numeric', 'between:-180,180'],
            'delivery_lat' => ['nullable', 'numeric', 'between:-90,90'],
            'delivery_lng' => ['nullable', 'numeric', 'between:-180,180'],
        ];
    }
}

```
</details>

### app/Http/Requests/ExportRequest.php

- SHA: `a7c743c17512`  
- Ukuran: 507 B  
- Namespace: `App\Http\Requests`

**Class `ExportRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ExportRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }
    public function rules(): array
    {
        return [
            'scope' => 'nullable|in:GLOBAL,BRANCH,USER',
            'scope_id' => 'nullable|integer|min:1',
            'keys' => 'nullable|array',
            'keys.*' => 'string|max:150',
            'format' => 'nullable|in:json',
        ];
    }
}

```
</details>

### app/Http/Requests/FeeEntryIndexRequest.php

- SHA: `a05997704904`  
- Ukuran: 597 B  
- Namespace: `App\Http\Requests`

**Class `FeeEntryIndexRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class FeeEntryIndexRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'cabang_id'  => ['nullable', 'integer'],
            'from'       => ['nullable', 'date'],
            'to'         => ['nullable', 'date', 'after_or_equal:from'],
            'pay_status' => ['nullable', 'in:UNPAID,PAID,PARTIAL'],
            'per_page'   => ['nullable', 'integer', 'min:1', 'max:200'],
        ];
    }
}

```
</details>

### app/Http/Requests/FeeEntryPayRequest.php

- SHA: `617f41cf8cb9`  
- Ukuran: 566 B  
- Namespace: `App\Http\Requests`

**Class `FeeEntryPayRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class FeeEntryPayRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'entry_ids'  => ['required', 'array', 'min:1'],
            'entry_ids.*' => ['integer', 'distinct'],
            'status'     => ['required', 'in:PAID,PARTIAL'],
            'paid_amount' => ['nullable', 'numeric', 'min:0'],
            'paid_at'    => ['nullable', 'date'],
        ];
    }
}

```
</details>

### app/Http/Requests/FeeStoreRequest.php

- SHA: `10225400db31`  
- Ukuran: 1 KB  
- Namespace: `App\Http\Requests`

**Class `FeeStoreRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
- **withValidator**($v)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class FeeStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->can('create', \App\Models\Fee::class);
    }

    public function rules(): array
    {
        return [
            'cabang_id' => ['required', 'integer', 'exists:cabangs,id'],
            'name'      => ['required', 'string', 'max:100'],
            'kind'      => ['required', 'in:SALES,CASHIER,COURIER'],
            'calc_type' => ['required', 'in:PERCENT,FIXED'],
            'rate'      => ['required', 'numeric', 'min:0'],
            'base'      => ['required', 'in:GRAND_TOTAL,DELIVERY'],
            'is_active' => ['required', 'boolean'],
        ];
    }

    public function withValidator($v)
    {
        $v->after(function ($v) {
            $calc = $this->input('calc_type');
            $rate = (float) $this->input('rate', 0);
            if ($calc === 'PERCENT' && $rate > 100) {
                $v->errors()->add('rate', 'Rate persentase tidak boleh lebih dari 100.');
            }
        });
    }
}

```
</details>

### app/Http/Requests/FeeUpdateRequest.php

- SHA: `4b680afb7217`  
- Ukuran: 1 KB  
- Namespace: `App\Http\Requests`

**Class `FeeUpdateRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
- **withValidator**($v)
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class FeeUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        $fee = $this->route('fee'); // model binding
        return $this->user()->can('update', $fee);
    }

    public function rules(): array
    {
        return [
            'cabang_id' => ['sometimes', 'integer', 'exists:cabangs,id'],
            'name'      => ['sometimes', 'string', 'max:100'],
            'kind'      => ['sometimes', 'in:SALES,CASHIER,COURIER'],
            'calc_type' => ['sometimes', 'in:PERCENT,FIXED'],
            'rate'      => ['sometimes', 'numeric', 'min:0'],
            'base'      => ['sometimes', 'in:GRAND_TOTAL,DELIVERY'],
            'is_active' => ['sometimes', 'boolean'],
        ];
    }

    public function withValidator($v)
    {
        $v->after(function ($v) {
            $calc = $this->input('calc_type');
            if ($calc === 'PERCENT' && $this->has('rate')) {
                $rate = (float) $this->input('rate', 0);
                if ($rate > 100) {
                    $v->errors()->add('rate', 'Rate persentase tidak boleh lebih dari 100.');
                }
            }
        });
    }
}

```
</details>

### app/Http/Requests/GudangStoreRequest.php

- SHA: `99b93ae92e81`  
- Ukuran: 509 B  
- Namespace: `App\Http\Requests`

**Class `GudangStoreRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class GudangStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'cabang_id' => ['required','integer','exists:cabangs,id'],
            'nama' => ['required','string','max:120'],
            'is_default' => ['sometimes','boolean'],
            'is_active' => ['sometimes','boolean'],
        ];
    }
}

```
</details>

### app/Http/Requests/GudangUpdateRequest.php

- SHA: `ae5b8e923395`  
- Ukuran: 440 B  
- Namespace: `App\Http\Requests`

**Class `GudangUpdateRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class GudangUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'nama' => ['sometimes','string','max:120'],
            'is_default' => ['sometimes','boolean'],
            'is_active' => ['sometimes','boolean'],
        ];
    }
}

```
</details>

### app/Http/Requests/ImportRequest.php

- SHA: `891f8b458641`  
- Ukuran: 375 B  
- Namespace: `App\Http\Requests`

**Class `ImportRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ImportRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }
    public function rules(): array
    {
        return [
            'items' => 'required|array|min:1',
            'mode' => 'nullable|in:replace,merge,skip',
        ];
    }
}

```
</details>

### app/Http/Requests/JournalPostRequest.php

- SHA: `c0959977cc5f`  
- Ukuran: 273 B  
- Namespace: `App\Http\Requests`

**Class `JournalPostRequest` extends `FormRequest`**

Metode Publik:
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class JournalPostRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'idempotency_key' => ['nullable', 'string', 'max:64'],
        ];
    }
}

```
</details>

### app/Http/Requests/JournalStoreRequest.php

- SHA: `af564cab2276`  
- Ukuran: 930 B  
- Namespace: `App\Http\Requests`

**Class `JournalStoreRequest` extends `FormRequest`**

Metode Publik:
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class JournalStoreRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'cabang_id'     => ['required', 'integer', 'exists:cabangs,id'],
            'journal_date'  => ['required', 'date'],
            'number'        => ['required', 'string', 'max:40'],
            'description'   => ['nullable', 'string', 'max:255'],
            'lines'         => ['required', 'array', 'min:2'],
            'lines.*.account_id' => ['required', 'integer', 'exists:accounts,id'],
            'lines.*.debit'      => ['required_without:lines.*.credit', 'numeric', 'min:0'],
            'lines.*.credit'     => ['required_without:lines.*.debit', 'numeric', 'min:0'],
            'lines.*.ref_type'   => ['nullable', 'string', 'max:50'],
            'lines.*.ref_id'     => ['nullable', 'integer'],
        ];
    }
}

```
</details>

### app/Http/Requests/JournalUpdateRequest.php

- SHA: `324910053707`  
- Ukuran: 233 B  
- Namespace: `App\Http\Requests`

**Class `JournalUpdateRequest` extends `FormRequest`**

Metode Publik:
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class JournalUpdateRequest extends FormRequest
{
    public function rules(): array
    {
        return (new JournalStoreRequest())->rules();
    }
}

```
</details>

### app/Http/Requests/OrderCancelRequest.php

- SHA: `b72ae9672f08`  
- Ukuran: 319 B  
- Namespace: `App\Http\Requests`

**Class `OrderCancelRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class OrderCancelRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        return [
            'reason' => ['required','string','max:500'],
        ];
    }
}

```
</details>

### app/Http/Requests/OrderSetCashPositionRequest.php

- SHA: `6f048b12c47c`  
- Ukuran: 557 B  
- Namespace: `App\Http\Requests`

**Class `OrderSetCashPositionRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array* — @var \App\Models\Order|null $order
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class OrderSetCashPositionRequest extends FormRequest
{
    public function authorize(): bool
    {
        /** @var \App\Models\Order|null $order */
        $order = $this->route('order'); // pastikan nama param route = 'order'
        return $this->user()?->can('setCashPosition', $order) ?? false;
    }

    public function rules(): array
    {
        return [
            'cash_position' => ['required', 'string', 'in:CUSTOMER,CASHIER,SALES,ADMIN'],
        ];
    }
}

```
</details>

### app/Http/Requests/OrderStoreRequest.php

- SHA: `2858b60e2d4d`  
- Ukuran: 1 KB  
- Namespace: `App\Http\Requests`

**Class `OrderStoreRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class OrderStoreRequest extends FormRequest
{
    public function authorize(): bool { return true; } // pakai Policy di Controller

    public function rules(): array
    {
        return [
            'cabang_id' => ['required','integer'],
            'gudang_id' => ['required','integer'],
            'customer_id' => ['nullable','integer'],
            'note' => ['nullable','string','max:2000'],
            'ordered_at' => ['nullable','date'],

            'items' => ['required','array','min:1'],
            'items.*.variant_id' => ['required','integer','min:1'],
            'items.*.qty' => ['required','numeric','gt:0'],
            'items.*.discount' => ['nullable','numeric','min:0'],
            // input hint (opsional) dari client, tidak dipakai sebagai kebenaran
            'items.*.price_hint' => ['nullable','numeric','min:0'],

            // optional immediate payment saat checkout
            'cash_position' => ['nullable','string','in:CUSTOMER,CASHIER,SALES,ADMIN'],
            'payment' => ['nullable','array'],
            'payment.method' => ['required_with:payment','in:CASH,TRANSFER,QRIS,XENDIT'],
            'payment.amount' => ['required_with:payment','numeric','gt:0'],
        ];
    }
}

```
</details>

### app/Http/Requests/OrderUpdateRequest.php

- SHA: `7450f2bb4085`  
- Ukuran: 793 B  
- Namespace: `App\Http\Requests`

**Class `OrderUpdateRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class OrderUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'note' => ['nullable', 'string', 'max:2000'],
            'items' => ['required', 'array', 'min:1'],
            'items.*.id' => ['nullable', 'integer'],
            'items.*.variant_id' => ['required', 'integer', 'min:1'],
            'items.*.qty' => ['required', 'numeric', 'gt:0'],
            'items.*.discount' => ['nullable', 'numeric', 'min:0'],
            'items.*._delete' => ['sometimes', 'boolean'],
            'cash_position' => ['nullable', 'string', 'in:CUSTOMER,CASHIER,SALES,ADMIN'],
        ];
    }
}

```
</details>

### app/Http/Requests/Orders/IndexOrdersRequest.php

- SHA: `2e8a3f937be1`  
- Ukuran: 754 B  
- Namespace: `App\Http\Requests\Orders`

**Class `IndexOrdersRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests\Orders;

use Illuminate\Foundation\Http\FormRequest;

class IndexOrdersRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'cabang_id' => ['nullable', 'integer'],
            'status'    => ['nullable', 'in:DRAFT,UNPAID,PAID,VOID,REFUND'],
            'date_from' => ['nullable', 'date'],
            'date_to'   => ['nullable', 'date', 'after_or_equal:date_from'],
            'search'    => ['nullable', 'string', 'max:120'], // kode/phone/note
            'page'      => ['nullable', 'integer', 'min:1'],
            'per_page'  => ['nullable', 'integer', 'min:5', 'max:100'],
        ];
    }
}

```
</details>

### app/Http/Requests/Orders/ReprintReceiptRequest.php

- SHA: `3f23f1054a70`  
- Ukuran: 338 B  
- Namespace: `App\Http\Requests\Orders`

**Class `ReprintReceiptRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests\Orders;

use Illuminate\Foundation\Http\FormRequest;

class ReprintReceiptRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'format' => ['nullable', 'in:58,80'],
        ];
    }
}

```
</details>

### app/Http/Requests/Orders/ResendWARequest.php

- SHA: `3dbffc66415e`  
- Ukuran: 402 B  
- Namespace: `App\Http\Requests\Orders`

**Class `ResendWARequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests\Orders;

use Illuminate\Foundation\Http\FormRequest;

class ResendWARequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'phone'   => ['required', 'string', 'max:30'],
            'message' => ['nullable', 'string', 'max:1000'],
        ];
    }
}

```
</details>

### app/Http/Requests/Orders/UpdateOrderItemsRequest.php

- SHA: `6c22b855256a`  
- Ukuran: 1 KB  
- Namespace: `App\Http\Requests\Orders`

**Class `UpdateOrderItemsRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
- **messages**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests\Orders;

use Illuminate\Foundation\Http\FormRequest;

class UpdateOrderItemsRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'items'              => ['required', 'array', 'min:1'],
            'items.*.id'         => ['nullable', 'integer'], // existing order_item id (null = new)
            'items.*.variant_id' => ['required_without:items.*.id', 'integer'],
            'items.*.name' => ['nullable', 'string', 'max:200', 'not_regex:/^\s*$/'],
            'items.*.price'      => ['required', 'numeric', 'min:0'],
            'items.*.discount'   => ['nullable', 'numeric', 'min:0'],
            'items.*.qty'        => ['required', 'numeric', 'gt:0'],
            'remove_item_ids'    => ['nullable', 'array'],
            'remove_item_ids.*'  => ['integer'],
            'note'               => ['nullable', 'string', 'max:500'],
        ];
    }

    public function messages(): array
    {
        return [
            'items.required' => 'Minimal satu item.',
            'items.*.price.min' => 'Harga tidak boleh negatif.',
            'items.*.qty.gt' => 'Qty harus lebih dari 0.',
        ];
    }
}

```
</details>

### app/Http/Requests/PaymentStoreRequest.php

- SHA: `7a252672ef21`  
- Ukuran: 496 B  
- Namespace: `App\Http\Requests`

**Class `PaymentStoreRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PaymentStoreRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        return [
            'method' => ['required','in:CASH,TRANSFER,QRIS,XENDIT'],
            'amount' => ['required','numeric','gt:0'],
            'ref_no' => ['nullable','string','max:191'],
            'payload_json' => ['nullable','array'],
        ];
    }
}

```
</details>

### app/Http/Requests/PeriodCloseRequest.php

- SHA: `2639f20d0833`  
- Ukuran: 426 B  
- Namespace: `App\Http\Requests`

**Class `PeriodCloseRequest` extends `FormRequest`**

Metode Publik:
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PeriodCloseRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'cabang_id' => ['required', 'integer', 'exists:cabangs,id'],
            'year'      => ['required', 'integer', 'min:2000', 'max:2100'],
            'month'     => ['required', 'integer', 'min:1', 'max:12'],
        ];
    }
}

```
</details>

### app/Http/Requests/ReorderProductMediaRequest.php

- SHA: `360f2c0043ba`  
- Ukuran: 584 B  
- Namespace: `App\Http\Requests`

**Class `ReorderProductMediaRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ReorderProductMediaRequest extends FormRequest
{
    public function authorize(): bool
    {
        $product = $this->route('product');
        return $this->user()?->can('update', $product) ?? false;
    }

    public function rules(): array
    {
        return [
            'orders' => ['required', 'array', 'min:1'],
            'orders.*.id' => ['required', 'exists:product_media,id'],
            'orders.*.sort_order' => ['required', 'integer', 'min:0', 'max:65535'],
        ];
    }
}

```
</details>

### app/Http/Requests/SetPrimaryProductMediaRequest.php

- SHA: `ba3d6b87ef03`  
- Ukuran: 444 B  
- Namespace: `App\Http\Requests`

**Class `SetPrimaryProductMediaRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class SetPrimaryProductMediaRequest extends FormRequest
{
    public function authorize(): bool
    {
        $product = $this->route('product');
        return $this->user()?->can('update', $product) ?? false;
    }

    public function rules(): array
    {
        return [
            'media_id' => ['required', 'exists:product_media,id'],
        ];
    }
}

```
</details>

### app/Http/Requests/SettingBulkUpsertRequest.php

- SHA: `2a212b874082`  
- Ukuran: 560 B  
- Namespace: `App\Http\Requests`

**Class `SettingBulkUpsertRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class SettingBulkUpsertRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }
    public function rules(): array
    {
        return [
            'items' => 'required|array|min:1',
            'items.*.scope' => 'required|in:GLOBAL,BRANCH,USER',
            'items.*.scope_id' => 'nullable|integer|min:1',
            'items.*.key' => 'required|string|max:150',
            'items.*.value' => 'required|array',
        ];
    }
}

```
</details>

### app/Http/Requests/SettingQueryRequest.php

- SHA: `3ea5bb2c9f19`  
- Ukuran: 469 B  
- Namespace: `App\Http\Requests`

**Class `SettingQueryRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class SettingQueryRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }
    public function rules(): array
    {
        return [
            'scope' => 'nullable|in:GLOBAL,BRANCH,USER',
            'scope_id' => 'nullable|integer|min:1',
            'keys' => 'nullable|array',
            'keys.*' => 'string|max:150',
        ];
    }
}

```
</details>

### app/Http/Requests/SettingUpsertRequest.php

- SHA: `d57a048c19e6`  
- Ukuran: 477 B  
- Namespace: `App\Http\Requests`

**Class `SettingUpsertRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class SettingUpsertRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }
    public function rules(): array
    {
        return [
            'scope' => 'required|in:GLOBAL,BRANCH,USER',
            'scope_id' => 'nullable|integer|min:1',
            'key' => 'required|string|max:150',
            'value' => 'required|array',
        ];
    }
}

```
</details>

### app/Http/Requests/StoreProductRequest.php

- SHA: `944ab7702051`  
- Ukuran: 1022 B  
- Namespace: `App\Http\Requests`

**Class `StoreProductRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreProductRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()?->can('create', \App\Models\Product::class) ?? false;
    }

    public function rules(): array
    {
        return [
            'category_id' => ['required', 'exists:categories,id'],
            'nama' => ['required', 'string', 'max:160'],
            'slug' => ['nullable', 'string', 'max:180', 'unique:products,slug'],
            'deskripsi' => ['nullable', 'string'],
            'is_active' => ['boolean'],
            // optional create with initial variants:
            'variants' => ['sometimes', 'array', 'max:50'],
            'variants.*.size' => ['nullable', 'string', 'max:40'],
            'variants.*.type' => ['nullable', 'string', 'max:60'],
            'variants.*.tester' => ['nullable', 'string', 'max:40'],
            'variants.*.harga' => ['required', 'numeric', 'min:0'],
        ];
    }
}

```
</details>

### app/Http/Requests/StoreVariantRequest.php

- SHA: `56a1a9dc8725`  
- Ukuran: 680 B  
- Namespace: `App\Http\Requests`

**Class `StoreVariantRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreVariantRequest extends FormRequest
{
    public function authorize(): bool
    {
        $product = $this->route('product');
        return $this->user()?->can('update', $product) ?? false;
    }

    public function rules(): array
    {
        return [
            'size' => ['nullable', 'string', 'max:40'],
            'type' => ['nullable', 'string', 'max:60'],
            'tester' => ['nullable', 'string', 'max:40'],
            'harga' => ['required', 'numeric', 'min:0'],
            'sku' => ['nullable', 'string', 'max:80', 'unique:product_variants,sku'],
        ];
    }
}

```
</details>

### app/Http/Requests/UpdateProductRequest.php

- SHA: `33aee275c51d`  
- Ukuran: 855 B  
- Namespace: `App\Http\Requests`

**Class `UpdateProductRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateProductRequest extends FormRequest
{
    public function authorize(): bool
    {
        $product = $this->route('product');
        return $this->user()?->can('update', $product) ?? false;
    }

    public function rules(): array
    {
        $product = $this->route('product');

        return [
            'category_id' => ['sometimes', 'exists:categories,id'],
            'nama' => ['sometimes', 'string', 'max:160'],
            'slug' => [
                'nullable',
                'string',
                'max:180',
                Rule::unique('products', 'slug')->ignore($product?->id),
            ],
            'deskripsi' => ['nullable', 'string'],
            'is_active' => ['boolean'],
        ];
    }
}

```
</details>

### app/Http/Requests/UpdateVariantRequest.php

- SHA: `11eea15bb0ad`  
- Ukuran: 911 B  
- Namespace: `App\Http\Requests`

**Class `UpdateVariantRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateVariantRequest extends FormRequest
{
    public function authorize(): bool
    {
        $variant = $this->route('variant');
        return $this->user()?->can('update', $variant) ?? false;
    }

    public function rules(): array
    {
        $variant = $this->route('variant');

        return [
            'size' => ['nullable', 'string', 'max:40'],
            'type' => ['nullable', 'string', 'max:60'],
            'tester' => ['nullable', 'string', 'max:40'],
            'harga' => ['sometimes', 'numeric', 'min:0'],
            'sku' => [
                'nullable',
                'string',
                'max:80',
                Rule::unique('product_variants', 'sku')->ignore($variant?->id),
            ],
            'is_active' => ['boolean'],
        ];
    }
}

```
</details>

### app/Http/Requests/UploadProductMediaRequest.php

- SHA: `02778dd2d0b9`  
- Ukuran: 661 B  
- Namespace: `App\Http\Requests`

**Class `UploadProductMediaRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UploadProductMediaRequest extends FormRequest
{
    public function authorize(): bool
    {
        $product = $this->route('product');
        return $this->user()?->can('update', $product) ?? false;
    }

    public function rules(): array
    {
        return [
            // allow EITHER files[] array OR single file
            'file'     => ['sometimes', 'image', 'max:5120'], // 5MB
            'files'    => ['sometimes', 'array', 'min:1', 'max:10'],
            'files.*'  => ['file', 'mimetypes:image/jpeg,image/png,image/webp', 'max:5120'],
        ];
    }
}

```
</details>

### app/Http/Requests/UserStoreRequest.php

- SHA: `5b5880e97e96`  
- Ukuran: 853 B  
- Namespace: `App\Http\Requests`

**Class `UserStoreRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

// app/Http/Requests/UserStoreRequest.php
namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UserStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }
    public function rules(): array
    {
        $roles = ['superadmin', 'admin_cabang', 'gudang', 'kasir', 'sales', 'kurir'];
        return [
            'name' => ['required', 'string', 'max:120'],
            'email' => ['required', 'email', 'max:190', 'unique:users,email'],
            'phone' => ['nullable', 'string', 'max:30'],
            'password' => ['required', 'string', 'min:8', 'max:190'],
            'cabang_id' => ['nullable', 'integer', 'min:1'],
            'role' => ['required', Rule::in($roles)],
            'is_active' => ['boolean'],
        ];
    }
}

```
</details>

### app/Http/Requests/UserUpdateRequest.php

- SHA: `4c6f94c14e48`  
- Ukuran: 1 KB  
- Namespace: `App\Http\Requests`

**Class `UserUpdateRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

// app/Http/Requests/UserUpdateRequest.php
namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UserUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        if ($this->has('password') && $this->string('password') === '') {
            // Konversi "" menjadi null agar lolos rule nullable|min:8
            $this->merge(['password' => null]);
        }
    }

    public function rules(): array
    {
        $roles = ['superadmin', 'admin_cabang', 'gudang', 'kasir', 'sales', 'kurir'];
        $id = $this->route('id') ?? $this->route('user');

        return [
            'name'      => ['sometimes', 'string', 'max:120'],
            'email'     => ['sometimes', 'email', 'max:190', "unique:users,email,{$id}"],
            'phone'     => ['sometimes', 'nullable', 'string', 'max:30'],
            // ⬇️ izinkan null (artinya tidak ganti), min:8 hanya berlaku jika ada nilai
            'password'  => ['sometimes', 'nullable', 'string', 'min:8'],
            'cabang_id' => ['sometimes', 'nullable', 'integer', 'min:1'],
            'role'      => ['sometimes', Rule::in($roles)],
            'is_active' => ['sometimes', 'boolean'],
        ];
    }
}

```
</details>

### app/Http/Requests/VariantStockAdjustRequest.php

- SHA: `1e0c706ac72e`  
- Ukuran: 443 B  
- Namespace: `App\Http\Requests`

**Class `VariantStockAdjustRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class VariantStockAdjustRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        return [
            'type'   => ['required','in:increase,decrease'],
            'amount' => ['required','integer','min:1'],
            'note'   => ['nullable','string','max:255'],
        ];
    }
}

```
</details>

### app/Http/Requests/VariantStockStoreRequest.php

- SHA: `8b44a4322b50`  
- Ukuran: 887 B  
- Namespace: `App\Http\Requests`

**Class `VariantStockStoreRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
- **messages**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class VariantStockStoreRequest extends FormRequest
{
    public function authorize(): bool { return true; } // via Controller->authorize() by policy

    public function rules(): array
    {
        return [
            'gudang_id'          => ['required','integer','exists:gudangs,id'],
            'product_variant_id' => ['required','integer','exists:product_variants,id'],
            'qty'                => ['required','integer','min:0'],
            'min_stok'           => ['nullable','integer','min:0'],
        ];
    }

    public function messages(): array
    {
        return [
            'gudang_id.required' => 'Gudang wajib dipilih.',
            'product_variant_id.required' => 'Varian wajib dipilih.',
            'qty.required' => 'Jumlah stok awal wajib diisi.',
        ];
    }
}

```
</details>

### app/Http/Requests/VariantStockUpdateRequest.php

- SHA: `93fd336969c2`  
- Ukuran: 327 B  
- Namespace: `App\Http\Requests`

**Class `VariantStockUpdateRequest` extends `FormRequest`**

Metode Publik:
- **authorize**() : *bool*
- **rules**() : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class VariantStockUpdateRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        return [
            'min_stok' => ['required','integer','min:0'],
        ];
    }
}

```
</details>



## Services (app/Services)

### app/Services/AccountingService.php

- SHA: `2e4b264c1fbe`  
- Ukuran: 8 KB  
- Namespace: `App\Services`

**Class `AccountingService`**

Metode Publik:
- **upsertDraft**(array $payload) : *JournalEntry* — Create/Update Journal in DRAFT.
- **post**(JournalEntry $entry, ?string $key = null) : *JournalEntry* — Create/Update Journal in DRAFT.
- **openPeriod**(int $cabangId, int $year, int $month) : *FiscalPeriod* — Create/Update Journal in DRAFT.
- **closePeriod**(int $cabangId, int $year, int $month) : *FiscalPeriod* — Create/Update Journal in DRAFT.
- **trialBalance**(int $cabangId, int $year, int $month) : *array* — Create/Update Journal in DRAFT.
- **generalLedger**(int $cabangId, int $accountId, int $year, int $month) : *array* — Create/Update Journal in DRAFT.
- **profitLoss**(int $cabangId, int $year, int $month) : *array* — Create/Update Journal in DRAFT.
- **balanceSheet**(int $cabangId, int $year, int $month) : *array* — Create/Update Journal in DRAFT.
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Services;

use App\Models\{Account, FiscalPeriod, JournalEntry, JournalLine};
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class AccountingService
{
    /**
     * Create/Update Journal in DRAFT.
     */
    public function upsertDraft(array $payload): JournalEntry
    {
        return DB::transaction(function () use ($payload) {
            $periodYear  = (int) date('Y', strtotime($payload['journal_date']));
            $periodMonth = (int) date('n', strtotime($payload['journal_date']));

            // Guard periode CLOSED
            $fp = FiscalPeriod::query()
                ->where('cabang_id', $payload['cabang_id'])
                ->where('year', $periodYear)->where('month', $periodMonth)
                ->first();
            if ($fp && $fp->status === 'CLOSED') {
                throw new \DomainException('Periode telah ditutup.');
            }

            // Upsert header berdasar (cabang, number)
            $entry = JournalEntry::query()
                ->firstOrNew(['cabang_id' => $payload['cabang_id'], 'number' => $payload['number']]);
            $entry->fill([
                'journal_date' => $payload['journal_date'],
                'description'  => $payload['description'] ?? null,
                'status'       => 'DRAFT',
                'period_year'  => $periodYear,
                'period_month' => $periodMonth,
            ]);
            $entry->save();

            // Reset lines lalu isi ulang
            $entry->lines()->delete();

            $sumDebit = 0;
            $sumCredit = 0;
            foreach ($payload['lines'] as $i => $line) {
                /** @var Account $acc */
                $acc = Account::query()->whereKey($line['account_id'])->first();
                if (!$acc || !$acc->is_active) {
                    throw new \InvalidArgumentException("Akun tidak aktif/invalid pada baris #" . ($i + 1));
                }

                $debit  = (float) ($line['debit']  ?? 0);
                $credit = (float) ($line['credit'] ?? 0);
                if ($debit < 0 || $credit < 0) {
                    throw new \InvalidArgumentException("Nilai negatif tidak diperbolehkan (#" . ($i + 1) . ")");
                }

                $sumDebit  += $debit;
                $sumCredit += $credit;

                $entry->lines()->create([
                    'account_id' => $acc->id,
                    'cabang_id'  => $payload['cabang_id'],
                    'debit'      => $debit,
                    'credit'     => $credit,
                    'ref_type'   => $line['ref_type'] ?? null,
                    'ref_id'     => $line['ref_id'] ?? null,
                ]);
            }

            if (round($sumDebit, 2) !== round($sumCredit, 2)) {
                throw new \InvalidArgumentException('Jurnal tidak seimbang (Σ debit ≠ Σ credit).');
            }

            return $entry->refresh();
        });
    }

    /**
     * Post DRAFT → POSTED (idempotent by (cabang, number)).
     */
    public function post(JournalEntry $entry, ?string $key = null): JournalEntry
    {
        return DB::transaction(function () use ($entry, $key) {
            if ($entry->status === 'POSTED') {
                return $entry; // idempotent
            }

            // Guard periode
            $fp = FiscalPeriod::query()
                ->where('cabang_id', $entry->cabang_id)
                ->where('year', $entry->period_year)
                ->where('month', $entry->period_month)
                ->first();
            if ($fp && $fp->status === 'CLOSED') {
                throw new \DomainException('Periode telah ditutup.');
            }

            // Validasi double-entry
            $sum = $entry->lines()
                ->selectRaw('COALESCE(SUM(debit),0) as d, COALESCE(SUM(credit),0) as c')->first();
            if (round($sum->d, 2) !== round($sum->c, 2)) {
                throw new \InvalidArgumentException('Jurnal tidak seimbang.');
            }

            $entry->status = 'POSTED';
            $entry->save();

            // Audit
            DB::table('audit_logs')->insert([
                'actor_type' => 'USER',
                'actor_id'   => Auth::id(),
                'action'     => 'JOURNAL_POSTED',
                'model'      => 'JournalEntry',
                'model_id'   => $entry->id,
                'diff_json'  => json_encode(['number' => $entry->number, 'posted_at' => now()->toDateTimeString()]),
                'created_at' => now(),
                'updated_at' => now(),
                'occurred_at' => now(),
            ]);

            return $entry->refresh();
        });
    }

    public function openPeriod(int $cabangId, int $year, int $month): FiscalPeriod
    {
        return DB::transaction(function () use ($cabangId, $year, $month) {
            $fp = FiscalPeriod::firstOrCreate(
                ['cabang_id' => $cabangId, 'year' => $year, 'month' => $month],
                ['status' => 'OPEN']
            );
            if ($fp->status !== 'OPEN') {
                $fp->status = 'OPEN';
                $fp->save();
            }
            return $fp->refresh();
        });
    }

    public function closePeriod(int $cabangId, int $year, int $month): FiscalPeriod
    {
        return DB::transaction(function () use ($cabangId, $year, $month) {
            $fp = FiscalPeriod::firstOrCreate(
                ['cabang_id' => $cabangId, 'year' => $year, 'month' => $month],
                ['status' => 'OPEN']
            );
            $fp->status = 'CLOSED';
            $fp->save();
            return $fp->refresh();
        });
    }

    /** Reports */
    public function trialBalance(int $cabangId, int $year, int $month): array
    {
        // agregasi cepat per akun pada periode (termasuk saldo <= tanggal akhir)
        $rows = DB::table('journal_lines as jl')
            ->join('journal_entries as je', 'je.id', '=', 'jl.journal_id')
            ->join('accounts as a', 'a.id', '=', 'jl.account_id')
            ->where('jl.cabang_id', $cabangId)
            ->where('je.period_year', $year)
            ->where('je.period_month', $month)
            ->where('je.status', 'POSTED')
            ->groupBy('a.id', 'a.code', 'a.name', 'a.type', 'a.normal_balance')
            ->selectRaw('a.id,a.code,a.name,a.type,a.normal_balance, SUM(jl.debit) as debit, SUM(jl.credit) as credit')
            ->orderBy('a.code')
            ->get()->all();

        return $rows;
    }

    public function generalLedger(int $cabangId, int $accountId, int $year, int $month): array
    {
        $rows = DB::table('journal_lines as jl')
            ->join('journal_entries as je', 'je.id', '=', 'jl.journal_id')
            ->where('jl.cabang_id', $cabangId)
            ->where('jl.account_id', $accountId)
            ->where('je.period_year', $year)
            ->where('je.period_month', $month)
            ->where('je.status', 'POSTED')
            ->orderBy('je.journal_date')
            ->select('je.number', 'je.journal_date', 'jl.debit', 'jl.credit', 'jl.ref_type', 'jl.ref_id')
            ->get()->all();
        return $rows;
    }

    public function profitLoss(int $cabangId, int $year, int $month): array
    {
        $rows = DB::table('journal_lines as jl')
            ->join('journal_entries as je', 'je.id', '=', 'jl.journal_id')
            ->join('accounts as a', 'a.id', '=', 'jl.account_id')
            ->where('jl.cabang_id', $cabangId)
            ->where('je.period_year', $year)
            ->where('je.period_month', $month)
            ->where('je.status', 'POSTED')
            ->whereIn('a.type', ['Revenue', 'Expense'])
            ->groupBy('a.type')
            ->selectRaw("a.type, SUM(jl.debit) as debit, SUM(jl.credit) as credit")
            ->get()->keyBy('type')->all();

        return $rows;
    }

    public function balanceSheet(int $cabangId, int $year, int $month): array
    {
        $rows = DB::table('journal_lines as jl')
            ->join('journal_entries as je', 'je.id', '=', 'jl.journal_id')
            ->join('accounts as a', 'a.id', '=', 'jl.account_id')
            ->where('jl.cabang_id', $cabangId)
            ->where('je.period_year', $year)
            ->where('je.period_month', $month)
            ->where('je.status', 'POSTED')
            ->whereIn('a.type', ['Asset', 'Liability', 'Equity'])
            ->groupBy('a.type')
            ->selectRaw("a.type, SUM(jl.debit) as debit, SUM(jl.credit) as credit")
            ->get()->keyBy('type')->all();

        return $rows;
    }
}

```
</details>

### app/Services/Auth/AuthService.php

- SHA: `dd540027019b`  
- Ukuran: 2 KB  
- Namespace: `App\Services\Auth`

**Class `AuthService`**

Metode Publik:
- **login**(string $email, string $password) : *array* — @return array{token:string, token_type:string, user:User}
- **logout**(User $user, bool $allDevices = false) : *void* — @return array{token:string, token_type:string, user:User}
- **me**(User $user) : *User* — @return array{token:string, token_type:string, user:User}
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Services\Auth;

use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthService
{
    /**
     * @return array{token:string, token_type:string, user:User}
     */
    public function login(string $email, string $password): array
    {
        /** @var User|null $user */
        $user = User::query()->where('email', $email)->first();

        if (!$user || !Hash::check($password, $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['Email atau password salah.'],
            ]);
        }

        if (!$user->is_active) {
            throw ValidationException::withMessages([
                'email' => ['Akun tidak aktif.'],
            ]);
        }

        $token = $user->createToken('api')->plainTextToken;

        return [
            'token' => $token,
            'token_type' => 'Bearer',
            'user' => $user,
        ];
    }

    /**
     * Logout.
     * @param User $user
     * @param bool $allDevices Jika true, hapus semua token user (logout semua device).
     */
    public function logout(User $user, bool $allDevices = false): void
    {
        if ($allDevices) {
            // hapus semua token milik user
            $user->tokens()->delete();
            return;
        }

        // hapus hanya token aktif saat ini (jika ada)
        /** @var \Laravel\Sanctum\PersonalAccessToken|null $current */
        $current = $user->currentAccessToken();
        if ($current !== null) {
            $current->delete();
        }
    }

    public function me(User $user): User
    {
        return $user;
    }
}

```
</details>

### app/Services/CabangService.php

- SHA: `b162aae0eafe`  
- Ukuran: 2 KB  
- Namespace: `App\Services`

**Class `CabangService`**

Metode Publik:
- **queryIndexForUser**($user) : *Builder*
- **create**(array $data) : *Cabang*
- **update**(Cabang $cabang, array $data) : *Cabang* — @var Cabang $cabang
- **delete**(Cabang $cabang) : *void* — @var Cabang $cabang
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Services;

use App\Models\Cabang;
use App\Models\Gudang;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Support\Facades\DB;

class CabangService
{
    public function queryIndexForUser($user): Builder
    {
        // superadmin lihat semua; selain itu hanya cabangnya sendiri
        return Cabang::query()
            ->when($user->role !== 'superadmin', fn ($q) => $q->where('id', $user->cabang_id));
    }

    public function create(array $data): Cabang
    {
        return DB::transaction(function () use ($data) {
            /** @var Cabang $cabang */
            $cabang = Cabang::create([
                'nama' => $data['nama'],
                'kota' => $data['kota'] ?? null,
                'alamat' => $data['alamat'] ?? null,
                'telepon' => $data['telepon'] ?? null,
                'jam_operasional' => $data['jam_operasional'] ?? null,
                'is_active' => $data['is_active'] ?? true,
            ]);

            // auto-create gudang default
            Gudang::create([
                'cabang_id' => $cabang->id,
                'nama' => 'Gudang Utama',
                'is_default' => true,
                'is_active' => true,
            ]);

            return $cabang->fresh(['gudangs']);
        });
    }

    public function update(Cabang $cabang, array $data): Cabang
    {
        $cabang->fill($data)->save();
        return $cabang->fresh();
    }

    public function delete(Cabang $cabang): void
    {
        // FK gudangs cascade delete; users.cabang_id set null (jika FK nullOnDelete diterapkan)
        $cabang->delete();
    }
}

```
</details>

### app/Services/CashService.php

- SHA: `19a3e16e1080`  
- Ukuran: 10 KB  
- Namespace: `App\Services`

**Class `CashService`**

Metode Publik:
- **submitMove**(array $payload, int $actorId) : *CashMove*
- **approveMove**(CashMove $move, ?string $approvedAt, int $approverId) : *CashMove*
- **rejectMove**(CashMove $move, string $reason, int $approverId) : *CashMove* — @var \App\Services\AccountingService $acc
- **mirrorPaymentToHolder**(int $holderId, float $amount, int $paymentId, string $note = '') : *void* — @var \App\Services\AccountingService $acc
- **getOrOpenSessionForHolder**(int $holderId) : *CashSession* — @var \App\Services\AccountingService $acc
- **mirrorPaymentToSession**(CashSession $session, float $amount, string $refType, int $refId, ?string $note = null, ?int $holderId = null) : *CashTransaction* — @var \App\Services\AccountingService $acc
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Services;

use App\Models\{CashMove, CashHolder, CashSession, CashTransaction, Payment};
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;

class CashService
{
    // Submit a move (draft->submitted), idempotent on idempotency_key
    public function submitMove(array $payload, int $actorId): CashMove
    {
        return DB::transaction(function () use ($payload, $actorId) {
            $key = $payload['idempotency_key'] ?? null;
            if ($key && ($existing = CashMove::where('idempotency_key', $key)->first())) {
                return $existing;
            }
            $move = new CashMove([
                'from_holder_id' => $payload['from_holder_id'],
                'to_holder_id'   => $payload['to_holder_id'],
                'amount'         => $payload['amount'],
                'note'           => $payload['note'] ?? null,
                'moved_at'       => Carbon::parse($payload['moved_at']),
                'status'         => 'SUBMITTED',
                'submitted_by'   => $actorId,
                'idempotency_key' => $key,
            ]);
            $move->save();
            // audit
            $this->audit('SUBMIT', 'cash_moves', $move->id, ['after' => $move->toArray()]);
            return $move;
        });
    }

    // Approve: adjust balances atomically
    public function approveMove(CashMove $move, ?string $approvedAt, int $approverId): CashMove
    {
        return DB::transaction(function () use ($move, $approvedAt, $approverId) {
            $move->refresh();
            if ($move->status === 'APPROVED') {
                return $move;
            }
            if ($move->status !== 'SUBMITTED') {
                throw new \RuntimeException('Move must be SUBMITTED');
            }

            $from = CashHolder::lockForUpdate()->findOrFail($move->from_holder_id);
            $to   = CashHolder::lockForUpdate()->findOrFail($move->to_holder_id);
            if ($from->balance < $move->amount) {
                throw new \RuntimeException('Insufficient balance');
            }

            $fromBefore = $from->balance;
            $toBefore   = $to->balance;
            // precise to 2 decimals without BCMath
            $from->balance = (string) round(((float) $from->balance) - (float) $move->amount, 2);
            $to->balance   = (string) round(((float) $to->balance)   + (float) $move->amount, 2);

            $from->save();
            $to->save();

            $move->status = 'APPROVED';
            $move->approved_by = $approverId;
            $move->approved_at = $approvedAt ? Carbon::parse($approvedAt) : now();
            $move->save();

            $this->audit('APPROVE', 'cash_moves', $move->id, [
                'before' => ['from.balance' => $fromBefore, 'to.balance' => $toBefore, 'status' => 'SUBMITTED'],
                'after' => ['from.balance' => $from->balance, 'to.balance' => $to->balance, 'status' => 'APPROVED'],
            ]);

            // === ACCOUNTING HOOK (versi afterCommit, lebih aman) ===
            DB::afterCommit(function () use ($from, $to, $move) {
                try {
                    if (Auth::user()?->hasAnyRole(['superadmin', 'admin_cabang'])) {
                        /** @var \App\Services\AccountingService $acc */
                        $acc = app(\App\Services\AccountingService::class);

                        $cabangId  = $from->cabang_id ?? $to->cabang_id;
                        $cashAccId = (int) setting('acc.cash_id');   // Kas
                        $bankAccId = (int) setting('acc.bank_id');   // Bank

                        // contoh sederhana: treat move ini sebagai setoran Kas -> Bank
                        if ($cashAccId && $bankAccId) {
                            $acc->upsertDraft([
                                'cabang_id'    => (int) $cabangId,
                                'journal_date' => optional($move->approved_at)->toDateString() ?? now()->toDateString(),
                                'number'       => 'CASH-MOVE-' . $move->id, // unik per cabang (sesuai migrasi)
                                'description'  => 'Cash move #' . $move->id . ' (' . ($from->name ?? 'from') . ' → ' . ($to->name ?? 'to') . ')',
                                'lines'        => [
                                    ['account_id' => $bankAccId, 'debit' => (float) $move->amount, 'credit' => 0, 'ref_type' => 'CASH_MOVE', 'ref_id' => $move->id],
                                    ['account_id' => $cashAccId, 'debit' => 0, 'credit' => (float) $move->amount, 'ref_type' => 'CASH_MOVE', 'ref_id' => $move->id],
                                ],
                            ]);
                        }
                    }
                } catch (\Throwable $e) {
                    report($e);
                }
            });
            // === END ACCOUNTING HOOK ===

            return $move;
        });
    }

    public function rejectMove(CashMove $move, string $reason, int $approverId): CashMove
    {
        return DB::transaction(function () use ($move, $reason, $approverId) {
            $move->refresh();
            if ($move->status !== 'SUBMITTED') {
                throw new \RuntimeException('Move must be SUBMITTED');
            }
            $move->status = 'REJECTED';
            $move->approved_by = $approverId;
            $move->rejected_at = now();
            $move->reject_reason = $reason;
            $move->save();
            $this->audit('REJECT', 'cash_moves', $move->id, ['after' => $move->only(['status', 'reject_reason'])]);
            return $move;
        });
    }

    public function mirrorPaymentToHolder(int $holderId, float $amount, int $paymentId, string $note = ''): void
    {
        DB::transaction(function () use ($holderId, $amount, $paymentId, $note) {
            // Cek idempoten: jika sudah pernah mirror untuk payment ini, abaikan
            $exists = DB::table('audit_logs')
                ->where('action', 'CASH_MIRROR')
                ->where('model', 'payments')
                ->where('model_id', $paymentId)
                ->exists();
            if ($exists) {
                return;
            }

            /** @var \App\Models\CashHolder $holder */
            $holder = CashHolder::lockForUpdate()->findOrFail($holderId);
            $before = (string) $holder->balance;
            $holder->balance = number_format(
                round(((float) $holder->balance) + (float) $amount, 2),
                2,
                '.',
                ''
            );
            $holder->save();

            // Audit log sebagai jejak & kunci idempoten
            DB::table('audit_logs')->insert([
                'actor_type' => 'USER',
                'actor_id'   => Auth::id(),
                'action'     => 'CASH_MIRROR',
                'model'      => 'payments',
                'model_id'   => $paymentId,
                'diff_json'  => json_encode([
                    'holder_id' => $holderId,
                    'amount'    => $amount,
                    'note'      => $note,
                    'before'    => $before,
                    'after'     => $holder->balance,
                ]),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        });
    }

    public function getOrOpenSessionForHolder(int $holderId): CashSession
    {
        return DB::transaction(function () use ($holderId) {
            /** @var \App\Models\CashSession|null $open */
            $open = CashSession::lockForUpdate()
                ->where('holder_id', $holderId)
                ->where('status', 'OPEN')
                ->latest('id')
                ->first();

            if ($open) {
                return $open;
            }

            $session = new CashSession([
                'holder_id' => $holderId,
                'status'    => 'OPEN',
                'opened_at' => now(),
                'opened_by' => Auth::id(),
            ]);
            $session->save();

            // audit
            $this->audit('OPEN_SESSION', 'cash_sessions', $session->id, [
                'after' => $session->toArray(),
            ]);

            return $session;
        });
    }

    // Mirror payment (CASH) to active cash session
    public function mirrorPaymentToSession(CashSession $session, float $amount, string $refType, int $refId, ?string $note = null, ?int $holderId = null): CashTransaction
    {
        return DB::transaction(function () use ($session, $amount, $refType, $refId, $note, $holderId) {
            $tx = new CashTransaction([
                'session_id'  => $session->id,
                'type'        => 'IN',
                'amount'      => $amount,
                'source'      => 'ORDER',
                'ref_type'    => $refType,
                'ref_id'      => $refId,
                'note'        => $note,
                'occurred_at' => now(),
            ]);
            $tx->save();
            $this->audit('LOG_CASH', 'cash_transactions', $tx->id, ['after' => $tx->toArray()]);

            if ($holderId) {
                /** @var \App\Models\CashHolder $holder */
                $holder = \App\Models\CashHolder::lockForUpdate()->findOrFail($holderId);
                $before = $holder->balance;
                $holder->balance = number_format(
                    round(((float)$holder->balance) + (float)$amount, 2),
                    2,
                    '.',
                    ''
                );
                $holder->save();
                $this->audit('CASH_IN_HOLDER', 'cash_holders', $holder->id, [
                    'before' => ['balance' => $before],
                    'after' => ['balance' => $holder->balance],
                    'ref'   => ['type' => $refType, 'id' => $refId],
                ]);
            }
            return $tx;
        });
    }

    private function audit(string $action, string $model, int $modelId, array $diff): void
    {
        DB::table('audit_logs')->insert([
            'actor_type' => 'USER',
            'actor_id'   => Auth::id(),
            'action'     => $action,
            'model'      => $model,
            'model_id'   => $modelId,
            'diff_json'  => json_encode($diff),
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }
}

```
</details>

### app/Services/CategoryService.php

- SHA: `21ecc6945435`  
- Ukuran: 4 KB  
- Namespace: `App\Services`

**Class `CategoryService`**

Metode Publik:
- **paginate**(array $filters) : *\Illuminate\Contracts\Pagination\LengthAwarePaginator*
- **create**(array $data) : *Category* — @var Builder $q
- **update**(Category $category, array $data) : *Category* — @var Builder $q
- **delete**(Category $category) : *void* — @var Builder $q
- **findOrFail**(int $id) : *Category* — @var Builder $q
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Services;

use App\Models\Category;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class CategoryService
{
    public function paginate(array $filters): \Illuminate\Contracts\Pagination\LengthAwarePaginator
    {
        /** @var Builder $q */
        $q = Category::query();

        // search
        if (!empty($filters['q'])) {
            $q->search($filters['q']);
        }

        // filter is_active
        if (isset($filters['is_active']) && $filters['is_active'] !== '') {
            $q->where('is_active', (bool) $filters['is_active']);
        }

        // sort
        [$col, $dir] = $filters['sort'] ?? ['nama', 'asc'];
        $q->orderBy($col, $dir);

        // catatan: saat modul produk ada, boleh tambahkan ->withCount('products')
        return $q->paginate($filters['per_page'] ?? 10);
    }

    public function create(array $data): Category
    {
        return DB::transaction(function () use ($data) {
            $payload = $this->preparePayload($data);

            // Validasi slug unik (kalau diberikan manual)
            if (!empty($payload['slug']) && Category::query()->where('slug', $payload['slug'])->exists()) {
                throw ValidationException::withMessages(['slug' => 'Slug sudah dipakai.']);
            }

            // Jika slug kosong -> generate dari nama (pastikan unik)
            if (empty($payload['slug'])) {
                $payload['slug'] = $this->uniqueSlugFromName($payload['nama']);
            }

            return Category::create($payload);
        });
    }

    public function update(Category $category, array $data): Category
    {
        return DB::transaction(function () use ($category, $data) {
            $payload = $this->preparePayload($data);

            // Jika slug diberikan, pastikan unik
            if (!empty($payload['slug'])) {
                $exists = Category::query()
                    ->where('slug', $payload['slug'])
                    ->where('id', '!=', $category->id)
                    ->exists();

                if ($exists) {
                    throw ValidationException::withMessages(['slug' => 'Slug sudah dipakai.']);
                }
            } else {
                // optionally regenerate dari nama (bila ingin sinkron)
                // $payload['slug'] = $this->uniqueSlugFromName($payload['nama']);
            }

            $category->update($payload);
            return $category->refresh();
        });
    }

    public function delete(Category $category): void
    {
        DB::transaction(function () use ($category) {
            // Jika nanti relasi produk diaktifkan:
            // if ($category->products()->exists()) {
            //     throw ValidationException::withMessages(['category' => 'Kategori sedang dipakai produk dan tidak dapat dihapus.']);
            // }

            $category->delete();
        });
    }

    private function preparePayload(array $data): array
    {
        return [
            'nama'      => $data['nama'],
            'deskripsi' => $data['deskripsi'] ?? null,
            'is_active' => array_key_exists('is_active', $data) ? (bool)$data['is_active'] : true,
            'slug'      => $data['slug'] ?? null,
        ];
    }

    private function uniqueSlugFromName(string $nama): string
    {
        $base = Str::slug($nama);
        $slug = $base;
        $i = 1;

        while (Category::query()->where('slug', $slug)->exists()) {
            $i++;
            $slug = "{$base}-{$i}";
            if ($i > 1000) {
                // guard rail agar tidak infinite loop pada kasus ekstrem
                throw ValidationException::withMessages(['slug' => 'Gagal menghasilkan slug unik.']);
            }
        }

        return $slug;
    }

    public function findOrFail(int $id): Category
    {
        $category = Category::find($id);
        if (!$category) {
            throw new ModelNotFoundException('Kategori tidak ditemukan.');
        }
        return $category;
    }
}

```
</details>

### app/Services/CheckoutService.php

- SHA: `6f3ae8a06c2e`  
- Ukuran: 14 KB  
- Namespace: `App\Services`

**Class `CheckoutService`**

Metode Publik:
- **__construct**(private QuoteService $quote, private SalesInventoryService $salesInv, private FeeService $fees,)
- **checkout**(array $payload, int $cashierId) : *Order* — One-shot checkout:
- **addPayment**(Order $order, array $payment) : *Order* — One-shot checkout:
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Services;

use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Payment;
use App\Models\Customer;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Carbon;
use InvalidArgumentException;
use App\Services\FeeService;
use App\Services\AccountingService;
use Illuminate\Support\Facades\Config;

class CheckoutService
{
    public function __construct(
        private QuoteService $quote,
        private SalesInventoryService $salesInv,
        private FeeService $fees,
    ) {}

    /**
     * One-shot checkout:
     * - Bisa tanpa payment (PENDING) -> order UNPAID
     * - Bisa DP (amount < grand_total)
     * - Bisa Full (amount >= grand_total)
     *
     * @param array $payload  // { items:[...], cabang_id, gudang_id, ... , payment?:{method,amount,status?,ref_no?,paid_at?,payload_json?} }
     * @param int $cashierId
     * @return Order
     */
    public function checkout(array $payload, int $cashierId): Order
    {
        return DB::transaction(function () use ($payload, $cashierId) {

            $items = $payload['items'] ?? [];
            if (empty($items)) {
                throw new InvalidArgumentException('Keranjang kosong.');
            }

            // Hitung quote dari item
            $q = $this->quote->quoteItems($items); // expect ['items'=>..., 'totals'=>['subtotal','discount','tax','service_fee','grand_total']]

            // Buat order
            $order = new Order();
            $order->kode       = $payload['kode'] ?? $this->generateCode((int)$payload['cabang_id']);
            $order->cabang_id  = (int)$payload['cabang_id'];
            $order->gudang_id  = (int)$payload['gudang_id'];
            $order->cashier_id = $cashierId;
            $order->customer_id = $payload['customer_id'] ?? null;
            $order->note        = $payload['note'] ?? null;

            $order->cash_position = $payload['cash_position'] ?? null;

            $customerPayload = $payload['customer'] ?? null;

            if (is_array($customerPayload)) {
                // pakai data dari payload (yang sudah diprefill dari pilihan customer)
                $order->customer_name    = $customerPayload['nama']   ?? null;
                $order->customer_phone   = $customerPayload['phone']  ?? null;
                $order->customer_address = $customerPayload['alamat'] ?? null;
            } elseif (!empty($payload['customer_id'])) {
                // fallback: kalau payload.customer tidak dikirim, ambil dari master Customer
                if ($c = Customer::find((int) $payload['customer_id'])) {
                    $order->customer_name    = $c->nama ?? null;
                    $order->customer_phone   = $c->phone ?? null;
                    $order->customer_address = $c->alamat ?? null;
                }
            }

            $order->ordered_at  = isset($payload['ordered_at']) ? Carbon::parse($payload['ordered_at']) : now();
            $order->status      = 'UNPAID';

            // totals
            $order->fill($q['totals']);  // set subtotal/discount/tax/service_fee/grand_total
            $order->paid_total = 0;
            $order->save();

            // Items
            foreach ($q['items'] as $line) {
                OrderItem::query()->create([
                    'order_id'      => $order->id,
                    'variant_id'    => $line['variant_id'],
                    'name_snapshot' => $line['name_snapshot'],
                    'price'         => $line['price'],
                    'discount'      => $line['discount'],
                    'qty'           => $line['qty'],
                    'line_total'    => $line['line_total'],
                ]);
            }

            // Payment opsional (PENDING kalau tidak dikirim)
            if (!empty($payload['payment'])) {
                $this->recordPayment($order, $payload['payment']);
            }

            $this->recomputeAndMaybeClose($order);

            return $order->fresh(['items', 'payments']);
        });
    }

    /**
     * Tambah pembayaran (split tender / pelunasan).
     * Melarang overpay melebihi sisa tagihan.
     */
    public function addPayment(Order $order, array $payment): Order
    {
        return DB::transaction(function () use ($order, $payment) {

            // Sisa tagihan sebelum tambah
            $paidSuccess = (float) $order->payments()->where('status', 'SUCCESS')->sum('amount');
            $remaining   = max(0.0, (float)$order->grand_total - $paidSuccess);

            $amount = (float)($payment['amount'] ?? 0);
            if ($amount <= 0) {
                throw new InvalidArgumentException('Nominal bayar harus lebih dari 0.');
            }
            if ($amount > $remaining) {
                throw new InvalidArgumentException('Nominal bayar melebihi sisa tagihan.');
            }

            $this->recordPayment($order, $payment);
            $this->recomputeAndMaybeClose($order);

            return $order->fresh(['items', 'payments']);
        });
    }

    /**
     * Simpan payment ke DB dengan default status per metode:
     * - CASH / QRIS => SUCCESS (bayar langsung)
     * - TRANSFER    => PENDING (default), bisa di-override via $p['status']
     *
     * Recalculate paid_total dari SUCCESS payments (lebih aman).
     */
    private function recordPayment(Order $order, array $p): void
    {
        $method = strtoupper((string)($p['method'] ?? ''));
        if (!in_array($method, ['CASH', 'TRANSFER', 'QRIS', 'XENDIT'], true)) {
            throw new InvalidArgumentException('Metode pembayaran tidak didukung.');
        }

        $amount = (float)($p['amount'] ?? 0);
        if ($amount <= 0) {
            throw new InvalidArgumentException('Nominal bayar harus lebih dari 0.');
        }

        // Default status
        $defaultStatus = match ($method) {
            'CASH', 'QRIS'      => 'SUCCESS',
            'TRANSFER', 'XENDIT' => 'PENDING',
            default             => 'PENDING',
        };
        $status = strtoupper((string)($p['status'] ?? $defaultStatus));
        if (!in_array($status, ['PENDING', 'SUCCESS', 'FAILED', 'REFUND'], true)) {
            throw new InvalidArgumentException('Status pembayaran tidak valid.');
        }

        // Cegah overpay di checkout juga (pakai sisa current)
        $paidSuccess = (float) $order->payments()->where('status', 'SUCCESS')->sum('amount');
        $remaining   = max(0.0, (float)$order->grand_total - $paidSuccess);
        if ($amount > $remaining) {
            throw new InvalidArgumentException('Nominal bayar melebihi sisa tagihan.');
        }

        // === KHUSUS XENDIT: buat invoice & ambil ref/URL ===
        $inv = null;
        if ($method === 'XENDIT') {
            /** @var \App\Services\XenditService $xendit */
            $xendit = app(\App\Services\XenditService::class);
            $inv = $xendit->createInvoice([
                'external_id' => 'ORD-' . $order->kode . '-' . now()->timestamp,
                'amount'      => (int) $amount,
                'description' => 'Pembayaran Order ' . $order->kode,
            ]);
        }

        $pay = new Payment();
        $pay->order_id     = $order->id;
        $pay->method       = $method;
        $pay->amount       = round($amount, 2);
        $pay->status       = $status;
        $pay->ref_no       = $method === 'XENDIT'
            ? ($inv['ref_no'] ?? null)
            : ($p['ref_no'] ?? null);
        $pay->payload_json = $method === 'XENDIT'
            ? array_filter([
                'checkout_url' => $inv['checkout_url'] ?? null,
                'xendit'       => $inv['raw'] ?? null,
            ])
            : ($p['payload_json'] ?? null);
        // paid_at hanya diisi saat SUCCESS; jika PENDING biarkan null
        $pay->paid_at      = ($status === 'SUCCESS')
            ? (isset($p['paid_at']) ? Carbon::parse($p['paid_at']) : now())
            : null;
        $pay->save();

        // Recompute paid_total from SUCCESS payments
        $order->paid_total = (float) $order->payments()
            ->where('status', 'SUCCESS')
            ->sum('amount');
        $order->save();

        if ($pay->method === 'CASH' && $pay->status === 'SUCCESS') {
            $holderId = null;
            if (!empty($pay->payload_json)) {
                $raw = is_string($pay->payload_json)
                    ? json_decode($pay->payload_json, true)
                    : $pay->payload_json;
                $holderId = $raw['holder_id'] ?? null;
            }

            if ($holderId) {
                /** @var \App\Services\CashService $cash */
                $cash = app(\App\Services\CashService::class);

                // Ambil/siapkan session aktif untuk holder tsb lalu catat transaksi + update saldo
                $cash->mirrorPaymentToHolder(
                    holderId: (int) $holderId,
                    amount: (float) $pay->amount,
                    paymentId: (int) $pay->id,
                    note: 'ORDER#' . $order->kode
                );
            }
        }
        if ($pay->status === 'SUCCESS') {
            $this->postAccountingForPayment($order, $pay);
        }
    }

    /**
     * Jika sudah lunas → tandai PAID  kurangi stok sekali (saat transisi ke PAID saja).
     */
    private function recomputeAndMaybeClose(Order $order): void
    {
        // Order sudah memiliki paid_total terbaru
        if ($order->paid_total >= $order->grand_total && $order->status !== 'PAID') {

            // Tentukan paid_at dari payment SUCCESS terbaru (fallback now)
            $lastPaidAt = $order->payments()
                ->where('status', 'SUCCESS')
                ->latest('paid_at')
                ->value('paid_at');

            $order->status  = 'PAID';
            $order->paid_at = $lastPaidAt ?: now();    // <— penting untuk period_date fee
            $order->save();

            // Kurangi stok di gudang per item (hanya sekali, saat transisi ke PAID)
            $items = $order->items()->get(['variant_id', 'qty']);
            foreach ($items as $it) {
                $this->salesInv->deductOnPaid(
                    gudangId: (int)$order->gudang_id,
                    variantId: (int)$it->variant_id,
                    qty: (float)$it->qty,
                    note: 'SALE#' . $order->kode
                );
            }

            // === NEW: generate fee entries berdasarkan rules aktif cabang ===
            $this->fees->generateForPaidOrder($order);
        }
    }

    /**
     * Resolve account mapping dari konfigurasi/setting.
     * Ganti implementasi ini agar membaca dari Settings modul milikmu (mis. table settings).
     * Key yang dipakai di sini: acc.cash_id, acc.bank_id, acc.sales_id.
     */
    private function resolveAccountId(string $key): int
    {
        // Coba baca dari helper global `setting()` jika ada
        $id = null;

        if (\function_exists('setting')) {
            /** @noinspection PhpFullyQualifiedNameUsageInspection */
            $id = \setting($key); // <— penting: leading backslash agar bukan App\Services\setting
        }

        // Fallback ke config (mis. config/accounting.php), atau mapping key sederhana
        if ($id === null) {
            // opsi 1: langsung pakai key yang sama bila kamu simpan di config('acc.*')
            $id = Config::get($key);

            // opsi 2 (opsional): map ke namespace config lain
            if ($id === null) {
                $map = [
                    'acc.cash_id'        => 'accounting.cash_id',
                    'acc.bank_id'        => 'accounting.bank_id',
                    'acc.sales_id'       => 'accounting.sales_id',
                    'acc.fee_expense_id' => 'accounting.fee_expense_id',
                    'acc.fee_payable_id' => 'accounting.fee_payable_id',
                ];
                $id = Config::get($map[$key] ?? $key);
            }
        }

        if (is_array($id)) {
            $id = $id['id'] ?? null;
        }
        // --- Pastikan integer valid ---
        $id = ($id !== null) ? (int) $id : 0;
        if ($id <= 0) {
            throw new \RuntimeException("Mapping akun '$key' belum dikonfigurasi.");
        }
        return $id;
    }

    /**
     * Buat DRAFT jurnal untuk pembayaran order yang sukses.
     * Skema default (cash-basis):
     *   - CASH/QRIS  : Debit Kas,   Kredit Pendapatan
     *   - TRANSFER   : Debit Bank,  Kredit Pendapatan
     * Ref: ORDER_PAYMENT (ref_id = payment.id)
     */
    private function postAccountingForPayment(Order $order, Payment $pay): void
    {
        /** @var AccountingService $acc */
        $acc = app(AccountingService::class);

        $isBank = in_array(strtoupper($pay->method), ['TRANSFER', 'XENDIT'], true);

        $cashId  = $this->resolveAccountId('acc.cash_id');   // Kas
        $bankId  = $this->resolveAccountId('acc.bank_id');   // Bank
        $salesId = $this->resolveAccountId('acc.sales_id');  // Pendapatan

        $debitAccountId = $isBank ? $bankId : $cashId;

        $acc->upsertDraft([
            'cabang_id'    => (int) $order->cabang_id,
            'journal_date' => $pay->paid_at?->toDateString() ?? now()->toDateString(),
            'number'       => 'PAY-' . $order->kode . '-' . $pay->id,
            'description'  => 'Pembayaran Order ' . $order->kode . ' (' . $pay->method . ')',
            'lines'        => [
                [
                    'account_id' => $debitAccountId,
                    'debit'      => (float) $pay->amount,
                    'credit'     => 0.0,
                    'ref_type'   => 'ORDER_PAYMENT',
                    'ref_id'     => (int) $pay->id,
                ],
                [
                    'account_id' => $salesId,
                    'debit'      => 0.0,
                    'credit'     => (float) $pay->amount,
                    'ref_type'   => 'ORDER_PAYMENT',
                    'ref_id'     => (int) $pay->id,
                ],
            ],
        ]);
    }

    private function generateCode(int $cabangId): string
    {
        // Placeholder: hubungkan ke modul "Kode Counter Per Cabang"
        return 'PRM-' . str_pad((string)now()->timestamp, 10, '0', STR_PAD_LEFT) . '-C' . $cabangId;
    }
}

```
</details>

### app/Services/CustomerService.php

- SHA: `6bbb915dcd74`  
- Ukuran: 6 KB  
- Namespace: `App\Services`

**Class `CustomerService`**

Metode Publik:
- **upsertByPhone**(int $cabangId, array $dto) : *Customer* — Idempotent create-or-get by phone within a branch.
- **list**(int $cabangId, array $filter = []) — Idempotent create-or-get by phone within a branch.
- **detail**(Customer $customer, int $limitOrders = 10) : *array* — Idempotent create-or-get by phone within a branch.
- **addTimeline**(Customer $customer, string $type, ?string $title, ?string $note, array $meta = []) : *void* — Idempotent create-or-get by phone within a branch.
- **setStage**(Customer $customer, string $stage) : *Customer* — Idempotent create-or-get by phone within a branch.
- **syncAggregatesAfterOrder**(int $customerId) : *void* — Idempotent create-or-get by phone within a branch.
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Services;

use App\Models\Customer;
use App\Models\CustomerTimeline;
use App\Models\Order;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

class CustomerService
{
    /** Idempotent create-or-get by phone within a branch. */
    public function upsertByPhone(int $cabangId, array $dto): Customer
    {
        // expected keys: nama, phone, email?, alamat?, catatan?
        return DB::transaction(function () use ($cabangId, $dto) {
            $phone = trim($dto['phone'] ?? '');
            if ($phone === '') {
                throw new \InvalidArgumentException('Phone is required for customer upsert.');
            }

            $existing = Customer::where('cabang_id', $cabangId)
                ->where('phone', $phone)
                ->lockForUpdate()
                ->first();

            if ($existing) {
                // optional: update simple fields if provided
                $patch = array_filter([
                    'nama'   => $dto['nama']   ?? null,
                    'email'  => $dto['email']  ?? null,
                    'alamat' => $dto['alamat'] ?? null,
                    'catatan' => $dto['catatan'] ?? null,
                ], fn($v) => !is_null($v));
                if ($patch) {
                    $existing->fill($patch)->save();
                    $this->audit('CUSTOMER_UPDATE_AUTO', 'customers', $existing->id, ['after' => $patch]);
                }
                return $existing;
            }

            $customer = new Customer([
                'cabang_id' => $cabangId,
                'nama'      => $dto['nama'] ?? 'Customer',
                'phone'     => $phone,
                'email'     => $dto['email']  ?? null,
                'alamat'    => $dto['alamat'] ?? null,
                'catatan'   => $dto['catatan'] ?? null,
                'stage'     => 'ACTIVE',
            ]);
            $customer->save();

            $this->audit('CUSTOMER_CREATE', 'customers', $customer->id, ['after' => $customer->toArray()]);

            // timeline: created
            CustomerTimeline::create([
                'customer_id' => $customer->id,
                'event_type'  => 'NOTE',
                'title'       => 'Customer created',
                'meta'        => ['source' => 'POS'],
                'happened_at' => now(),
            ]);

            return $customer;
        });
    }

    /** Listing with search + optional stage and date filters, branch-scoped. */
    public function list(int $cabangId, array $filter = [])
    {
        $q = Customer::query()->forCabang($cabangId);

        if (!empty($filter['q'])) {
            $term = '%' . str_replace(' ', '%', $filter['q']) . '%';
            $q->where(function ($w) use ($term) {
                $w->where('nama', 'ILIKE', $term)
                    ->orWhere('phone', 'ILIKE', $term)
                    ->orWhere('email', 'ILIKE', $term);
            });
        }

        if (!empty($filter['stage'])) {
            $q->where('stage', $filter['stage']);
        }

        if (!empty($filter['from']) && !empty($filter['to'])) {
            $from = Carbon::parse($filter['from'])->startOfDay();
            $to   = Carbon::parse($filter['to'])->endOfDay();
            // Include customers with no orders by falling back to created_at
            // PostgreSQL-safe: COALESCE(last_order_at, created_at)
            $q->whereRaw(
                '(COALESCE(last_order_at, created_at) BETWEEN ? AND ?)',
                [$from, $to]
            );
        }

        return $q->orderByDesc('last_order_at')->paginate($filter['per_page'] ?? 15);
    }

    /** Detailed customer with purchase summary and latest orders (optional). */
    public function detail(Customer $customer, int $limitOrders = 10): array
    {
        $orders = Order::where('customer_id', $customer->id)
            ->orderByDesc('ordered_at')
            ->limit($limitOrders)
            ->get(['id', 'kode', 'grand_total', 'status', 'ordered_at', 'paid_at']);

        return [
            'customer' => $customer,
            'orders'   => $orders,
        ];
    }

    /** Append timeline entry (ORDER/PAYMENT/STAGE/NOTE). */
    public function addTimeline(Customer $customer, string $type, ?string $title, ?string $note, array $meta = []): void
    {
        CustomerTimeline::create([
            'customer_id' => $customer->id,
            'event_type'  => $type,
            'title'       => $title,
            'note'        => $note,
            'meta'        => $meta,
            'happened_at' => now(),
        ]);
    }

    /** Update stage and log to timeline. */
    public function setStage(Customer $customer, string $stage): Customer
    {
        DB::transaction(function () use ($customer, $stage) {
            $before = $customer->stage;
            $customer->stage = $stage;
            $customer->save();

            $this->audit('CUSTOMER_STAGE', 'customers', $customer->id, [
                'before' => ['stage' => $before],
                'after'  => ['stage' => $stage],
            ]);

            $this->addTimeline($customer, 'STAGE', 'Stage updated', null, [
                'from' => $before,
                'to'   => $stage,
            ]);
        });

        return $customer->refresh();
    }

    /** Sync aggregates after an order is paid/finalized. */
    public function syncAggregatesAfterOrder(int $customerId): void
    {
        DB::transaction(function () use ($customerId) {
            $customer = Customer::lockForUpdate()->findOrFail($customerId);

            $agg = DB::table('orders')
                ->selectRaw('COUNT(*)::bigint as total_orders, COALESCE(SUM(grand_total),0)::numeric as total_spent, MAX(ordered_at) as last_order_at')
                ->where('customer_id', $customerId)
                ->whereIn('status', ['FINAL', 'PAID', 'SUCCESS']) // align to your order statuses
                ->first();

            $customer->total_orders = (int)($agg->total_orders ?? 0);
            $customer->total_spent  = $agg->total_spent ?? 0;
            $customer->last_order_at = $agg->last_order_at;
            $customer->save();
        });
    }

    private function audit(string $action, string $table, int $id, array $payload = []): void
    {
        // Plug into your real audit trail (per SOP).
        if (function_exists('logger')) {
            logger()->info('[AUDIT] ' . $action, ['table' => $table, 'id' => $id, 'payload' => $payload]);
        }
    }
}

```
</details>

### app/Services/DashboardService.php

- SHA: `f08a1b85aaf5`  
- Ukuran: 7 KB  
- Namespace: `App\Services`

**Class `DashboardService`**

Metode Publik:
- **__construct**()
- **kpis**(?int $cabangId, Carbon $from, Carbon $to) : *array*
- **chart7d**(?int $cabangId) : *array*
- **topProducts**(?int $cabangId, int $limit = 5) : *array*
- **lowStock**(?int $cabangId, ?float $threshold = null) : *array*
- **quickActions**(?int $cabangId) : *array*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Services;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Carbon;

class DashboardService
{
    private int $ttl;

    public function __construct()
    {
        $this->ttl = (int) env('DASHBOARD_TTL_SECONDS', 60);
    }

    public function kpis(?int $cabangId, Carbon $from, Carbon $to): array
    {
        $key = "dash:kpi:c{$cabangId}:{$from->toDateString()}-{$to->toDateString()}";

        return Cache::store(config('cache.default'))->remember($key, $this->ttl, function () use ($cabangId, $from, $to) {
            $orders = DB::table('orders')
                ->when($cabangId, fn($q) => $q->where('cabang_id', $cabangId))
                ->whereBetween('ordered_at', [$from, $to]);

            $paidOrders = (clone $orders)->where('status', 'PAID');

            $ordersCount = (clone $orders)->count();
            $paidCount   = (clone $paidOrders)->count();
            $revenue     = (clone $paidOrders)->sum('grand_total');

            $avgTicket   = $paidCount > 0 ? (float) ($revenue / $paidCount) : 0.0;
            $paidRate    = $ordersCount > 0 ? round(($paidCount / $ordersCount) * 100, 2) : 0.0;

            // Reconcile against payments (SUCCESS) in same period and cabang
            $paidViaPayments = DB::table('payments')
                ->join('orders', 'payments.order_id', '=', 'orders.id')
                ->when($cabangId, fn($q) => $q->where('orders.cabang_id', $cabangId))
                ->where('payments.status', 'SUCCESS')
                ->whereBetween('payments.paid_at', [$from, $to])
                ->sum('payments.amount');

            $diff = (float) $revenue - (float) $paidViaPayments;
            $isConsistent = abs($diff) < 0.01;

            return [
                'orders_total' => (int) $ordersCount,
                'orders_paid'  => (int) $paidCount,
                'revenue'      => (float) $revenue,
                'avg_ticket'   => (float) $avgTicket,
                'paid_rate_pct' => (float) $paidRate,
                'validation'   => [
                    'paid_amount_sum' => (float) $paidViaPayments,
                    'orders_vs_payments_diff' => (float) $diff,
                    'is_consistent' => $isConsistent,
                ],
            ];
        });
    }

    public function chart7d(?int $cabangId): array
    {
        $to = now()->endOfDay();
        $from = now()->subDays(6)->startOfDay();
        $key = "dash:chart7d:c{$cabangId}:{$from->toDateString()}";

        return Cache::store(config('cache.default'))->remember($key, $this->ttl, function () use ($cabangId, $from, $to) {
            $rows = DB::table('orders')
                ->selectRaw("DATE(ordered_at) as d, COUNT(*) as cnt, SUM(CASE WHEN status='PAID' THEN grand_total ELSE 0 END) as revenue")
                ->when($cabangId, fn($q) => $q->where('cabang_id', $cabangId))
                ->whereBetween('ordered_at', [$from, $to])
                ->groupBy('d')
                ->orderBy('d')
                ->get();

            $map = $rows->keyBy('d');
            $days = [];
            for ($i = 0; $i < 7; $i++) {
                $day = now()->subDays(6 - $i)->toDateString();
                $days[] = [
                    'date' => $day,
                    'orders' => (int) ($map[$day]->cnt ?? 0),
                    'revenue' => (float) ($map[$day]->revenue ?? 0),
                ];
            }
            return $days;
        });
    }

    public function topProducts(?int $cabangId, int $limit = 5): array
    {
        $key = "dash:top:c{$cabangId}:l{$limit}";

        return Cache::store(config('cache.default'))->remember($key, $this->ttl, function () use ($cabangId, $limit) {
            $rows = DB::table('order_items as oi')
                ->join('orders as o', 'oi.order_id', '=', 'o.id')
                ->when($cabangId, fn($q) => $q->where('o.cabang_id', $cabangId))
                ->where('o.status', 'PAID')
                ->groupBy('oi.variant_id', 'oi.name_snapshot')
                ->selectRaw('oi.variant_id, oi.name_snapshot as name, SUM(oi.qty) as qty, SUM(oi.line_total) as revenue')
                ->orderByDesc('qty')
                ->limit($limit)
                ->get();

            return $rows->map(fn($r) => [
                'variant_id' => (int) $r->variant_id,
                'name' => $r->name,
                'qty' => (float) $r->qty,
                'revenue' => (float) $r->revenue,
            ])->all();
        });
    }

    public function lowStock(?int $cabangId, ?float $threshold = null): array
    {
        $key = "dash:low:c{$cabangId}:t" . ($threshold ?? 'min');

        return Cache::store(config('cache.default'))->remember($key, $this->ttl, function () use ($cabangId, $threshold) {
            // Use variant_stocks + product_variants + products
            $query = DB::table('variant_stocks as vs')
                ->join('product_variants as pv', 'vs.product_variant_id', '=', 'pv.id')
                ->join('products as p', 'pv.product_id', '=', 'p.id')
                ->when($cabangId, fn($q) => $q->where('vs.cabang_id', $cabangId))
                ->selectRaw('vs.gudang_id, vs.product_variant_id, pv.sku, p.nama as product_name, vs.qty, vs.min_stok');

            if ($threshold !== null) {
                $query->where('vs.qty', '<=', $threshold);
            } else {
                $query->whereColumn('vs.qty', '<=', 'vs.min_stok');
            }

            $rows = $query->orderBy('vs.qty')->limit(50)->get();

            return $rows->map(fn($r) => [
                'gudang_id'    => (int) $r->gudang_id,
                'variant_id'   => (int) $r->product_variant_id,
                'sku'          => $r->sku,
                'name'         => $r->product_name,
                'qty_on_hand'  => (float) $r->qty,
                'min_stock'    => (float) $r->min_stok,
            ])->all();
        });
    }

    public function quickActions(?int $cabangId): array
    {
        $low = $this->lowStock($cabangId, null);
        $actions = [];

        if (!empty($low)) {
            $actions[] = [
                'type' => 'LOW_STOCK',
                'label' => 'Replenish low stock items',
                'payload' => [
                    'count' => count($low),
                    'first_sku' => $low[0]['sku'] ?? null,
                ],
            ];
        }

        $chart = $this->chart7d($cabangId);
        $y = collect($chart)->firstWhere('date', now()->subDay()->toDateString());
        if ($y && $y['orders'] > 0 && $y['revenue'] == 0.0) {
            $actions[] = [
                'type' => 'PAYMENT_CHECK',
                'label' => 'Investigate payments with PENDING/FAILED status',
            ];
        }

        return $actions;
    }
}

```
</details>

### app/Services/DeliveryService.php

- SHA: `6b07f5c3078f`  
- Ukuran: 22 KB  
- Namespace: `App\Services`

**Class `DeliveryService`**

Metode Publik:
- **createForOrder**(int $orderId, string $type, array $payload) : *Delivery* — Status terminal
- **autoAssign**(Delivery $delivery) : *Delivery* — Status terminal
- **assign**(Delivery $delivery, int $userId) : *Delivery* — Status terminal
- **updateStatus**(Delivery $delivery, string $nextStatus, ?string $note = null, ?UploadedFile $photo = null) : *Delivery* — Status terminal
- **addEvent**(Delivery $delivery, string $status, ?string $note = null, ?UploadedFile $photo = null) : *DeliveryEvent* — Status terminal
- **buildSuratJalanHtml**(Delivery $d) : *string* — Status terminal
- **buildSuratJalanMessage**(Delivery $d) : *string* — Status terminal
- **resendWASuratJalan**(Delivery $d, ?string $overrideMessage = null) : *array* — Status terminal
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Services;

use App\Models\{Delivery, DeliveryEvent, Order, Payment, User};
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\ValidationException;
use Illuminate\Filesystem\FilesystemAdapter;
use App\Services\CheckoutService;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class DeliveryService
{
    /** Status terminal */
    private const TERMINAL = ['DELIVERED', 'FAILED', 'CANCELLED'];

    /** Valid state machine */
    private const TRANSITIONS = [
        'REQUESTED' => ['ASSIGNED', 'CANCELLED'],
        'ASSIGNED'  => ['PICKED_UP', 'ON_ROUTE', 'CANCELLED'],
        'PICKED_UP' => ['ON_ROUTE', 'CANCELLED'],
        'ON_ROUTE'  => ['DELIVERED', 'FAILED', 'CANCELLED'],
        'DELIVERED' => [],
        'FAILED'    => [],
        'CANCELLED' => [],
    ];

    public function createForOrder(int $orderId, string $type, array $payload): Delivery
    {
        $order = Order::with('cabang')->findOrFail($orderId);

        return DB::transaction(function () use ($order, $type, $payload) {
            $delivery = new Delivery([
                'order_id' => $order->id,
                'type'     => $type,
                'status'   => 'REQUESTED',
                'pickup_address'   => $payload['pickup_address'] ?? null,
                'delivery_address' => $payload['delivery_address'] ?? null,
                'pickup_lat'  => $payload['pickup_lat'] ?? null,
                'pickup_lng'  => $payload['pickup_lng'] ?? null,
                'delivery_lat' => $payload['delivery_lat'] ?? null,
                'delivery_lng' => $payload['delivery_lng'] ?? null,
                'requested_at' => now(),
            ]);
            $delivery->save();

            // event awal
            DeliveryEvent::create([
                'delivery_id' => $delivery->id,
                'status' => 'REQUESTED',
                'note'   => 'Delivery requested',
                'occurred_at' => now(),
            ]);

            return $delivery;
        });
    }

    public function autoAssign(Delivery $delivery): Delivery
    {
        // ambil kurir di cabang order, urutkan by jumlah tugas aktif
        $cabangId = $delivery->order->cabang_id;

        $candidate = User::role('kurir')
            ->where('cabang_id', $cabangId)
            ->withCount(['deliveries as active_deliveries_count' => function ($q) {
                $q->whereNotIn('status', self::TERMINAL);
            }])
            ->orderBy('active_deliveries_count', 'asc')
            ->orderBy('id', 'asc')
            ->first();

        if (!$candidate) {
            throw ValidationException::withMessages(['assigned_to' => 'Tidak ada kurir tersedia di cabang ini.']);
        }

        return $this->assign($delivery, $candidate->id);
    }

    public function assign(Delivery $delivery, int $userId): Delivery
    {
        if (in_array($delivery->status, ['DELIVERED', 'FAILED', 'CANCELLED'], true)) {
            throw ValidationException::withMessages(['status' => 'Tidak bisa assign pada task yang sudah selesai.']);
        }

        return DB::transaction(function () use ($delivery, $userId) {
            $delivery->assigned_to = $userId;
            // jika masih REQUESTED, ubah ke ASSIGNED
            if ($delivery->status === 'REQUESTED') {
                $delivery->status = 'ASSIGNED';
                DeliveryEvent::create([
                    'delivery_id' => $delivery->id,
                    'status' => 'ASSIGNED',
                    'note'   => "Assigned to user #{$userId}",
                    'occurred_at' => now(),
                ]);
            }
            $delivery->save();

            return $delivery->fresh();
        });
    }

    public function updateStatus(Delivery $delivery, string $nextStatus, ?string $note = null, ?UploadedFile $photo = null): Delivery
    {
        // validasi transisi
        $allowed = self::TRANSITIONS[$delivery->status] ?? [];
        if (! in_array($nextStatus, $allowed, true)) {
            throw ValidationException::withMessages([
                'status' => "Transisi status tidak valid: {$delivery->status} → {$nextStatus}"
            ]);
        }

        return DB::transaction(function () use ($delivery, $nextStatus, $note, $photo) {
            $photoUrl = null;
            if ($photo instanceof UploadedFile) {
                $path = $photo->store("deliveries/{$delivery->id}/events", 'public');

                /** @var FilesystemAdapter $public */
                $public = Storage::disk('public');
                $photoUrl = $public->url($path);
            }

            DeliveryEvent::create([
                'delivery_id' => $delivery->id,
                'status' => $nextStatus,
                'note'   => $note,
                'photo_url' => $photoUrl,
                'occurred_at' => now(),
            ]);

            $delivery->status = $nextStatus;

            if (in_array($nextStatus, self::TERMINAL, true)) {
                $delivery->completed_at = now();
            }

            $delivery->save();

            // COD sync ketika delivered
            if ($nextStatus === 'DELIVERED') {
                $this->maybeSyncCOD($delivery);
            }

            return $delivery->fresh(['events', 'courier', 'order']);
        });
    }

    public function addEvent(Delivery $delivery, string $status, ?string $note = null, ?UploadedFile $photo = null): DeliveryEvent
    {
        $photoUrl = null;
        if ($photo instanceof UploadedFile) {
            $path = $photo->store("deliveries/{$delivery->id}/events", 'public');

            /** @var FilesystemAdapter $public */
            $public = Storage::disk('public');
            $photoUrl = $public->url($path);
        }

        return DeliveryEvent::create([
            'delivery_id' => $delivery->id,
            'status' => $status,
            'note'   => $note,
            'photo_url' => $photoUrl,
            'occurred_at' => now(),
        ]);
    }

    protected function maybeSyncCOD(Delivery $delivery): void
    {
        // lock order untuk konsistensi
        $order = $delivery->order()->lockForUpdate()->first();

        // contoh logika umum: hanya jika metode COD & belum lunas
        if (($order->payment_method ?? null) === 'COD') {
            $unpaid = max(0.0, (float)$order->grand_total - (float)$order->paid_total);
            if ($unpaid > 0) {
                /** @var CheckoutService $checkout */
                $checkout = app(CheckoutService::class);

                // Salurkan lewat jalur resmi → akan record payment + recompute + set PAID + kurangi stok + generate fee
                $checkout->addPayment($order, [
                    'method'  => 'CASH',
                    'amount'  => $unpaid,
                    'status'  => 'SUCCESS',
                    'paid_at' => now(),
                    'payload_json' => [
                        // opsional: mapping holder kas bila kamu pakai CashService mirror
                        // 'holder_id' => $someHolderId,
                        'note' => 'Auto COD on delivered',
                    ],
                ]);
            }
        }
    }

    public function buildSuratJalanHtml(Delivery $d): string
    {
        Log::info('SJ_HTML_BUILD_START', ['delivery_id' => $d->id]);
        // eager minimal bila belum
        $d->load([
            'order' => function ($qo) {
                $qo->select('id', 'kode', 'cabang_id', 'subtotal', 'discount', 'grand_total', 'paid_total', 'status', 'created_at')
                    ->with([
                        'items' => fn($qi) => $qi->select(
                            'id',
                            'order_id',
                            DB::raw('name_snapshot AS name'),
                            'qty',
                            'price',
                            DB::raw('NULL::text AS note') // kolom note tdk ada
                        ),
                        'customer:id,name,phone,address',
                        // cabang di poin #2 (lihat di bawah)
                    ]);
            },
            // 'branch' → hapus (lihat poin #2)
            'courier:id,name,phone',
        ]);

        Log::info('SJ_HTML_BUILD_DATA', [
            'delivery_id'   => $d->id,
            'order_id'      => optional($d->order)->id,
            'order_kode'    => optional($d->order)->kode,
            'subtotal'      => optional($d->order)->subtotal,
            'discount'      => optional($d->order)->discount,
            'grand_total'   => optional($d->order)->grand_total,
            'paid_total'    => optional($d->order)->paid_total,
            'status'        => optional($d->order)->status,
            'items_count'   => optional($d->order?->items)->count() ?? 0,
        ]);

        $order   = $d->order;
        $branch  = $d->branch;
        $courier = $d->courier;

        $branchName  = $branch->name  ?? 'Cabang';
        $branchAddr  = $branch->address ?? '-';
        $branchPhone = $branch->phone ?? '-';

        $sjNumber = $d->sj_number ?: $this->fallbackSJNumber($d);
        $now      = now()->format('Y-m-d H:i');
        $type     = strtoupper($d->type ?? 'DELIVERY');

        $orderCode = $order->kode ?? ('ORD#' . $order->id);
        $orderDate = optional($order->created_at)->format('Y-m-d H:i') ?? '-';

        $customerName  = optional($order->customer)->name  ?? '-';
        $customerPhone = optional($order->customer)->phone ?? '-';
        $pickupAddr    = $d->pickup_address   ?? (optional($order->customer)->address ?? '-');
        $deliveryAddr  = $d->delivery_address ?? (optional($order->customer)->address ?? '-');

        $grand = (float)($order->grand_total ?? 0);
        $paid  = (float)($order->paid_total ?? 0);
        $dueAmt = max($grand - $paid, 0);

        $paymentStatus = $dueAmt <= 0.00001 ? 'PAID' : ($paid > 0 ? 'PARTIAL' : 'UNPAID');
        $codInfo = $dueAmt > 0 ? (' (COD: ' . $this->fmtMoney($dueAmt) . ')') : '';

        // Items table
        $rows = '';
        foreach (($order->items ?? []) as $i => $it) {
            $name  = $this->e($it->name ?? $it->product_name ?? $it->item_name ?? ('Item #' . $it->id));
            $qty   = (int)($it->qty ?? 1);
            $note  = $this->e($it->note ?? '');
            $price = isset($it->price) ? $this->fmtMoney($it->price) : '';
            $sub   = (isset($it->price) ? $this->fmtMoney($it->price * $qty) : '');
            $rows .= "<tr>
                <td>" . ($i + 1) . "</td>
                <td>{$name}" . ($note ? "<br/><small>{$note}</small>" : "") . "</td>
                <td style='text-align:center'>{$qty}</td>
                <td style='text-align:right'>{$price}</td>
                <td style='text-align:right'>{$sub}</td>
            </tr>";
        }

        $totals = '';
        if (isset($order->grand_total)) {
            $subtotal = isset($order->subtotal)     ? $this->fmtMoney($order->subtotal) : '';
            $discount = isset($order->discount)     ? $this->fmtMoney($order->discount) : '';
            $tax      = isset($order->tax)          ? $this->fmtMoney($order->tax) : '';
            $service  = isset($order->service_fee)  ? $this->fmtMoney($order->service_fee) : '';
            $grand    = $this->fmtMoney($order->grand_total ?? 0);
            $paid     = isset($order->paid_total)   ? $this->fmtMoney($order->paid_total) : '';
            $dueAmt   = max(($order->grand_total ?? 0) - ($order->paid_total ?? 0), 0);
            $due      = $this->fmtMoney($dueAmt);

            $totals = "
    <tr><td colspan='3'></td><td>Subtotal</td><td style='text-align:right'>{$subtotal}</td></tr>
    <tr><td colspan='3'></td><td>Diskon</td><td style='text-align:right'>{$discount}</td></tr>" .
                ($tax !== '' ? "<tr><td colspan='3'></td><td>Pajak</td><td style='text-align:right'>{$tax}</td></tr>" : "") .
                ($service !== '' ? "<tr><td colspan='3'></td><td>Service</td><td style='text-align:right'>{$service}</td></tr>" : "") .
                "<tr><td colspan='3'></td><td><b>Grand Total</b></td><td style='text-align:right'><b>{$grand}</b></td></tr>
    <tr><td colspan='3'></td><td>Dibayar</td><td style='text-align:right'>{$paid}</td></tr>
    <tr><td colspan='3'></td><td>Sisa/COD</td><td style='text-align:right'>{$due}</td></tr>";
        }

        $qrText = url("/deliveries/{$d->id}/note");
        $courierLine = $courier ? $this->e("{$courier->name} (WA: {$courier->phone})") : '-';

        Log::info('SJ_HTML_BUILD_DONE', ['delivery_id' => $d->id]);
        return <<<HTML
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Surat Jalan {$this->e($sjNumber)}</title>
<style>
  body { font-family: ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, Arial; font-size: 12px; color: #111; }
  .wrap { max-width: 720px; margin: 0 auto; padding: 16px; }
  .row { display: flex; gap: 16px; }
  .col { flex: 1; }
  .header { border-bottom: 2px solid #000; margin-bottom: 8px; padding-bottom: 8px; }
  h1 { font-size: 16px; margin: 0; }
  table { width: 100%; border-collapse: collapse; margin-top: 8px; }
  th, td { border: 1px solid #ddd; padding: 6px; vertical-align: top; }
  th { background: #f3f4f6; text-align: left; }
  .meta { font-size: 12px; line-height: 1.6; }
  .muted { color: #666; }
  .sign { height: 64px; border-bottom: 1px dashed #999; margin-top: 24px; }
  .footnote { margin-top: 8px; font-size: 11px; color: #444; }
  .qr { font-size: 11px; color: #555; margin-top: 8px; }
  .btn-print { margin: 8px 0 16px; }
  @media print { .btn-print { display: none; } }
</style>
</head>
<body>
<div class="wrap">
  <div class="header row">
    <div class="col">
      <div><strong>{$this->e($branchName)}</strong></div>
      <div class="muted">{$this->e($branchAddr)}</div>
      <div class="muted">Tel: {$this->e($branchPhone)}</div>
    </div>
    <div class="col" style="text-align:right;">
      <h1>SURAT JALAN</h1>
      <div class="meta">No: <b>{$this->e($sjNumber)}</b></div>
      <div class="meta">Dicetak: {$this->e($now)}</div>
    </div>
  </div>

  <button class="btn-print" onclick="window.print()">🖨 Cetak</button>

  <table>
    <tr>
      <th style="width: 25%;">Tipe</th><td>{$this->e($type)}</td>
      <th style="width: 25%;">Status Pembayaran</th><td>{$this->e($paymentStatus)}{$this->e($codInfo)}</td>
    </tr>
    <tr>
      <th>Ref Order</th><td>{$this->e($orderCode)} ({$this->e($orderDate)})</td>
      <th>Kurir</th><td>{$courierLine}</td>
    </tr>
    <tr>
      <th>Alamat Pickup</th><td>{$this->e($pickupAddr)}</td>
      <th>Alamat Delivery</th><td>{$this->e($deliveryAddr)}</td>
    </tr>
  </table>

  <table>
    <thead>
      <tr>
        <th style="width:40px;">No</th>
        <th>Item/Layanan</th>
        <th style="width:64px; text-align:center;">Qty</th>
        <th style="width:100px; text-align:right;">Harga</th>
        <th style="width:120px; text-align:right;">Subtotal</th>
      </tr>
    </thead>
    <tbody>
      {$rows}
      {$totals}
    </tbody>
  </table>

  <div class="row" style="margin-top: 12px;">
    <div class="col">
      <div><b>Checklist</b></div>
      <div class="muted">[ ] Jumlah paket cocok<br/>[ ] Segel/packaging aman<br/>[ ] Catatan khusus diikuti</div>
      <div class="qr">QR: {$this->e($qrText)}</div>
    </div>
    <div class="col">
      <div><b>Tanda Terima</b></div>
      <div class="sign"></div>
      <div class="muted">Nama Jelas & Tanggal/Jam</div>
    </div>
  </div>

  <div class="footnote">
    S&K Ringkas: Klaim kerusakan/kehilangan maks 24 jam setelah terima. Hubungi CS Cabang jika ada kendala.
  </div>
</div>
</body>
</html>
HTML;
    }

    public function buildSuratJalanMessage(Delivery $d): string
    {
        Log::info('SJ_MSG_BUILD_START', ['delivery_id' => $d->id]);
        $d->load([
            'order' => function ($qo) {
                $qo->select('id', 'kode', 'cabang_id', 'subtotal', 'discount', 'grand_total', 'paid_total', 'status', 'created_at')
                    ->with([
                        'items' => fn($qi) => $qi->select(
                            'id',
                            'order_id',
                            DB::raw('name_snapshot AS name'),
                            'qty',
                            'price',
                            DB::raw('NULL::text AS note')
                        ),
                        'customer:id,name,phone,address',
                    ]);
            },
        ]);

        Log::info('SJ_MSG_BUILD_DATA', [
            'delivery_id' => $d->id,
            'order_id'    => optional($d->order)->id,
            'order_kode'  => optional($d->order)->kode,
            'grand_total' => optional($d->order)->grand_total,
            'paid_total'  => optional($d->order)->paid_total,
        ]);

        $order = $d->order;

        $sj    = $d->sj_number ?: $this->fallbackSJNumber($d);
        $type  = strtoupper($d->type ?? 'DELIVERY');
        $ocode = $order->kode ?? ('ORD#' . $order->id);
        $odate = optional($order->created_at)->format('Y-m-d H:i') ?? '-';

        $cust   = optional($order->customer)->name ?? '-';
        $cphone = optional($order->customer)->phone ?? '-';
        $pick   = $d->pickup_address   ?? (optional($order->customer)->address ?? '-');
        $drop   = $d->delivery_address ?? (optional($order->customer)->address ?? '-');

        $grand = (float)($order->grand_total ?? 0);
        $paid  = (float)($order->paid_total ?? 0);
        $due   = max($grand - $paid, 0);
        $paySt = $due <= 0.00001 ? 'PAID' : ($paid > 0 ? 'PARTIAL' : 'UNPAID');
        $cod   = $due > 0 ? (' (COD: ' . $this->fmtMoney($due) . ')') : '';

        $items = $order->items ?? [];
        $summ  = $items ? implode(', ', array_map(
            fn($it) => (($it->name ?? $it->product_name ?? $it->item_name ?? 'Item') . ' x' . (int)($it->qty ?? 1)),
            $items
        )) : '-';

        $noteUrl = url("/deliveries/{$d->id}/note");
        $maps    = $d->maps_url ?? '';
        $notes   = trim((string)($d->notes ?? ''));

        $text = "Surat Jalan #{$sj}\n"
            . "Tipe: {$type}\n"
            . "Order: {$ocode} ({$odate})\n"
            . "Ambil: {$pick}\n"
            . "Kirim ke: {$drop}\n"
            . "Customer: {$cust} ({$cphone})\n"
            . "Item: {$summ}\n"
            . "Pembayaran: {$paySt}{$cod}\n"
            . ($noteUrl ? "Link SJ: {$noteUrl}\n" : "")
            . ($maps ? "Maps: {$maps}\n" : "")
            . ($notes ? "Catatan: {$notes}\n" : "")
            . "Terima kasih.";
        Log::info('SJ_MSG_BUILD_DONE', ['delivery_id' => $d->id]);
        return $text;
    }

    public function resendWASuratJalan(Delivery $d, ?string $overrideMessage = null): array
    {
        Log::info('SJ_WA_SEND_START', ['delivery_id' => $d->id]);

        $d->load([
            'courier:id,name,phone',
            'order' => function ($qo) {
                $qo->select('id', 'kode', 'cabang_id', 'subtotal', 'discount', 'grand_total', 'paid_total', 'status', 'created_at')
                    ->with([
                        'items' => fn($qi) => $qi->select(
                            'id',
                            'order_id',
                            DB::raw('name_snapshot AS name'),
                            'qty',
                            'price',
                            DB::raw('NULL::text AS note')
                        ),
                        'customer:id,name,phone,address',
                    ]);
            },
        ]);

        Log::info('SJ_WA_SEND_DATA', [
            'delivery_id' => $d->id,
            'courier_id'  => optional($d->courier)->id,
            'courier_phone' => optional($d->courier)->phone,
            'order_id'    => optional($d->order)->id,
            'order_kode'  => optional($d->order)->kode,
        ]);

        $courier = $d->courier;
        if (!$courier || !$courier->phone) {
            return ['message' => 'Nomor WhatsApp kurir tidak tersedia'];
        }

        $phone = $this->sanitizePhone($courier->phone);
        $text  = $overrideMessage ?: $this->buildSuratJalanMessage($d);
        $waUrl = $this->buildWAUrl($phone, $text);

        // Audit aman (tanpa kolom occurred_at bila table kamu tidak punya)
        try {
            DB::table('audit_logs')->insert([
                'actor_type' => 'USER',
                'actor_id'   => Auth::id(),
                'action'     => 'DELIVERY_WA_SURAT_JALAN',
                'model'      => 'Delivery',
                'model_id'   => $d->id,
                'diff_json'  => json_encode(['wa_url' => $waUrl]),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        } catch (\Throwable $e) {
            // ignore log error
        }

        // Set nomor SJ saat pertama kali kirim (opsional)
        if (!$d->sj_number) {
            $d->sj_number   = $this->generateSJNumber($d);
            $d->sj_issued_at = now();
            $d->save();
        }

        return ['message' => 'OK', 'wa_url' => $waUrl];
    }

    /** ===== Helpers SJ/WA ===== */

    protected function sanitizePhone(?string $phone): string
    {
        $digits = preg_replace('/\D+/', '', (string)$phone);
        if (\Illuminate\Support\Str::startsWith($digits, '0')) {
            $digits = '62' . substr($digits, 1);
        }
        return $digits;
    }

    protected function buildWAUrl(string $phone, string $text): string
    {
        return 'https://wa.me/' . $phone . '?text=' . rawurlencode($text);
    }

    protected function fmtMoney(float|int $n): string
    {
        return 'Rp ' . number_format((float)$n, 0, ',', '.');
    }

    protected function e(string $s): string
    {
        return e($s);
    }

    protected function fallbackSJNumber(Delivery $d): string
    {
        $d->loadMissing(['order.cabang']);
        $nm = $d->order?->cabang?->nama ?? 'CABANG';
        // bikin 2–3 huruf kode dari nama cabang
        $code = strtoupper(substr(preg_replace('/[^A-Za-z]/', '', $nm), 0, 3)) ?: 'CBG';
        return 'SJ-' . $code . '-' . now()->format('Ymd') . '-' . str_pad((string)$d->id, 5, '0', STR_PAD_LEFT);
    }

    protected function generateSJNumber(Delivery $d): string
    {
        // Gampang & deterministik; kalau mau pakai counter, ganti di sini.
        return $this->fallbackSJNumber($d);
    }
}

```
</details>

### app/Services/FeeService.php

- SHA: `0fbad7cf031a`  
- Ukuran: 15 KB  
- Namespace: `App\Services`

**Class `FeeService`**

Metode Publik:
- **generateForPaidOrder**(Order $order) : *void* — Generate fee entries when an order turns PAID.
- **listEntries**(User $actor, array $filters) — Generate fee entries when an order turns PAID.
- **markPaid**(array $entryIds, string $status, string $paidAmount = '0', ?string $paidAt = null) : *int* — Generate fee entries when an order turns PAID.
- **exportCsv**(User $actor, array $filters) : *StreamedResponse* — Generate fee entries when an order turns PAID.
- **paginate**(array $filters, int $perPage = 15) — Generate fee entries when an order turns PAID.
- **create**(array $dto) : *\App\Models\Fee* — Generate fee entries when an order turns PAID.
- **update**(\App\Models\Fee $fee, array $dto) : *\App\Models\Fee* — Generate fee entries when an order turns PAID.
- **delete**(\App\Models\Fee $fee) : *void* — Generate fee entries when an order turns PAID.
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Services;

use App\Models\Fee;
use App\Models\FeeEntry;
use App\Models\Delivery;
use App\Models\Order;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Carbon;
use Symfony\Component\HttpFoundation\StreamedResponse;
use Illuminate\Support\Facades\Log;
use App\Services\AccountingService;
use InvalidArgumentException;

class FeeService
{
    /* ---------------- Role helpers (match DB  Spatie  users.role) ---------------- */
    private function has(User $u, string $role): bool
    {
        // Accept either Spatie role OR users.role column
        return $u->hasRole($role) || $u->role === $role;
    }
    private function isSuper(User $u): bool
    {
        return $this->has($u, 'superadmin');
    }
    private function isAdmin(User $u): bool
    {
        return $this->has($u, 'admin_cabang');
    }
    private function isKasir(User $u): bool
    {
        return $this->has($u, 'kasir');
    }
    private function isKurir(User $u): bool
    {
        return $this->has($u, 'kurir');
    }
    private function isSales(User $u): bool
    {
        return $this->has($u, 'sales');
    }
    private function accId(string $key): ?int
    {
        try {
            if (function_exists('setting')) {
                $v = setting($key);
                if ($v !== null && $v !== '' && (int)$v > 0) {
                    return (int) $v;
                }
            }
        } catch (\Throwable $e) {
        }
        return null;
    }
    /** Generate fee entries when an order turns PAID. */
    public function generateForPaidOrder(Order $order): void
    {
        // Adjust these field names if needed
        $cabangId   = $order->cabang_id;
        $grandTotal = (string) $order->grand_total;
        $eventDate  = Carbon::parse($order->paid_at ?? $order->updated_at)->toDateString();

        // SALES/CASHIER fees based on GRAND_TOTAL
        $fees = Fee::query()
            ->where('cabang_id', $cabangId)
            ->where('is_active', true)
            ->where('base', 'GRAND_TOTAL')
            ->get();

        foreach ($fees as $fee) {
            $baseAmount = $grandTotal;
            if ($fee->calc_type === 'PERCENT') {
                if (\function_exists('bcmul') && \function_exists('bcdiv')) {
                    $feeAmount = bcdiv(bcmul($baseAmount, (string)$fee->rate, 4), '100', 2);
                } else {
                    $feeAmount = number_format(((float)$baseAmount * (float)$fee->rate) / 100, 2, '.', '');
                }
            } else {
                $feeAmount = number_format((float) $fee->rate, 2, '.', '');
            }

            // who earns this (owner)
            $ownerUserId = null;
            if ($fee->kind === 'CASHIER') {
                // Try cashier_id first, fallback to created_by
                $ownerUserId = $order->cashier_id ?? $order->created_by ?? null;
            } elseif ($fee->kind === 'SALES') {
                $ownerUserId = $order->sales_id ?? null; // if exists
            }

            // idempotent upsert
            $createdEntry = DB::transaction(function () use ($fee, $order, $cabangId, $eventDate, $baseAmount, $feeAmount, $ownerUserId) {
                $entry = FeeEntry::query()->firstOrNew([
                    'fee_id'   => $fee->id,
                    'ref_type' => 'ORDER',
                    'ref_id'   => $order->id,
                ]);

                $entry->cabang_id     = $cabangId;
                $entry->period_date   = $eventDate;
                $entry->owner_user_id = $ownerUserId;
                $entry->base_amount   = $baseAmount;
                $entry->fee_amount    = $feeAmount;

                if (!$entry->exists) {
                    $entry->created_by = Auth::id();
                }
                $entry->updated_by = Auth::id();
                $entry->save();

                return $entry;
            });

            // === Hook akuntansi: akru fee (Beban Fee (D) vs Hutang Fee (K)) ===
            $this->postAccrualForFee($createdEntry, $order);
        }

        // TODO: If you want COURIER fees on DELIVERY completion, implement a similar
        // path in your Delivery complete handler using base='DELIVERY'.
        // This service already supports DELIVERY ref types.
    }

    private function postAccrualForFee(FeeEntry $entry, Order $order): void
    {
        $feeExpenseId = $this->accId('acc.fee_expense_id');  // Beban Fee
        $feePayableId = $this->accId('acc.fee_payable_id');  // Hutang Fee

        if (!$feeExpenseId || !$feePayableId) {
            return; // setting belum lengkap → jangan mem-post jurnal
        }

        try {
            /** @var AccountingService $acc */
            $acc = app(AccountingService::class);

            $acc->upsertDraft([
                'cabang_id'    => (int) $entry->cabang_id,
                'journal_date' => $entry->period_date?->toDateString() ?? now()->toDateString(),
                'number'       => 'FEE-ACCR-' . $entry->id, // idempotent by (cabang, number)
                'description'  => 'Akru Fee order #' . $order->kode,
                'lines'        => [
                    ['account_id' => $feeExpenseId, 'debit' => (float)$entry->fee_amount, 'credit' => 0,                    'ref_type' => 'FEE_ENTRY', 'ref_id' => $entry->id],
                    ['account_id' => $feePayableId, 'debit' => 0,                             'credit' => (float)$entry->fee_amount, 'ref_type' => 'FEE_ENTRY', 'ref_id' => $entry->id],
                ],
            ]);
        } catch (\Throwable $e) {
            // jangan ganggu proses utama bila akuntansi gagal
            Log::warning('[FeeService] postAccrualForFee failed: ' . $e->getMessage(), ['entry' => $entry->id]);
        }
    }

    /** List entries branch-aware and role-aware. */
    public function listEntries(User $actor, array $filters)
    {
        // Accept both {date_from,date_to} and {from,to}, {status}=pay_status, {mine}
        $from = $filters['from']      ?? $filters['date_from'] ?? null;
        $to   = $filters['to']        ?? $filters['date_to']   ?? null;
        $stat = $filters['pay_status'] ?? $filters['status']    ?? null; // UNPAID|PAID|PARTIAL
        $mine = isset($filters['mine']) ? (int)$filters['mine'] === 1 : false;
        $role = $filters['role']      ?? null; // SALES|CASHIER|COURIER (from fees.kind)
        $sort = $filters['sort']      ?? '-period_date'; // period_date | -period_date | amount | -amount | status | -status

        $q = FeeEntry::query()
            ->with(['fee'])
            ->when(isset($filters['cabang_id']), fn($x) => $x->where('cabang_id', $filters['cabang_id']))
            ->when($from !== null, fn($x) => $x->whereDate('period_date', '>=', $from))
            ->when($to !== null,   fn($x) => $x->whereDate('period_date', '<=', $to))
            ->when($stat !== null, fn($x) => $x->where('pay_status', $stat))
            ->when($role !== null, fn($x) => $x->whereHas('fee', fn($w) => $w->where('kind', $role)));

        // Role-visibility: sales/cashier/courier see only their own
        $isAdmin = $this->isSuper($actor) || $this->isAdmin($actor);
        $isStaff = $this->isSales($actor) || $this->isKasir($actor) || $this->isKurir($actor);
        if ($isStaff && !$isAdmin) {
            $q->where('owner_user_id', $actor->id);
        } else {
            // Admins: if ?mine=1 is passed, show only their entries; else default to branch scope when cabang_id missing
            if ($mine) {
                $q->where('owner_user_id', $actor->id);
            } elseif (!isset($filters['cabang_id']) && ($actor->cabang_id ?? null)) {
                $q->where('cabang_id', $actor->cabang_id);
            }
        }

        $map = [
            'period_date'  => ['period_date', 'asc'],
            '-period_date' => ['period_date', 'desc'],
            'amount'       => ['fee_amount', 'asc'],
            '-amount'      => ['fee_amount', 'desc'],
            'status'       => ['pay_status', 'asc'],
            '-status'      => ['pay_status', 'desc'],
        ];
        [$col, $dir] = $map[$sort] ?? ['period_date', 'desc'];

        return $q->orderBy($col, $dir)->paginate($filters['per_page'] ?? 20);
    }

    /** Mark entries as paid/partial paid. */
    public function markPaid(array $entryIds, string $status, string $paidAmount = '0', ?string $paidAt = null): int
    {
        $paidAt = $paidAt ? Carbon::parse($paidAt) : now();

        return DB::transaction(function () use ($entryIds, $status, $paidAmount, $paidAt) {
            $count = 0;
            foreach ($entryIds as $id) {
                $entry = FeeEntry::lockForUpdate()->findOrFail($id);

                if ($status === 'PAID') {
                    $entry->paid_amount = $entry->fee_amount;
                } elseif ($status === 'PARTIAL') {
                    $entry->paid_amount = $paidAmount;
                }

                $entry->pay_status = $status;
                $entry->paid_at    = $paidAt;
                $entry->updated_by = Auth::id();
                $entry->save();

                // audit
                if (method_exists($this, 'audit')) {
                    $this->auditSafe('FEE_STATUS_UPDATE', 'fee_entries', $entry->id, [
                        'after' => $entry->toArray(),
                    ]);
                }

                // === Hook akuntansi: pelunasan Hutang Fee ===
                if (in_array($status, ['PAID', 'PARTIAL'], true)) {
                    // pakai paid_amount aktual; untuk PARTIAL, kamu sudah set dari $paidAmount
                    $this->postPaymentForFee($entry, $paidAt);
                }

                $count++;
            }
            return $count;
        });
    }

    private function postPaymentForFee(FeeEntry $entry, \Illuminate\Support\Carbon $paidAt): void
    {
        $feePayableId = $this->accId('acc.fee_payable_id'); // Hutang Fee
        // Default pakai Kas; jika ingin bedakan Bank, tambahkan logika sesuai metode
        $cashId       = $this->accId('acc.cash_id');

        if (!$feePayableId || !$cashId) {
            return; // setting belum lengkap
        }

        $amount = (float) ($entry->paid_amount ?? 0);
        if ($amount <= 0) {
            return; // tidak ada nilai yang dibayar
        }

        try {
            /** @var AccountingService $acc */
            $acc = app(AccountingService::class);

            $acc->upsertDraft([
                'cabang_id'    => (int) $entry->cabang_id,
                'journal_date' => $paidAt->toDateString(),
                'number'       => 'FEE-PAY-' . $entry->id, // idempotent by (cabang, number)
                'description'  => 'Pembayaran Fee #' . $entry->id,
                'lines'        => [
                    ['account_id' => $feePayableId, 'debit' => $amount, 'credit' => 0,       'ref_type' => 'FEE_PAY', 'ref_id' => $entry->id],
                    ['account_id' => $cashId,       'debit' => 0,       'credit' => $amount, 'ref_type' => 'FEE_PAY', 'ref_id' => $entry->id],
                ],
            ]);
        } catch (\Throwable $e) {
            Log::warning('[FeeService] postPaymentForFee failed: ' . $e->getMessage(), ['entry' => $entry->id]);
        }
    }

    /** Export CSV stream. */
    public function exportCsv(User $actor, array $filters): StreamedResponse
    {
        $rows = $this->listEntries($actor, array_merge($filters, ['per_page' => 100000]))->getCollection();

        $headers = [
            'Content-Type'        => 'text/csv',
            'Content-Disposition' => 'attachment; filename="fee_entries.csv"',
        ];

        return response()->stream(function () use ($rows) {
            $out = fopen('php://output', 'w');
            fputcsv($out, ['id', 'period_date', 'cabang_id', 'kind', 'ref_type', 'ref_id', 'owner_user_id', 'base_amount', 'fee_amount', 'pay_status', 'paid_amount', 'paid_at']);
            foreach ($rows as $r) {
                fputcsv($out, [
                    $r->id,
                    $r->period_date?->toDateString(),
                    $r->cabang_id,
                    $r->fee?->kind,
                    $r->ref_type,
                    $r->ref_id,
                    $r->owner_user_id,
                    $r->base_amount,
                    $r->fee_amount,
                    $r->pay_status,
                    $r->paid_amount,
                    optional($r->paid_at)->toDateTimeString()
                ]);
            }
            fclose($out);
        }, 200, $headers);
    }

    /**
     * Linter-safe audit bridge.
     * - Uses is_callable + call_user_func to avoid direct global calls that trigger P1010.
     * - Tries a global function 'audit', then a container binding 'audit.logger'.
     * - Falls back to a warning log if nothing is available.
     */
    private function auditSafe(string $action, string $table, int|string $id, array $payload = []): void
    {
        try {
            // Prefer a global helper function named "audit"
            if (\is_callable('audit')) {
                \call_user_func('audit', $action, $table, $id, $payload);
                return;
            }

            // Or a container service bound as "audit.logger" with a ->log(...) method
            if (\app()->bound('audit.logger')) {
                \app('audit.logger')->log($action, $table, $id, $payload);
                return;
            }
        } catch (\Throwable $e) {
            Log::warning('[FeeService] auditSafe failed: ' . $e->getMessage(), [
                'action' => $action,
                'table'  => $table,
                'row_id' => $id,
            ]);
        }
    }

    public function paginate(array $filters, int $perPage = 15) // <- rename
    {
        $q = Fee::query();

        if (!empty($filters['cabang_id'])) {
            $q->where('cabang_id', $filters['cabang_id']);
        }
        if (!empty($filters['kind'])) {
            $q->where('kind', $filters['kind']);
        }
        if (array_key_exists('is_active', $filters) && $filters['is_active'] !== null) {
            $q->where('is_active', (bool)$filters['is_active']);
        }
        if (!empty($filters['base'])) {
            $q->where('base', $filters['base']);
        }
        if (!empty($filters['q'])) {
            $q->where('name', 'like', '%' . $filters['q'] . '%');
        }

        $sort = $filters['sort'] ?? '-created_at';
        $dir  = str_starts_with($sort, '-') ? 'desc' : 'asc';
        $col  = ltrim($sort, '-');
        $q->orderBy($col, $dir);

        return $q->paginate($perPage)->appends($filters);
    }

    public function create(array $dto): \App\Models\Fee
    {
        return DB::transaction(function () use ($dto) {
            $dto['created_by'] = Auth::id();
            $dto['updated_by'] = Auth::id();
            return \App\Models\Fee::create($dto);
        });
    }

    public function update(\App\Models\Fee $fee, array $dto): \App\Models\Fee
    {
        return DB::transaction(function () use ($fee, $dto) {
            $dto['updated_by'] = Auth::id();
            $fee->fill($dto)->save();
            return $fee;
        });
    }

    public function delete(\App\Models\Fee $fee): void
    {
        DB::transaction(function () use ($fee) {
            $fee->delete();
        });
    }
}

```
</details>

### app/Services/GudangService.php

- SHA: `7a9233ee4bef`  
- Ukuran: 4 KB  
- Namespace: `App\Services`

**Class `GudangService`**

Metode Publik:
- **queryIndexForUser**($user) : *Builder*
- **create**(array $data, $user) : *Gudang*
- **update**(Gudang $gudang, array $data, $user) : *Gudang* — @var Gudang $gudang
- **delete**(Gudang $gudang, $user) : *void* — @var Gudang $gudang
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Services;

use App\Models\Gudang;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class GudangService
{
    public function queryIndexForUser($user): Builder
    {
        return Gudang::query()
            ->when($user->role !== 'superadmin', fn ($q) => $q->where('cabang_id', $user->cabang_id));
    }

    public function create(array $data, $user): Gudang
    {
        // Admin Cabang hanya boleh di cabang miliknya
        if ($user->role === 'admin_cabang' && (int)$data['cabang_id'] !== (int)$user->cabang_id) {
            throw ValidationException::withMessages(['cabang_id' => 'Tidak diizinkan membuat gudang di cabang lain.']);
        }

        return DB::transaction(function () use ($data) {
            /** @var Gudang $gudang */
            $gudang = Gudang::create([
                'cabang_id'  => $data['cabang_id'],
                'nama'       => $data['nama'],
                'is_default' => (bool)($data['is_default'] ?? false),
                'is_active'  => (bool)($data['is_active'] ?? true),
            ]);

            if ($gudang->is_default) {
                // matikan default lainnya
                Gudang::where('cabang_id', $gudang->cabang_id)
                    ->where('id', '!=', $gudang->id)
                    ->where('is_default', true)
                    ->update(['is_default' => false]);
            } else {
                // jika belum ada default di cabang ini, set yang baru ini jadi default
                $hasDefault = Gudang::where('cabang_id', $gudang->cabang_id)->where('is_default', true)->exists();
                if (!$hasDefault) {
                    $gudang->is_default = true;
                    $gudang->save();
                }
            }

            return $gudang->fresh();
        });
    }

    public function update(Gudang $gudang, array $data, $user): Gudang
    {
        if ($user->role === 'admin_cabang' && (int)$gudang->cabang_id !== (int)$user->cabang_id) {
            throw ValidationException::withMessages(['gudang' => 'Tidak diizinkan mengubah gudang di cabang lain.']);
        }

        return DB::transaction(function () use ($gudang, $data) {
            $gudang->fill($data)->save();

            if (array_key_exists('is_default', $data) && $gudang->is_default) {
                Gudang::where('cabang_id', $gudang->cabang_id)
                    ->where('id', '!=', $gudang->id)
                    ->where('is_default', true)
                    ->update(['is_default' => false]);
            }

            // pastikan selalu ada default
            $hasDefault = Gudang::where('cabang_id', $gudang->cabang_id)->where('is_default', true)->exists();
            if (!$hasDefault) {
                $gudang->is_default = true;
                $gudang->save();
            }

            return $gudang->fresh();
        });
    }

    public function delete(Gudang $gudang, $user): void
    {
        if ($user->role === 'admin_cabang' && (int)$gudang->cabang_id !== (int)$user->cabang_id) {
            throw ValidationException::withMessages(['gudang' => 'Tidak diizinkan menghapus gudang di cabang lain.']);
        }

        DB::transaction(function () use ($gudang) {
            $cabangId = $gudang->cabang_id;
            $wasDefault = $gudang->is_default;

            $gudang->delete();

            if ($wasDefault) {
                $another = Gudang::where('cabang_id', $cabangId)->orderBy('id')->first();
                if ($another && !$another->is_default) {
                    $another->is_default = true;
                    $another->save();
                }
            }
        });
    }
}

```
</details>

### app/Services/OrderService.php

- SHA: `bf4f6604759d`  
- Ukuran: 13 KB  
- Namespace: `App\Services`

**Class `OrderService`**

Metode Publik:
- **list**(array $filter, ?int $userCabangId = null) : *LengthAwarePaginator* — List orders + filter by cabang/status/date/search
- **updateItems**(Order $order, array $payload, int $actorId) : *Order* — List orders + filter by cabang/status/date/search
- **reprintReceipt**(Order $order, ?string $format, int $actorId) : *array* — List orders + filter by cabang/status/date/search
- **resendWA**(Order $order, string $phone, ?string $message, int $actorId) : *array* — List orders + filter by cabang/status/date/search
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\Order;
use App\Models\OrderItem;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Carbon\Carbon;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class OrderService
{
    /**
     * List orders + filter by cabang/status/date/search
     */
    public function list(array $filter, ?int $userCabangId = null): LengthAwarePaginator
    {
        $q = Order::query()
            ->with(['items', 'payments'])
            ->when($userCabangId, fn($qq) => $qq->where('cabang_id', $userCabangId))
            ->when($filter['cabang_id'] ?? null, fn($qq, $v) => $qq->where('cabang_id', $v))
            ->when($filter['status'] ?? null, fn($qq, $v) => $qq->where('status', $v))
            ->when($filter['date_from'] ?? null, fn($qq, $v) => $qq->whereDate('ordered_at', '>=', $v))
            ->when($filter['date_to'] ?? null, fn($qq, $v) => $qq->whereDate('ordered_at', '<=', $v))
            ->when($filter['search'] ?? null, function ($qq, $v) {
                $like = "%{$v}%";
                $qq->where(function ($w) use ($like) {
                    $w->where('kode', 'like', $like)
                        ->orWhere('note', 'like', $like);
                });
            })
            ->orderByDesc('ordered_at');

        $perPage = (int)($filter['per_page'] ?? 10);
        return $q->paginate($perPage);
    }

    /**
     * Update items (add/update/remove) + recalc totals + audit diff.
     * Only for DRAFT/UNPAID by default (policy enforces).
     */
    public function updateItems(Order $order, array $payload, int $actorId): Order
    {
        return DB::transaction(function () use ($order, $payload, $actorId) {
            $before = $this->snapshot($order);

            // Remove items
            foreach (($payload['remove_item_ids'] ?? []) as $rid) {
                OrderItem::where('order_id', $order->id)->where('id', $rid)->delete();
            }

            // Upsert items
            foreach ($payload['items'] as $row) {
                // normalize numeric fields
                $price    = (float)($row['price'] ?? 0);
                $discount = (float)($row['discount'] ?? 0);
                $qty      = (float)($row['qty'] ?? 0);
                $line     = ($price - $discount) * $qty;

                if (!empty($row['id'])) {
                    // UPDATE existing row: do NOT null-out variant_id/name unless explicitly sent
                    /** @var \App\Models\OrderItem|null $existing */
                    $existing = OrderItem::where('order_id', $order->id)
                        ->where('id', $row['id'])
                        ->firstOrFail();

                    $update = [
                        'price'      => $price,
                        'discount'   => $discount,
                        'qty'        => $qty,
                        'line_total' => $line,
                    ];

                    // only set variant_id if present in payload
                    if (array_key_exists('variant_id', $row) && $row['variant_id'] !== null) {
                        $update['variant_id'] = (int)$row['variant_id'];
                    }

                    // only set name_snapshot if provided (avoid writing empty string if your column is NOT NULL)
                    if (isset($row['name']) && trim((string)$row['name']) !== '') {
                        $update['name_snapshot'] = (string)$row['name'];
                    }

                    $existing->update($update);
                } else {
                    // INSERT new row: variant_id REQUIRED
                    // (Your FormRequest already enforces required_without:id; here we assert)
                    if (empty($row['variant_id'])) {
                        throw new \InvalidArgumentException('variant_id is required for new items.');
                    }

                    OrderItem::create([
                        'order_id'      => $order->id,
                        'variant_id'    => (int)$row['variant_id'],
                        'name_snapshot' => (string)($row['name'] ?? ''), // ensure non-null; prefer real name if available
                        'price'         => $price,
                        'discount'      => $discount,
                        'qty'           => $qty,
                        'line_total'    => $line,
                    ]);
                }
            }

            // Recalculate totals
            $sum = OrderItem::where('order_id', $order->id)
                ->selectRaw('SUM(line_total) as subtotal')
                ->first();
            $order->subtotal = (float)($sum->subtotal ?? 0);
            // discount/tax/service_fee dipertahankan (jika ada logic lain, atur di sini)
            $order->grand_total = $order->subtotal - (float)$order->discount + (float)$order->tax + (float)$order->service_fee;
            $order->save();

            $after = $this->snapshot($order);
            $this->audit('ORDER_ITEMS_UPDATED', $order, [
                'before' => $before,
                'after'  => $after,
                'note'   => $payload['note'] ?? null,
            ], $actorId);

            return $order->load(['items', 'payments']);
        });
    }

    /**
     * Generate receipt HTML snapshot (server-side) & return printable payload.
     */
    public function reprintReceipt(Order $order, ?string $format, int $actorId): array
    {
        $format = $format ?: '58'; // '58' or '80'
        $order->load('items', 'payments');

        // Render HTML inline (no Blade file needed)
        $html = $this->renderReceiptHtml($order, $format);

        $this->audit('ORDER_RECEIPT_REPRINTED', $order, [
            'format'     => $format,
            'printed_at' => now()->toDateTimeString(),
        ], $actorId);

        return [
            'format' => $format,
            'html'   => $html,
            'wa_link' => $this->makeWaLink($order),
        ];
    }

    /**
     * Build WhatsApp link (manual share, sesuai flow PDF).
     */
    public function resendWA(Order $order, string $phone, ?string $message, int $actorId): array
    {
        $defaultMsg = $this->defaultWaMessage($order);
        $text = trim($message ?: $defaultMsg);
        $wa = 'https://wa.me/' . ltrim($phone, '+0') . '?text=' . urlencode($text);

        $this->audit('ORDER_WA_RESEND', $order, [
            'phone' => $phone,
            'message' => $text,
        ], $actorId);

        return ['wa_url' => $wa];
    }

    /** Helpers */
    protected function snapshot(Order $o): array
    {
        $o->loadMissing('items', 'payments');
        return [
            'order' => Arr::only($o->toArray(), [
                'id',
                'kode',
                'status',
                'subtotal',
                'discount',
                'tax',
                'service_fee',
                'grand_total',
                'paid_total'
            ]),
            'items' => $o->items->map(fn($i) => Arr::only($i->toArray(), [
                'id',
                'variant_id',
                'name_snapshot',
                'price',
                'discount',
                'qty',
                'line_total'
            ]))->all(),
        ];
    }

    protected function defaultWaMessage(Order $o): string
    {
        return "Terima kasih telah berbelanja.\n" .
            "Kode: {$o->kode}\nTotal: Rp " . $this->nf($o->grand_total, 0) .
            "\nTanggal: " . $o->ordered_at;
    }

    protected function makeWaLink(Order $o): string
    {
        $msg = $this->defaultWaMessage($o);
        return 'https://wa.me/?text=' . urlencode($msg);
    }

    private function nf($value, int $decimals = 0): string
    {
        $n = is_numeric($value) ? (float)$value : 0.0;
        return number_format($n, $decimals, ',', '.');
    }

    private function nfDot($value, int $decimals = 2): string
    {
        // untuk format dengan titik desimal (mis. Qty 2 desimal), lalu trim trailing .0
        $n = is_numeric($value) ? (float)$value : 0.0;
        return rtrim(rtrim(number_format($n, $decimals, '.', ''), '0'), '.');
    }

    protected function audit(string $action, Order $order, array $diff, int $actorId): void
    {
        // Tabel audit_logs ada di ERD dan Flow (disarankan).
        // Jika model AuditLog sudah ada, panggil di sini. Jika belum, bisa simpan via DB::table(...).
        if (!Schema::hasTable('audit_logs')) {
            return;
        }

        DB::table('audit_logs')->insert([
            'actor_type' => 'USER',
            'actor_id'   => $actorId,
            'action'     => $action,
            'model'      => 'Order',
            'model_id'   => $order->id,
            'diff_json'  => json_encode($diff, JSON_UNESCAPED_UNICODE),
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }

    protected function renderReceiptHtml(Order $order, string $format = '58'): string
    {
        // common printable widths: 58mm ≈ 384px, 80mm ≈ 576px
        $widthPx = $format === '80' ? 576 : 384;

        $kode   = e($order->kode);
        $date   = e(optional($order->ordered_at)->format('Y-m-d H:i') ?? (string)$order->ordered_at);
        $cabang = e((string)($order->cabang->nama ?? $order->cabang_id));
        $status = e((string)$order->status);

        $rows = '';
        foreach ($order->items as $it) {
            $name  = e($it->name_snapshot ?: '');
            $qty   = (float)$it->qty;            // ensure float
            $price = (float)$it->price;          // ensure float
            $disc  = (float)$it->discount;       // ensure float
            $line  = (float)$it->line_total;     // ensure float

            $rows .= '
            <tr>
            <td class="name">' . $name . '</td>
            <td class="qty">' . $this->nfDot($qty, 2) . '</td>
            <td class="price">Rp ' . $this->nf(($price - $disc), 0) . '</td>
            <td class="line">Rp ' . $this->nf($line, 0) . '</td>
            </tr>';
        }

        $subtotal   = $this->nf($order->subtotal, 0);
        $discount   = $this->nf($order->discount, 0);
        $tax        = $this->nf($order->tax, 0);
        $serviceFee = $this->nf($order->service_fee, 0);
        $grandTotal = $this->nf($order->grand_total, 0);
        $paidTotal  = $this->nf($order->paid_total, 0);
        $change     = $this->nf(max(0, (float)$order->paid_total - (float)$order->grand_total), 0);

        return <<<HTML
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Receipt {$kode}</title>
<style>
  * { box-sizing: border-box; }
  body { font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace; }
  .paper { width: {$widthPx}px; margin: 0 auto; padding: 8px; }
  h1, h2, h3, p { margin: 0; padding: 0; }
  .center { text-align: center; }
  .muted { opacity: .8; font-size: 12px; }
  hr { border: 0; border-top: 1px dashed #000; margin: 6px 0; }
  table { width: 100%; border-collapse: collapse; font-size: 12px; }
  th, td { padding: 2px 0; vertical-align: top; }
  td.qty { text-align: right; width: 38px; }
  td.price { text-align: right; width: 90px; }
  td.line { text-align: right; width: 110px; }
  td.name { width: calc(100% - 238px); }
  .totals td { padding: 2px 0; }
  .totals td.label { text-align: right; }
  .bold { font-weight: 700; }
  .footer { margin-top: 8px; }
  @media print {
    .paper { width: {$widthPx}px; }
  }
</style>
</head>
<body>
  <div class="paper">
    <div class="center">
      <h3>POS Prime</h3>
      <div class="muted">Cabang: {$cabang}</div>
    </div>
    <hr />
    <table>
      <tr><td><span class="bold">Kode</span></td><td>: {$kode}</td></tr>
      <tr><td><span class="bold">Tanggal</span></td><td>: {$date}</td></tr>
      <tr><td><span class="bold">Status</span></td><td>: {$status}</td></tr>
    </table>
    <hr />
    <table>
      <thead>
        <tr><th class="name">Item</th><th class="qty">Qty</th><th class="price">Harga</th><th class="line">Total</th></tr>
      </thead>
      <tbody>
        {$rows}
      </tbody>
    </table>
    <hr />
    <table class="totals">
      <tr><td class="label" colspan="3">Subtotal</td><td class="line">Rp {$subtotal}</td></tr>
      <tr><td class="label" colspan="3">Diskon</td><td class="line">Rp {$discount}</td></tr>
      <tr><td class="label" colspan="3">Pajak</td><td class="line">Rp {$tax}</td></tr>
      <tr><td class="label" colspan="3">Biaya Layanan</td><td class="line">Rp {$serviceFee}</td></tr>
      <tr><td class="label bold" colspan="3">Grand Total</td><td class="line bold">Rp {$grandTotal}</td></tr>
      <tr><td class="label" colspan="3">Dibayar</td><td class="line">Rp {$paidTotal}</td></tr>
      <tr><td class="label" colspan="3">Kembali</td><td class="line">Rp {$change}</td></tr>
    </table>
    <hr />
    <div class="center footer">
      <div>Terima kasih 🙏</div>
      <div class="muted">Simpan struk ini sebagai bukti transaksi</div>
    </div>
  </div>
</body>
</html>
HTML;
    }
}

```
</details>

### app/Services/Products/ProductMediaService.php

- SHA: `0d27b384c49b`  
- Ukuran: 2 KB  
- Namespace: `App\Services\Products`

**Class `ProductMediaService`**

Metode Publik:
- **upload**(Product $product, array $files, string $disk = 'public') : *array*
- **setPrimary**(Product $product, ProductMedia $media) : *void* — @var UploadedFile $file
- **reorder**(Product $product, array $orders) : *void* — @var UploadedFile $file
- **delete**(ProductMedia $media) : *void* — @var UploadedFile $file
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Services\Products;

use App\Models\Product;
use App\Models\ProductMedia;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class ProductMediaService
{
    public function upload(Product $product, array $files, string $disk = 'public'): array
    {
        $saved = [];

        DB::transaction(function () use ($product, $files, $disk, &$saved) {
            foreach ($files as $file) {
                /** @var UploadedFile $file */
                $path = $file->store('products/' . $product->id, $disk);

                $media = ProductMedia::create([
                    'product_id' => $product->id,
                    'disk' => $disk,
                    'path' => $path,
                    'mime' => $file->getClientMimeType(),
                    'size_kb' => (int) round(($file->getSize() ?? 0) / 1024),
                    'is_primary' => false,
                    'sort_order' => 0,
                ]);

                $saved[] = $media;
            }
        });

        return $saved;
    }

    public function setPrimary(Product $product, ProductMedia $media): void
    {
        DB::transaction(function () use ($product, $media) {
            ProductMedia::where('product_id', $product->id)->update(['is_primary' => false]);
            $media->update(['is_primary' => true, 'sort_order' => 0]);
        });
    }

    public function reorder(Product $product, array $orders): void
    {
        DB::transaction(function () use ($product, $orders) {
            foreach ($orders as $o) {
                ProductMedia::where('product_id', $product->id)
                    ->where('id', $o['id'])
                    ->update(['sort_order' => (int) $o['sort_order']]);
            }
        });
    }

    public function delete(ProductMedia $media): void
    {
        DB::transaction(function () use ($media) {
            $disk = $media->disk;
            $path = $media->path;
            $media->delete();
            if ($path && $disk && Storage::disk($disk)->exists($path)) {
                Storage::disk($disk)->delete($path);
            }
        });
    }
}

```
</details>

### app/Services/Products/ProductService.php

- SHA: `b2e8b3756d0b`  
- Ukuran: 5 KB  
- Namespace: `App\Services\Products`

**Class `ProductService`**

Metode Publik:
- **list**(?string $search = null, int $perPage = 24, ?bool $onlyActive = true)
- **create**(array $data) : *Product*
- **update**(Product $product, array $data) : *Product* — @var Product $product
- **delete**(Product $product) : *void* — @var Product $product
- **createVariant**(Product $product, array $data) : *ProductVariant* — @var Product $product
- **updateVariant**(ProductVariant $variant, array $data) : *ProductVariant* — @var Product $product
- **deleteVariant**(ProductVariant $variant) : *void* — @var Product $product
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Services\Products;

use App\Models\Product;
use App\Models\ProductVariant;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Database\Eloquent\Collection;

class ProductService
{
    public function list(?string $search = null, int $perPage = 24, ?bool $onlyActive = true)
    {
        return Product::query()
            ->when($onlyActive, fn($q) => $q->active())     // 🔹 default: hanya produk aktif
            ->withCount('variants')
            ->with(['primaryMedia:id,product_id,path,is_primary,sort_order'])
            ->search($search)
            ->orderByDesc('id')
            ->paginate($perPage);
    }

    public function create(array $data): Product
    {
        return DB::transaction(function () use ($data) {
            // slug
            $data['slug'] = $this->ensureUniqueSlug($data['slug'] ?? Str::slug($data['nama']));

            /** @var Product $product */
            $product = Product::create([
                'category_id' => $data['category_id'],
                'nama'        => $data['nama'],
                'slug'        => $data['slug'],
                'deskripsi'   => $data['deskripsi'] ?? null,
                'is_active'   => $data['is_active'] ?? true,
            ]);

            // optional initial variants
            if (!empty($data['variants']) && is_array($data['variants'])) {
                foreach ($data['variants'] as $v) {
                    $this->createVariant($product, $v);
                }
            }

            return $product->load('variants', 'media');
        });
    }

    public function update(Product $product, array $data): Product
    {
        return DB::transaction(function () use ($product, $data) {
            if (isset($data['nama']) && !isset($data['slug'])) {
                // regenerate slug only if not explicitly provided
                $data['slug'] = $this->ensureUniqueSlug(Str::slug($data['nama']), $product->id);
            } elseif (isset($data['slug'])) {
                $data['slug'] = $this->ensureUniqueSlug($data['slug'], $product->id);
            }

            $product->fill($data)->save();

            return $product->refresh()->load('variants', 'media');
        });
    }

    public function delete(Product $product): void
    {
        DB::transaction(function () use ($product) {
            $product->delete(); // media + variants cascade via FK onDelete? Variants yes; Media yes (set in migration)
        });
    }

    // ---------- Variants ----------
    public function createVariant(Product $product, array $data): ProductVariant
    {
        $sku = $data['sku'] ?? $this->generateSku($product, $data);
        return ProductVariant::create([
            'product_id' => $product->id,
            'size'   => $data['size']   ?? null,
            'type'   => $data['type']   ?? null,
            'tester' => $data['tester'] ?? null,
            'harga'  => $data['harga'],
            'sku'    => $this->ensureUniqueSku($sku),
            'is_active' => $data['is_active'] ?? true,
        ]);
    }

    public function updateVariant(ProductVariant $variant, array $data): ProductVariant
    {
        if (empty($data['sku'])) {
            // regenerate when attributes change
            $data['sku'] = $this->generateSku($variant->product, array_merge($variant->toArray(), $data));
        }
        $data['sku'] = $this->ensureUniqueSku($data['sku'], $variant->id);

        $variant->fill($data)->save();
        return $variant->refresh();
    }

    public function deleteVariant(ProductVariant $variant): void
    {
        $variant->delete();
    }

    // ---------- Helpers ----------
    private function ensureUniqueSlug(string $base, ?int $ignoreId = null): string
    {
        $slug = Str::slug($base) ?: Str::random(6);
        $try  = $slug;
        $i = 1;
        while (Product::where('slug', $try)->when($ignoreId, fn($q) => $q->where('id', '!=', $ignoreId))->exists()) {
            $try = $slug . '-' . $i++;
        }
        return $try;
    }

    private function generateSku(Product $product, array $data): string
    {
        $code = strtoupper(Str::slug(substr($product->nama, 0, 12), ''));
        $parts = [
            strtoupper(substr((string)($data['size'] ?? ''), 0, 3)),
            strtoupper(substr((string)($data['type'] ?? ''), 0, 3)),
            strtoupper(substr((string)($data['tester'] ?? ''), 0, 3)),
        ];
        $base = $code . '-' . implode('', array_filter($parts));
        return $base ?: 'SKU-' . Str::upper(Str::random(6));
    }

    private function ensureUniqueSku(string $base, ?int $ignoreId = null): string
    {
        $sku = preg_replace('/\s+/', '', strtoupper($base)) ?: 'SKU-' . Str::upper(Str::random(6));
        $try = $sku;
        $i = 1;
        $query = fn($t) => ProductVariant::where('sku', $t)
            ->when($ignoreId, fn($q) => $q->where('id', '!=', $ignoreId));
        while ($query($try)->exists()) {
            $try = $sku . '-' . $i++;
        }
        return $try;
    }
}

```
</details>

### app/Services/QuoteService.php

- SHA: `5f1ebba6d3bc`  
- Ukuran: 2 KB  
- Namespace: `App\Services`

**Class `QuoteService`**

Metode Publik:
- **__construct**()
- **quoteItems**(array $items) : *array* — @param array<int, array{variant_id:int, qty:float, discount?:float, price_hint?:float}> $items
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Services;

use App\Models\ProductVariant;

class QuoteService
{
    // ✅ Not readonly, not promoted, no defaults in signature
    private float $taxPercent;
    private float $servicePercent;

    public function __construct()
    {
        // ✅ Single assignment (legal in PHP 8.2+)
        $this->taxPercent     = (float) config('pos.tax_percent', env('POS_TAX_PERCENT', 0));
        $this->servicePercent = (float) config('pos.service_percent', env('POS_SERVICE_PERCENT', 0));
    }

    /**
     * @param array<int, array{variant_id:int, qty:float, discount?:float, price_hint?:float}> $items
     * @return array{items:array<int, array>, totals: array}
     */
    public function quoteItems(array $items): array
    {
        $resultItems   = [];
        $subtotal      = 0.0;
        $discountTotal = 0.0;

        foreach ($items as $row) {
            $variant = ProductVariant::query()
                ->with('product')
                ->where('is_active', true)
                ->whereHas('product', fn ($q) => $q->where('is_active', true))
                ->findOrFail((int) $row['variant_id']);

            $qty       = max(0.0, (float) $row['qty']);
            $unitPrice = (float) $variant->harga;
            $disc      = isset($row['discount']) ? max(0.0, (float) $row['discount']) : 0.0;

            $effectiveUnit = max(0.0, $unitPrice - $disc);
            $line          = $effectiveUnit * $qty;

            $resultItems[] = [
                'variant_id'    => $variant->id,
                'name_snapshot' => $variant->product->nama.' - '.$variant->nama,
                'price'         => round($unitPrice, 2),
                'discount'      => round($disc, 2),
                'qty'           => $qty,
                'line_total'    => round($line, 2),
            ];

            $subtotal      += ($unitPrice * $qty);
            $discountTotal += ($disc * $qty);
        }

        $net     = max(0.0, $subtotal - $discountTotal);
        $service = round($net * ($this->servicePercent / 100), 2);
        $tax     = round(($net + $service) * ($this->taxPercent / 100), 2);
        $grand   = round($net + $service + $tax, 2);

        return [
            'items'  => $resultItems,
            'totals' => [
                'subtotal'     => round($subtotal, 2),
                'discount'     => round($discountTotal, 2),
                'service_fee'  => $service,
                'tax'          => $tax,
                'grand_total'  => $grand,
            ],
        ];
    }
}

```
</details>

### app/Services/SalesInventoryService.php

- SHA: `07e5dcf29911`  
- Ukuran: 838 B  
- Namespace: `App\Services`

**Class `SalesInventoryService`**

Metode Publik:
- **__construct**(private VariantStockService $stockService)
- **deductOnPaid**(int $gudangId, int $variantId, float $qty, ?string $note = null) : *void*
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Services;

use App\Services\VariantStockService;

class SalesInventoryService
{
    public function __construct(private VariantStockService $stockService) {}

    public function deductOnPaid(int $gudangId, int $variantId, float $qty, ?string $note = null): void
    {
        // turunkan ke integer jika stok integral di tabel kamu
        $amount = (int) ceil($qty);
        // gunakan adjust('decrease') agar tidak minus
        $stock = \App\Models\VariantStock::query()
            ->where('gudang_id', $gudangId)
            ->where('product_variant_id', $variantId)
            ->firstOrFail();

        $this->stockService->adjust($stock, 'decrease', $amount, $note ?? 'SALE');
        // (lanjutan ideal): tulis StockMove direction=OUT reason=SALE (lihat ERD) :contentReference[oaicite:12]{index=12}
    }
}

```
</details>

### app/Services/SettingService.php

- SHA: `ec845e116828`  
- Ukuran: 5 KB  
- Namespace: `App\Services`

**Class `SettingService`**

Metode Publik:
- **get**(string $key, ?int $branchId = null, ?int $userId = null) : *?array* — Read settings with hierarchical fallback: USER -> BRANCH -> GLOBAL (if requested that way).
- **upsert**(string $scope, ?int $scopeId, string $key, array $value) : *Setting* — Read settings with hierarchical fallback: USER -> BRANCH -> GLOBAL (if requested that way).
- **bulkUpsert**(array $items) : *int* — Read settings with hierarchical fallback: USER -> BRANCH -> GLOBAL (if requested that way).
- **delete**(Setting $setting) : *void* — Read settings with hierarchical fallback: USER -> BRANCH -> GLOBAL (if requested that way).
- **export**(?string $scope, ?int $scopeId, ?array $keys = null) : *array* — Read settings with hierarchical fallback: USER -> BRANCH -> GLOBAL (if requested that way).
- **import**(array $items, string $mode = 'merge') : *array* — Read settings with hierarchical fallback: USER -> BRANCH -> GLOBAL (if requested that way).
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Services;

use App\Models\Setting;
use App\Models\AuditLog;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Carbon;

class SettingService
{
    /** Read settings with hierarchical fallback: USER -> BRANCH -> GLOBAL (if requested that way). */
    public function get(string $key, ?int $branchId = null, ?int $userId = null): ?array
    {
        // Simple direct lookups; advanced fallback can be added when integrating with other modules.
        if ($userId) {
            $row = Setting::query()->where(['scope' => 'USER', 'scope_id' => $userId, 'key' => $key])->first();
            if ($row) return $row->value_json;
        }
        if ($branchId) {
            $row = Setting::query()->where(['scope' => 'BRANCH', 'scope_id' => $branchId, 'key' => $key])->first();
            if ($row) return $row->value_json;
        }
        $row = Setting::query()->where(['scope' => 'GLOBAL', 'key' => $key])->first();
        return $row?->value_json;
    }

    /** Upsert a single setting; idempotent by (scope,scope_id,key). Writes audit diff. */
    public function upsert(string $scope, ?int $scopeId, string $key, array $value): Setting
    {
        return DB::transaction(function () use ($scope, $scopeId, $key, $value) {
            $before = Setting::query()->where(compact('scope'))->when($scopeId, fn($q) => $q->where('scope_id', $scopeId))
                ->where('key', $key)->first();

            $setting = Setting::updateOrCreate(
                ['scope' => $scope, 'scope_id' => $scopeId, 'key' => $key],
                ['value_json' => $value]
            );

            $this->audit('UPSERT', $setting, $before?->value_json, $value);
            return $setting;
        });
    }

    /** Bulk upsert multiple items. */
    public function bulkUpsert(array $items): int
    {
        $count = 0;
        DB::transaction(function () use (&$count, $items) {
            foreach ($items as $it) {
                $this->upsert($it['scope'], $it['scope_id'] ?? null, $it['key'], $it['value']);
                $count++;
            }
        });
        return $count;
    }

    /** Delete a setting; audited. */
    public function delete(Setting $setting): void
    {
        DB::transaction(function () use ($setting) {
            $before = $setting->value_json;
            $setting->delete();
            $this->audit('DELETE', $setting, $before, null);
        });
    }

    /** Export settings by filter. */
    public function export(?string $scope, ?int $scopeId, ?array $keys = null): array
    {
        $q = Setting::query();
        if ($scope) $q->where('scope', $scope);
        if ($scopeId) $q->where('scope_id', $scopeId);
        if ($keys) $q->whereIn('key', $keys);

        return $q->orderBy('scope')->orderBy('scope_id')->orderBy('key')
            ->get(['scope', 'scope_id', 'key', 'value_json'])
            ->toArray();
    }

    /** Import items with mode: replace|merge|skip. Returns [imported, skipped]. */
    public function import(array $items, string $mode = 'merge'): array
    {
        $imported = 0;
        $skipped = 0;
        DB::transaction(function () use (&$imported, &$skipped, $items, $mode) {
            foreach ($items as $it) {
                $existing = Setting::query()->where([
                    'scope' => $it['scope'],
                    'scope_id' => $it['scope_id'] ?? null,
                    'key' => $it['key'],
                ])->first();

                if (!$existing) {
                    $this->upsert($it['scope'], $it['scope_id'] ?? null, $it['key'], $it['value']);
                    $imported++;
                    continue;
                }

                if ($mode === 'skip') {
                    $skipped++;
                    continue;
                }
                if ($mode === 'replace') {
                    $this->upsert($it['scope'], $it['scope_id'] ?? null, $it['key'], $it['value']);
                    $imported++;
                    continue;
                }
                // merge (array recursive; value is array)
                $merged = array_replace_recursive($existing->value_json ?? [], $it['value'] ?? []);
                $this->upsert($it['scope'], $it['scope_id'] ?? null, $it['key'], $merged);
                $imported++;
            }
        });
        return compact('imported', 'skipped');
    }

    private function audit(string $action, Setting $setting, $before, $after): void
    {
        AuditLog::create([
            'actor_type' => 'USER',
            'actor_id'   => Auth::id(),
            'action'     => $action,
            'model'      => 'Setting',
            'model_id'   => $setting->id,
            'diff_json'  => ['before' => $before, 'after' => $after],
            'occurred_at' => Carbon::now(),
        ]);
    }
}

```
</details>

### app/Services/User/UserService.php

- SHA: `a59d067e22f9`  
- Ukuran: 2 KB  
- Namespace: `App\Services\User`

**Class `UserService`**

Metode Publik:
- **paginate**(array $filters = []) : *LengthAwarePaginator* — @param array{
- **create**(array $data) : *User* — @param array{
- **update**(User $user, array $data) : *User* — @param array{
- **delete**(User $user) : *void* — @param array{
- **findOrFail**(int $id) : *User* — @param array{
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

// app/Services/User/UserService.php
namespace App\Services\User;

use App\Models\User;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Hash;

class UserService
{
    /**
     * @param array{
     *   q?:string, role?:string, cabang_id?:int|null, is_active?:bool|null, per_page?:int
     * } $filters
     */
    public function paginate(array $filters = []): LengthAwarePaginator
    {
        $perPage = $filters['per_page'] ?? 15;

        $q         = $filters['q']         ?? null;
        $role      = $filters['role']      ?? null;
        $cabangId  = $filters['cabang_id'] ?? null;
        $isActive  = $filters['is_active'] ?? null;

        $query = User::query();

        if ($q) {
            $query->where(function($s) use ($q) {
                $s->where('name','like',"%{$q}%")
                  ->orWhere('email','like',"%{$q}%")
                  ->orWhere('phone','like',"%{$q}%");
            });
        }

        if ($role)     $query->where('role', $role);
        if (!is_null($isActive)) $query->where('is_active', (bool)$isActive);

        // scoping per cabang (opsional di listing superadmin)
        if ($cabangId) $query->where('cabang_id', $cabangId);

        return $query->orderByDesc('id')->paginate($perPage);
    }

    /** @param array{name:string,email:string,phone?:?string,password:string,cabang_id?:?int,role:string,is_active?:bool} $data */
    public function create(array $data): User
    {
        $payload = $data;
        $payload['password'] = Hash::make($data['password']);
        return User::create($payload);
    }

    /** @param array{name?:string,email?:string,phone?:?string,password?:string,cabang_id?:?int,role?:string,is_active?:bool} $data */
    public function update(User $user, array $data): User
    {
        $payload = $data;
        if (!empty($data['password'])) {
            $payload['password'] = Hash::make($data['password']);
        } else {
            unset($payload['password']);
        }
        $user->update($payload);
        return $user->refresh();
    }

    public function delete(User $user): void
    {
        $user->delete(); // hard delete
    }

    public function findOrFail(int $id): User
    {
        return User::query()->findOrFail($id);
    }
}

```
</details>

### app/Services/VariantStockService.php

- SHA: `d34ea7e3c532`  
- Ukuran: 3 KB  
- Namespace: `App\Services`

**Class `VariantStockService`**

Metode Publik:
- **setInitialStock**(int $gudangId, int $variantId, int $qty, ?int $minStok = null) : *VariantStock* — Set stok awal (upsert unik per gudang+variant).
- **adjust**(VariantStock $stock, string $type, int $amount, ?string $note = null) : *VariantStock* — Set stok awal (upsert unik per gudang+variant).
- **updateMinStok**(VariantStock $stock, int $minStok) : *VariantStock* — Set stok awal (upsert unik per gudang+variant).
- **ensureUniquenessAndSync**(VariantStock $stock) : *void* — Set stok awal (upsert unik per gudang+variant).
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Services;

use App\Models\VariantStock;
use App\Models\Gudang;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\ModelNotFoundException;

class VariantStockService
{
    /**
     * Set stok awal (upsert unik per gudang+variant).
     * @param int $gudangId
     * @param int $variantId
     * @param int $qty
     * @param int|null $minStok
     * @return VariantStock
     */
    public function setInitialStock(int $gudangId, int $variantId, int $qty, ?int $minStok = null): VariantStock
    {
        return DB::transaction(function () use ($gudangId, $variantId, $qty, $minStok) {
            $gudang = Gudang::query()->with('cabang')->findOrFail($gudangId);
            /** @var VariantStock $stock */
            $stock = VariantStock::query()->firstOrNew([
                'gudang_id' => $gudang->id,
                'product_variant_id' => $variantId,
            ]);

            $stock->cabang_id = $gudang->cabang_id;
            $stock->qty       = (int)$qty;
            if ($minStok !== null) $stock->min_stok = (int)$minStok;
            $stock->save();

            // (Optional) dispatch event: VariantStockInitialized
            return $stock->refresh();
        });
    }

    /**
     * Penyesuaian manual stok.
     * @param VariantStock $stock
     * @param 'increase'|'decrease' $type
     * @param int $amount
     * @param string|null $note
     * @return VariantStock
     */
    public function adjust(VariantStock $stock, string $type, int $amount, ?string $note = null): VariantStock
    {
        return DB::transaction(function () use ($stock, $type, $amount, $note) {
            $stock->lockForUpdate(); // hindari race condition
            if ($type === 'increase') {
                $stock->qty += $amount;
            } else {
                // cegah negatif
                if ($stock->qty < $amount) {
                    throw new \RuntimeException('Stok tidak mencukupi untuk dikurangi.');
                }
                $stock->qty -= $amount;
            }
            $stock->save();

            // (Optional) audit log penyesuaian menggunakan $note
            return $stock->refresh();
        });
    }

    /**
     * Update threshold low-stock.
     */
    public function updateMinStok(VariantStock $stock, int $minStok): VariantStock
    {
        $stock->min_stok = $minStok;
        $stock->save();
        return $stock->refresh();
    }

    /**
     * Konsistensi: pastikan 1 baris per (gudang, variant) dan cabang sinkron.
     * Bisa dipanggil sebagai maintenance/command bila perlu.
     */
    public function ensureUniquenessAndSync(VariantStock $stock): void
    {
        $duplicate = VariantStock::query()
            ->where('id', '!=', $stock->id)
            ->where('gudang_id', $stock->gudang_id)
            ->where('product_variant_id', $stock->product_variant_id)
            ->exists();

        if ($duplicate) {
            throw new \RuntimeException('Data stok duplikat untuk gudang & varian yang sama.');
        }
    }
}

```
</details>

### app/Services/XenditService.php

- SHA: `545f48c397ec`  
- Ukuran: 2 KB  
- Namespace: `App\Services`

**Class `XenditService`**

Metode Publik:
- **__construct**(private string $baseUrl = '', private string $secret = '', private string $cbToken = '', private string $successUrl = '', private string $failureUrl = '')
- **createInvoice**(array $payload) : *array* — Buat invoice Xendit, kembalikan array: ['ref_no' => string, 'checkout_url' => string, 'raw' => array]
- **isValidCallback**(string $headerToken = null) : *bool* — Buat invoice Xendit, kembalikan array: ['ref_no' => string, 'checkout_url' => string, 'raw' => array]
<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;

class XenditService
{
    public function __construct(
        private string $baseUrl = '',
        private string $secret = '',
        private string $cbToken = '',
        private string $successUrl = '',
        private string $failureUrl = ''
    ) {
        $this->baseUrl    = config('services.xendit.base_url', env('XENDIT_BASE_URL'));
        $this->secret     = config('services.xendit.secret', env('XENDIT_SECRET_KEY'));
        $this->cbToken    = config('services.xendit.callback_token', env('XENDIT_CALLBACK_TOKEN'));
        $this->successUrl = env('XENDIT_SUCCESS_URL');
        $this->failureUrl = env('XENDIT_FAILURE_URL');
    }

    /** Buat invoice Xendit, kembalikan array: ['ref_no' => string, 'checkout_url' => string, 'raw' => array] */
    public function createInvoice(array $payload): array
    {
        // $payload minimal: amount, description, external_id
        $resp = Http::withBasicAuth($this->secret, '')
            ->acceptJson()
            ->post(rtrim($this->baseUrl, '/') . '/v2/invoices', [
                'external_id' => $payload['external_id'],
                'amount' => (int) $payload['amount'],
                'description' => $payload['description'] ?? 'Order Payment',
                'success_redirect_url' => $this->successUrl,
                'failure_redirect_url' => $this->failureUrl,
            ]);

        $data = $resp->throw()->json();

        return [
            'ref_no'       => (string)($data['id'] ?? $data['invoice_id'] ?? ''),
            'checkout_url' => (string)($data['invoice_url'] ?? $data['checkout_url'] ?? ''),
            'raw'          => $data,
        ];
    }

    /** Validasi header callback token dari Xendit */
    public function isValidCallback(string $headerToken = null): bool
    {
        return $headerToken && hash_equals($this->cbToken, $headerToken);
    }
}

```
</details>



## routes/api.php

- SHA: `38ddc24cfe21`  
- Ukuran: 12 KB

**Ringkasan Routes (deteksi heuristik):**

| Method | Path | Controller | Action |
|---|---|---|---|
| POST | `/auth/login` | `AuthController` | `login` |
| POST | `/webhooks/xendit/invoice` | `PaymentWebhookController` | `invoice` |
| GET | `/auth/me` | `AuthController` | `me` |
| POST | `/auth/logout` | `AuthController` | `logout` |
| GET | `/users` | `UserController` | `index` |
| POST | `/users` | `UserController` | `store` |
| GET | `/users/{id}` | `UserController` | `show` |
| PUT | `/users/{id}` | `UserController` | `update` |
| DELETE | `/users/{id}` | `UserController` | `destroy` |
| GET | `cabangs` | `CabangController` | `index` |
| POST | `cabangs` | `CabangController` | `store` |
| GET | `cabangs/{cabang}` | `CabangController` | `show` |
| PUT | `cabangs/{cabang}` | `CabangController` | `update` |
| PATCH | `cabangs/{cabang}` | `CabangController` | `update` |
| DELETE | `cabangs/{cabang}` | `CabangController` | `destroy` |
| GET | `gudangs` | `GudangController` | `index` |
| POST | `gudangs` | `GudangController` | `store` |
| GET | `gudangs/{gudang}` | `GudangController` | `show` |
| PUT | `gudangs/{gudang}` | `GudangController` | `update` |
| PATCH | `gudangs/{gudang}` | `GudangController` | `update` |
| DELETE | `gudangs/{gudang}` | `GudangController` | `destroy` |
| GET | `/categories` | `CategoryController` | `index` |
| POST | `/categories` | `CategoryController` | `store` |
| GET | `/categories/{category}` | `CategoryController` | `show` |
| PUT | `/categories/{category}` | `CategoryController` | `update` |
| PATCH | `/categories/{category}` | `CategoryController` | `update` |
| DELETE | `/categories/{category}` | `CategoryController` | `destroy` |
| GET | `/products` | `ProductController` | `index` |
| POST | `/products` | `ProductController` | `store` |
| GET | `/products/{product}` | `ProductController` | `show` |
| PUT | `/products/{product}` | `ProductController` | `update` |
| PATCH | `/products/{product}` | `ProductController` | `update` |
| DELETE | `/products/{product}` | `ProductController` | `destroy` |
| GET | `/variants` | `ProductVariantController` | `search` |
| GET | `/products/{product}/variants` | `ProductVariantController` | `index` |
| POST | `/products/{product}/variants` | `ProductVariantController` | `store` |
| GET | `/products/{product}/variants/{variant}` | `ProductVariantController` | `show` |
| PUT | `/products/{product}/variants/{variant}` | `ProductVariantController` | `update` |
| PATCH | `/products/{product}/variants/{variant}` | `ProductVariantController` | `update` |
| DELETE | `/products/{product}/variants/{variant}` | `ProductVariantController` | `destroy` |
| GET | `/products/{product}/media` | `ProductMediaController` | `index` |
| POST | `/products/{product}/media` | `ProductMediaController` | `store` |
| POST | `/products/{product}/media/set-primary` | `ProductMediaController` | `setPrimary` |
| POST | `/products/{product}/media/reorder` | `ProductMediaController` | `reorder` |
| DELETE | `/products/{product}/media/{media}` | `ProductMediaController` | `destroy` |
| GET | `/stocks` | `VariantStockController` | `index` |
| GET | `/stocks/{stock}` | `VariantStockController` | `show` |
| POST | `/stocks` | `VariantStockController` | `store` |
| PATCH | `/stocks/{stock}` | `VariantStockController` | `update` |
| POST | `/stocks/{stock}/adjust` | `VariantStockController` | `adjust` |
| DELETE | `/stocks/{stock}` | `VariantStockController` | `destroy` |
| GET | `/orders/{order}/print` | `OrderController` | `print` |
| GET | `/orders` | `OrderController` | `index` |
| GET | `/orders/{order}` | `OrderController` | `show` |
| POST | `/cart/quote` | `OrderController` | `quote` |
| POST | `/checkout` | `OrderController` | `checkout` |
| PUT | `/orders/{order}` | `OrderController` | `update` |
| POST | `/orders/{order}/payments` | `OrderController` | `addPayment` |
| POST | `/orders/{order}/cancel` | `OrderController` | `cancel` |
| GET | `/orders` | `OrdersController` | `index` |
| GET | `/orders/{order}` | `OrdersController` | `show` |
| PUT | `/orders/{order}/items` | `OrdersController` | `updateItems` |
| POST | `/orders/{order}/reprint` | `OrdersController` | `reprint` |
| POST | `/orders/{order}/resend-wa` | `OrdersController` | `resendWA` |
| POST | `/orders/{order}/cash-position` | `OrderController` | `setCashPosition` |
| GET | `/deliveries/{id}/note` | `DeliveriesController` | `note` |
| POST | `/deliveries/{id}/send-wa` | `DeliveriesController` | `sendWa` |
| GET | `/deliveries` | `DeliveriesController` | `index` |
| GET | `/deliveries/{id}` | `DeliveriesController` | `show` |
| POST | `/deliveries` | `DeliveriesController` | `store` |
| POST | `/deliveries/{id}/assign` | `DeliveriesController` | `assign` |
| POST | `/deliveries/{id}/status` | `DeliveriesController` | `updateStatus` |
| POST | `/deliveries/{id}/events` | `DeliveriesController` | `addEvent` |
| GET | `cash/holders` | `CashController` | `holders` |
| POST | `cash/holders` | `CashController` | `storeHolder` |
| GET | `cash/moves` | `CashController` | `moves` |
| POST | `cash/moves` | `CashController` | `store` |
| POST | `cash/moves/{move}/approve` | `CashController` | `approve` |
| POST | `cash/moves/{move}/reject` | `CashController` | `reject` |
| DELETE | `cash/moves/{move}` | `CashController` | `destroy` |
| GET | `/fee-entries` | `FeeEntryController` | `index` |
| GET | `/fee-entries/export` | `FeeEntryController` | `export` |
| POST | `/fee-entries/pay` | `FeeEntryController` | `pay` |
| GET | `/customers` | `CustomersController` | `index` |
| GET | `/customers/{customer}` | `CustomersController` | `show` |
| POST | `/customers` | `CustomersController` | `store` |
| PUT | `/customers/{customer}` | `CustomersController` | `update` |
| DELETE | `/customers/{customer}` | `CustomersController` | `destroy` |
| GET | `/customers/{customer}/history` | `CustomersController` | `history` |
| POST | `/customers/{customer}/stage` | `CustomersController` | `setStage` |
| GET | `/dashboard/kpis` | `DashboardController` | `kpis` |
| GET | `/dashboard/chart7d` | `DashboardController` | `chart7d` |
| GET | `/dashboard/top-products` | `DashboardController` | `topProducts` |
| GET | `/dashboard/low-stock` | `DashboardController` | `lowStock` |
| GET | `/dashboard/quick-actions` | `DashboardController` | `quickActions` |
| GET | `/settings` | `SettingsController` | `index` |
| POST | `/settings/upsert` | `SettingsController` | `upsert` |
| POST | `/settings/bulk-upsert` | `SettingsController` | `bulkUpsert` |
| DELETE | `/settings/{setting}` | `SettingsController` | `destroy` |
| GET | `/settings/export` | `SettingsController` | `export` |
| POST | `/settings/import` | `SettingsController` | `import` |
| GET | `/accounts` | `AccountController` | `index` |
| POST | `/accounts` | `AccountController` | `store` |
| PUT | `/accounts/{account}` | `AccountController` | `update` |
| DELETE | `/accounts/{account}` | `AccountController` | `destroy` |
| GET | `/journals` | `JournalController` | `index` |
| POST | `/journals` | `JournalController` | `store` |
| PUT | `/journals/{journal}` | `JournalController` | `update` |
| POST | `/journals/{journal}/post` | `JournalController` | `post` |
| DELETE | `/journals/{journal}` | `JournalController` | `destroy` |
| GET | `/periods` | `FiscalPeriodController` | `index` |
| POST | `/periods/open` | `FiscalPeriodController` | `open` |
| POST | `/periods/close` | `FiscalPeriodController` | `close` |
| GET | `/reports/trial-balance` | `AccountingReportController` | `trialBalance` |
| GET | `/reports/general-ledger` | `AccountingReportController` | `generalLedger` |
| GET | `/reports/profit-loss` | `AccountingReportController` | `profitLoss` |
| GET | `/reports/balance-sheet` | `AccountingReportController` | `balanceSheet` |

<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
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

```
</details>



## AuthServiceProvider.php

- SHA: `0baee21336b8`  
- Ukuran: 2 KB

**$policies**
- `User` => `UserPolicy`
- `Cabang` => `CabangPolicy`
- `Gudang` => `GudangPolicy`
- `Category` => `CategoryPolicy`
- `Product` => `ProductPolicy`
- `ProductVariant` => `ProductVariantPolicy`
- `ProductMedia` => `ProductMediaPolicy`
- `VariantStock` => `VariantStockPolicy`
- `Order` => `OrderPolicy`
- `Delivery` => `DeliveryPolicy`
- `CashMove` => `CashMovePolicy`
- `CashHolder` => `CashHolderPolicy`
- `Fee` => `FeePolicy`
- `Customer` => `CustomerPolicy`
- `Setting` => `SettingPolicy`
- `Backup` => `BackupPolicy`
- `Account` => `AccountPolicy`
- `JournalEntry` => `JournalEntryPolicy`
- `FiscalPeriod` => `FiscalPeriodPolicy`

<details><summary><strong>Lihat Kode Lengkap</strong></summary>

```php
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

```
</details>
