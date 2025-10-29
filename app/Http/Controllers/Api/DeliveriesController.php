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
