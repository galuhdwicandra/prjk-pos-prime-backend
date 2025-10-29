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
