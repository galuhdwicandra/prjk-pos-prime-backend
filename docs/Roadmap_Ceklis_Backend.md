# Roadmap Ceklis — Backend (Laravel 12 + Breeze API + Sanctum)

> **Repo:** `pos-prime-backend/` • **API Base:** `/api/v1` • **Bearer token (tanpa CSRF)** • **No Kernel** (gunakan `bootstrap/app.php`) • **Hard delete**

## Legend
- ☐ Belum 
- ☑ Selesai
- (K) = Konfirmasi sebelum lanjut

---

## M0 — Fondasi & Otentikasi
- ☑ Init project, env, struktur folder, logging
- ☑ Install & setup Sanctum (Bearer), Breeze API
- ☑ Seed Roles: Superadmin, Admin Cabang, Gudang, Kasir, Sales, Kurir
- ☑ Auth: login, me, logout
- ☑ (K) Verifikasi login/me/logout via Postman (Bearer)

## M1 — Users, Cabang, Gudang
- ☑ Migration + Model: Users (relasi cabang), Cabang, Gudang
- ☑ Policy + Request + Service (mapping peran)
- ☑ Controller + Routes (CRUD) + Uji Postman
- ☑ (K) Scope-by-cabang diuji (index/CRUD sesuai role)

## M2 — Kategori
- ☑ Migration + Model (unique per cabang opsional)
- ☑ Policy + Request + Service (blokir hapus jika dipakai)
- ☑ Controller + Routes (CRUD) + Uji Postman
- ☑ (K) Validasi referensial kategori→produk

## M3 — Produk, Varian, Media
- ☑ Migration + Model: Produk, Varian (harga/sku), Media (gambar)
- ☑ Policy + Request + Service (SKU auto, status aktif)
- ☑ Upload: drag & drop, simpan path/URL
- ☑ Controller + Routes (CRUD + media) + Uji Postman (multipart)
- ☑ (K) Integrasi dengan Kategori & Cabang

## M4 — Stok Gudang
- ☑ Migration + Model: stok per varian per gudang
- ☑ Policy + Request + Service (set stok awal, low-stock)
- ☑ Controller + Routes (CRUD/adjust) + Uji Postman
- ☑ (K) Konsistensi stok & indikator low-stock

## M5 — POS (Order & Payment)
- ☑ Migration + Model: orders, order_items, payments
- ☑ Service: quote, checkout (DB::transaction), reduce stock
- ☑ Policy + Request (create/update/cancel)
- ☑ Controller + Routes (cart/checkout/print) + Uji Postman
- ☑ (K) Struk HTML (endpoint) & kalkulasi total/discount

## M6 — Daftar Pesanan (Order Management)
- ☑ Filter by cabang/status, edit item/qty/harga
- ☑ History/riwayat perubahan (opsional table terpisah)
- ☑ Uji Postman (update, re-print, re-send WA)
- ☑ (K) Dampak perubahan ke total & audit log

## M7 — Pickup & Delivery
- ☑ Migration + Model: delivery tasks, assignment kurir
- ☑ Service: auto-assign, status flow, retur (foto opsional)
- ☑ Policy + Request (assign/update-status)
- ☑ Controller + Routes + Uji Postman (upload foto)
- ☑ (K) Sinkron order/payment/COD

## M8 — Cash Tracking
- ☑ Model: cash_holder, cash_submission, approvals
- ☑ Service: akumulasi tunai dari POS/COD
- ☑ Controller + Routes (submit/approve/reject) + Uji
- ☑ (K) Audit trail & visibility per role

## M9 — Fee Tracking
- ☑ Model: fees (sales/kurir), periode, status bayar
- ☑ Service: kalkulasi otomatis saat order selesai
- ☑ Controller + Routes (list/export/update-status) + Uji
- ☑ (K) Akses rahasia (Superadmin/Admin Cabang)

## M10 — Customers
- ☑ Auto-create saat checkout; list & detail
- ☑ Stage/potensi; riwayat pembelian
- ☑ Uji filtering dan relasi orders
- ☑ (K) Privasi data & scope-cabang

## M11 — Dashboard
- ☑ KPI harian/mingguan, 7D chart, top 5 produk
- ☑ Low-stock, quick actions
- ☑ Endpoint agregasi efisien (caching bila perlu)
- ☑ (K) Validasi angka vs data real

## M12 — Settings & Utilitas
- ☑ Pengaturan global & per cabang
- ☑ Backup/restore (opsional), export-import
- ☑ (K) Review akhir keamanan & performa

## M13 - Akuntansi
- ☑ **Dependensi**: POS/Order (M5–M7), Cash Tracking (M8), Fee Tracking (M9)
- ☑ **Migrations + Model**
  - `accounts` (COA berjenjang: kode, nama, tipe/normal balance, parent_id, is_active)
  - `journal_entries` (tanggal, nomor, deskripsi, status: DRAFT/POSTED, branch_id, periode)
  - `journal_lines` (journal_id, account_id, debit, credit, ref_type, ref_id, branch_id)
  - `fiscal_periods` (bulan/tahun, status: OPEN/CLOSED), indeks & FK lengkap
- ☑ **Policies + Requests**
  - Policy: akses per-role & per-cabang (Superadmin/Admin Cabang); kasir read-only bila diberi izin
  - Requests: `AccountStore/Update`, `JournalStore/Update`, `JournalPost`, `PeriodClose`
- ☑ **Services**
  - `AccountingService`:
    - Validasi **double-entry** (∑debit = ∑credit, non-negatif, akun aktif)
    - Posting jurnal (ubah status DRAFT→POSTED, tulis audit)
    - Locking periode (CLOSE) dan guard saat posting
  - Integrasi referensi: tag sumber (order_id/payment_id/fee_id) di `journal_lines.ref_*`
- ☑ **Controller + Routes** (`/api/v1/accounting/*`)
  - COA: CRUD, toggle aktif/non-aktif, tree/list
  - Journals: list (filter tanggal/periode/cabang/akun), create/update, **post** (idempotent, transaction)
  - Periods: open/close, guard jurnal pada periode CLOSED
  - Reports: **trial-balance**, **general-ledger**, **profit-loss**, **balance-sheet** (query agregasi efisien)
- ☑ **Uji Postman**
  - Skenario: buat COA → buat jurnal DRAFT → tambah lines → POST (200) → validasi saldo seimbang
  - Guard: 422 (tidak seimbang), 403 (akses cabang/role), 409 (periode CLOSED), 404 (akun tidak aktif)
- ☑ **(K) Ikatan Frontend**
  - Struktur data COA (tree & flat), format payload Journal (header+lines), dan parameter filter laporan disepakati
  - Penamaan kode akun & tipe (Asset/Liability/Equity/Revenue/Expense) dibekukan

---

## Uji & Kualitas (Lintasan Tetap per Modul)
- ☐ Unit test minimal untuk Service & Policy
- ☐ Panduan Uji Postman terisi lengkap (401/403/422/200)
- ☐ Hard delete berjalan sesuai relasi
- ☐ Dokumentasi dependensi modul di README modul
