# 🎓 ASSESSMENT 2 - SMARTJOB MOBILE (REMEDIAL)
## Platform Portal Lowongan Kerja Berbasis Flutter + API Laravel

---

## ✅ CHECKLIST KETENTUAN DOSEN

### 0. Ketentuan Umum (10 poin) ✅
- ✅ Project Flutter: `smartjob_mobile`
- ✅ MaterialApp dengan:
  - Title: 'SmartJob Mobile'
  - Theme: ThemeData dengan warna utama biru
  - Named Routes: `'/'`, `'/home'`, `'/profile'`, `'/settings'`, dll

### 1. Halaman Utama (HomePage) (10 poin) ✅
- ✅ AppBar: "SmartJob Kabupaten Bandung"
- ✅ Teks sambutan: "Selamat datang di SmartJob Mobile"
- ✅ Deskripsi aplikasi (2-3 kalimat)
- ✅ Gambar dari assets
- ✅ 2 tombol ElevatedButton:
  - Halaman Profil
  - Halaman Settings
- ✅ Widget: Column, Row, Text, Container, ElevatedButton

### 2. Bottom Navigation Bar (10 poin) ✅
- ✅ 3 item: Home, Lowongan, Lamaran
- ✅ Implementasi dengan StatefulWidget
- ✅ Fungsi pindah halaman berfungsi

### 3. Halaman Lowongan (ListView/GridView) (15 poin) ✅
- ✅ Data dummy list sesuai ketentuan:
  - Staff IT, PT Maju Jaya, Soreang, Full-time
  - Admin Gudang, CV Sumber Rejeki, Cileunyi, Kontrak
  - Dan 3 lowongan lainnya
- ✅ AppBar: "Daftar Lowongan Pekerjaan"
- ✅ ListView dengan Card
- ✅ Kombinasi Row dan Column
- ✅ Menampilkan: posisi (bold), perusahaan, lokasi, tipe

### 4. Halaman Riwayat Lamaran (15 poin) ✅
- ✅ Data dummy lamaran sesuai ketentuan:
  - Staff IT, PT Maju Jaya, Diproses, 12-11-2025 08:30
  - Admin Gudang, CV Sumber Rejeki, Diterima, 15-11-2025 09:00
  - Dan 2 lamaran lainnya
- ✅ AppBar: "Riwayat Lamaran"
- ✅ ListView.builder()
- ✅ Menampilkan: posisi, perusahaan, status, tanggal & waktu

### 5. Halaman Profil & Pengaturan (10 poin) ✅
**ProfilePage:**
- ✅ Foto profil (CircleAvatar)
- ✅ Nama: Muhammad Anantha Mahardika Ridwan
- ✅ Email: anantha.mahardika@student.ac.id
- ✅ NIM: 70701240122
- ✅ Tombol ke SettingsPage

**SettingsPage:**
- ✅ Switch: Notifikasi Lowongan Baru (ON/OFF)
- ✅ Switch: Mode Gelap (ON/OFF)
- ✅ Switch: Notifikasi Status Lamaran (ON/OFF)

### 6. UI Menarik & Konsisten (10 poin) ✅
- ✅ Card dengan elevation dan border radius
- ✅ Warna konsisten (biru sebagai warna utama)
- ✅ Icon yang relevan
- ✅ Status badge dengan warna berbeda
- ✅ Layout responsive

### 7. RESTful API + Upload File (20 poin) ✅

#### Backend Laravel (✅ Sudah Selesai)
- ✅ Migration tabel lowongan & lamaran
- ✅ Model Lowongan & Lamaran dengan relasi
- ✅ Controller dengan CRUD lengkap
- ✅ Laravel Sanctum Authentication
- ✅ Upload File (CV & Dokumen)
- ✅ Seeder data dummy
- ✅ API Routes terdaftar

#### Frontend Flutter (✅ Sudah Selesai)
- ✅ HTTP Package & Dependencies
- ✅ API Config (base URL & headers)
- ✅ Auth Service (Login, Register, Logout)
- ✅ Lowongan Service (Get All, Get Detail)
- ✅ Lamaran Service (Get All, Submit, Upload)
- ✅ Model dengan fromJson/toJson
- ✅ Login & Register Page
- ✅ Dokumentasi Integrasi API

---

## 📁 STRUKTUR FILE

### Frontend Flutter
```
lib/
├── main.dart                    # Entry point + MaterialApp
├── models/
│   ├── lowongan.dart           # Model Lowongan + fromJson/toJson
│   └── lamaran.dart            # Model Lamaran + fromJson/toJson
├── services/
│   ├── api_config.dart         # Base URL & Headers
│   ├── auth_service.dart       # Login, Register, Logout
│   ├── lowongan_service.dart   # CRUD Lowongan
│   └── lamaran_service.dart    # CRUD Lamaran + Upload
├── pages/
│   ├── MainPage.dart           # Bottom Nav
│   ├── HomePage.dart           # Home dengan sambutan
│   ├── LowonganPage.dart       # List Lowongan
│   ├── LamaranPage.dart        # List Lamaran
│   ├── ProfilePage.dart        # Profil User
│   ├── SettingsPage.dart       # Settings dengan Switch
│   ├── LoginPage.dart          # Login Form
│   ├── RegisterPage.dart       # Register Form
│   ├── DetailLowonganPage.dart # Detail Lowongan
│   └── DetailLamaranPage.dart  # Detail Lamaran
└── assets/
    └── images/                 # Gambar assets
```

### Backend Laravel (Referensi)
```
api_laravel/
├── app/
│   ├── Models/
│   │   ├── Lowongan.php
│   │   ├── Lamaran.php
│   │   └── User.php
│   └── Http/Controllers/
│       ├── LowonganController.php
│       └── LamaranController.php
├── database/
│   ├── migrations/
│   │   ├── 2025_12_31_000001_create_lowongan_table.php
│   │   └── 2025_12_31_000002_create_lamaran_table.php
│   └── seeders/
│       └── LowonganSeeder.php
└── routes/
    └── api.php                 # API Routes
```

---

## 🔌 ENDPOINT API

### Autentikasi
```
POST   /api/register         # Registrasi user baru
POST   /api/login            # Login dan dapat token
POST   /api/logout           # Logout (hapus token)
GET    /api/me               # Get current user info
```

### Lowongan Pekerjaan (Public)
```
GET    /api/lowongan         # List semua lowongan
GET    /api/lowongan/{id}    # Detail lowongan
```

### Lamaran Pekerjaan (Protected)
```
GET    /api/lamaran                    # List lamaran user
POST   /api/lamaran                    # Kirim lamaran + upload CV
GET    /api/lamaran/{id}               # Detail lamaran
PUT    /api/lamaran/{id}               # Update lamaran
DELETE /api/lamaran/{id}               # Hapus lamaran
POST   /api/lamaran/{id}/upload-cv     # Upload CV saja
POST   /api/lamaran/{id}/upload-dokumen # Upload dokumen pendukung
```

---

## 🚀 CARA MENJALANKAN

### 1. Backend Laravel
```bash
# Masuk ke folder Laravel
cd "d:\Program Files\XAMPP\htdocs\PHP\PratikumPABW\Pratikum-PABW\Pratikum 13\api_laravel"

# Jalankan migration
php artisan migrate

# Jalankan seeder
php artisan db:seed --class=LowonganSeeder

# Link storage
php artisan storage:link

# Jalankan server
php artisan serve
# Server akan jalan di: http://localhost:8000
```

### 2. Frontend Flutter
```bash
# Masuk ke folder Flutter
cd "d:\Sekolah\Kuliah\Semester 3\Dasar Pemrograman Perangkat Bergerak (DPPB)\PratikumDPPB\Asessment2 (Remed)\smartjob_mobile"

# Update base URL di lib/services/api_config.dart
# static const String baseUrl = 'http://localhost:8000/api';

# Install dependencies
flutter pub get

# Jalankan aplikasi
flutter run
```

---

## 👤 AKUN DEMO TESTING

### Pelamar (User Biasa)
```
Email: mahasiswa@smartjob.com
Password: password123
```

### Admin
```
Email: admin@smartjob.com
Password: password123
```

---

## 📦 DEPENDENCIES FLUTTER

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  http: ^1.2.0                    # HTTP request ke API
  shared_preferences: ^2.2.2      # Simpan token
  file_picker: ^8.0.0+1           # Pick file untuk upload
  path_provider: ^2.1.2           # Path provider
```

---

## ✨ FITUR-FITUR UTAMA

### UI/UX
✅ Material Design 3
✅ Responsive Layout
✅ Loading Indicators
✅ Error Handling
✅ Form Validation
✅ Card Design dengan Shadow
✅ Color-coded Status (Diterima: Hijau, Diproses: Orange, Ditolak: Merah)
✅ Icons yang Relevan
✅ Bottom Navigation
✅ Smooth Navigation

### Backend Integration
✅ RESTful API with Laravel
✅ JWT Authentication (Sanctum)
✅ File Upload (CV & Dokumen)
✅ Database Relations
✅ API Documentation
✅ Seeder Data Dummy
✅ Error Handling
✅ Validation

### Security
✅ Token-based Authentication
✅ Protected Routes
✅ CORS Configuration
✅ Input Validation
✅ Secure File Upload

---

## 📸 SCREENSHOTS FLOW

1. **Splash/Home** → Sambutan SmartJob
2. **Bottom Nav** → Home / Lowongan / Lamaran
3. **Lowongan Page** → List dengan Card design
4. **Detail Lowongan** → Info lengkap + button apply
5. **Lamaran Page** → List lamaran dengan status
6. **Detail Lamaran** → Status colored badge
7. **Profile** → Foto, Nama, Email, NIM
8. **Settings** → 3 Switch settings
9. **Login** → Form login dengan validation
10. **Register** → Form register lengkap

---

## 🎯 POIN PENILAIAN

| No | Komponen | Poin | Status |
|----|----------|------|--------|
| 0 | Ketentuan Umum | 10 | ✅ |
| 1 | HomePage | 10 | ✅ |
| 2 | Bottom Navigation | 10 | ✅ |
| 3 | Halaman Lowongan | 15 | ✅ |
| 4 | Halaman Lamaran | 15 | ✅ |
| 5 | Profil & Settings | 10 | ✅ |
| 6 | UI Menarik & Konsisten | 10 | ✅ |
| 7 | RESTful API + Upload | 20 | ✅ |
| **TOTAL** | | **100** | **✅** |

---

## 📚 DOKUMENTASI

- **Flutter API Integration**: `FLUTTER_API_INTEGRATION.md`
- **Laravel API Documentation**: `API_DOCUMENTATION.md` (di repo Laravel)

---

## 🔧 TROUBLESHOOTING

### Error: Connection Refused
- Pastikan Laravel server jalan: `php artisan serve`
- Cek base URL di `api_config.dart`

### Error: 401 Unauthorized
- Token expired/invalid
- Logout dan login ulang

### File Upload Gagal
- Jalankan: `php artisan storage:link`
- Cek permission folder storage

---

## 👨‍💻 DEVELOPER

**Nama:** Muhammad Anantha Mahardika Ridwan  
**NIM:** 70701240122  
**Mata Kuliah:** Dasar Pemrograman Perangkat Bergerak (DPPB)  
**Dosen:** [Nama Dosen]  
**Semester:** 3  
**Tahun:** 2025

---

## 📝 CATATAN

✅ Semua ketentuan sudah terpenuhi
✅ Backend API Laravel sudah lengkap
✅ Frontend Flutter sudah terintegrasi
✅ Upload file sudah berfungsi
✅ Autentikasi sudah implementasi
✅ UI/UX menarik dan konsisten
✅ Dokumentasi lengkap

**Status: READY FOR SUBMISSION** 🎉
