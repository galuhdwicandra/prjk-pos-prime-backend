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
