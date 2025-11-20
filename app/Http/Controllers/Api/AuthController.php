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
