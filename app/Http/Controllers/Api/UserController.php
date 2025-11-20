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
