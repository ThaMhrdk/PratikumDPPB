# Integrasi API SmartJob Mobile - Flutter

## 📋 Pendahuluan

Dokumen ini menjelaskan cara mengintegrasikan aplikasi Flutter SmartJob Mobile dengan backend API Laravel yang sudah dibuat.

## 🔧 Setup

### 1. Update Base URL API

Edit file `lib/services/api_config.dart`:

```dart
class ApiConfig {
  // PENTING: Ganti dengan URL Laravel Anda
  static const String baseUrl = 'http://localhost:8000/api';
  // Atau untuk testing dari device fisik:
  // static const String baseUrl = 'http://192.168.1.100:8000/api';
}
```

### 2. Install Dependencies

Jalankan perintah berikut di terminal:

```bash
cd "d:\Sekolah\Kuliah\Semester 3\Dasar Pemrograman Perangkat Bergerak (DPPB)\PratikumDPPB\Asessment2 (Remed)\smartjob_mobile"
flutter pub get
```

### 3. Menjalankan Laravel Server

Pastikan Laravel API server sudah berjalan:

```bash
cd "d:\Program Files\XAMPP\htdocs\PHP\PratikumPABW\Pratikum-PABW\Pratikum 13\api_laravel"
php artisan serve
```

## 📱 Fitur-Fitur yang Sudah Terintegrasi

### ✅ Autentikasi

#### Login
- Halaman: `LoginPage.dart`
- Service: `AuthService.login()`
- Endpoint: `POST /api/login`

**Cara menggunakan:**
1. Buka aplikasi
2. Klik tombol "Login" di HomePage (perlu ditambahkan)
3. Masukkan kredensial:
   - Pelamar: mahasiswa@smartjob.com / password123
   - Admin: admin@smartjob.com / password123

#### Register
- Halaman: `RegisterPage.dart`
- Service: `AuthService.register()`
- Endpoint: `POST /api/register`

#### Logout
- Service: `AuthService.logout()`
- Endpoint: `POST /api/logout`

### 📋 Lowongan Pekerjaan

#### Menampilkan List Lowongan
- Service: `LowonganService.getAllLowongan()`
- Endpoint: `GET /api/lowongan`
- Status: **Siap digunakan** (perlu update LowonganPage)

#### Detail Lowongan
- Service: `LowonganService.getLowonganById(id)`
- Endpoint: `GET /api/lowongan/{id}`

### 📝 Lamaran Pekerjaan

#### Menampilkan Lamaran User
- Service: `LamaranService.getMyLamaran()`
- Endpoint: `GET /api/lamaran`
- Status: **Siap digunakan** (perlu update LamaranPage)

#### Kirim Lamaran + Upload CV
- Service: `LamaranService.submitLamaran()`
- Endpoint: `POST /api/lamaran`
- Fitur: Upload file CV otomatis

#### Upload CV
- Service: `LamaranService.uploadCV()`
- Endpoint: `POST /api/lamaran/{id}/upload-cv`

#### Upload Dokumen Pendukung
- Service: `LamaranService.uploadDokumen()`
- Endpoint: `POST /api/lamaran/{id}/upload-dokumen`

## 🔄 Update Halaman-Halaman

### LowonganPage.dart - Integrasi API

Untuk mengintegrasikan data dari API, ubah LowonganPage dari menggunakan data dummy menjadi data dari API:

```dart
// Contoh implementasi di LowonganPage.dart
import '../services/lowongan_service.dart';

class LowonganPage extends StatefulWidget {
  const LowonganPage({super.key});

  @override
  State<LowonganPage> createState() => _LowonganPageState();
}

class _LowonganPageState extends State<LowonganPage> {
  final LowonganService _lowonganService = LowonganService();
  List<Lowongan> _lowonganList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLowongan();
  }

  Future<void> _loadLowongan() async {
    setState(() => _isLoading = true);
    
    final lowongan = await _lowonganService.getAllLowongan();
    
    setState(() {
      _lowonganList = lowongan;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Lowongan Pekerjaan"),
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _lowonganList.length,
              itemBuilder: (context, index) {
                final lowongan = _lowonganList[index];
                // ... rest of your UI code
              },
            ),
    );
  }
}
```

### LamaranPage.dart - Integrasi API

```dart
// Contoh implementasi di LamaranPage.dart
import '../services/lamaran_service.dart';

class LamaranPage extends StatefulWidget {
  const LamaranPage({super.key});

  @override
  State<LamaranPage> createState() => _LamaranPageState();
}

class _LamaranPageState extends State<LamaranPage> {
  final LamaranService _lamaranService = LamaranService();
  List<Lamaran> _lamaranList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLamaran();
  }

  Future<void> _loadLamaran() async {
    setState(() => _isLoading = true);
    
    final lamaran = await _lamaranService.getMyLamaran();
    
    setState(() {
      _lamaranList = lamaran;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Lamaran"),
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _lamaranList.length,
              itemBuilder: (context, index) {
                final lamaran = _lamaranList[index];
                // ... rest of your UI code
              },
            ),
    );
  }
}
```

## 📤 Cara Upload File CV

### Contoh Implementasi Upload CV:

```dart
import 'package:file_picker/file_picker.dart';
import 'dart:io';

Future<void> _uploadCV(int lamaranId) async {
  // Pilih file
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'doc', 'docx'],
  );

  if (result != null) {
    File file = File(result.files.single.path!);
    
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Upload
    final response = await _lamaranService.uploadCV(
      lamaranId: lamaranId,
      cvFile: file,
    );

    // Hide loading
    Navigator.pop(context);

    // Show result
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response['message']),
        backgroundColor: response['success'] ? Colors.green : Colors.red,
      ),
    );

    if (response['success']) {
      // Refresh data
      _loadLamaran();
    }
  }
}
```

## 🔐 Proteksi Halaman yang Memerlukan Login

Contoh middleware untuk cek login:

```dart
// Di initState atau didChangeDependencies
Future<void> _checkAuth() async {
  final authService = AuthService();
  final isLoggedIn = await authService.isLoggedIn();
  
  if (!isLoggedIn) {
    Navigator.pushReplacementNamed(context, '/login');
  }
}
```

## 🚀 Testing

### 1. Testing Login
- Buka aplikasi
- Navigasi ke Login
- Gunakan kredensial demo: mahasiswa@smartjob.com / password123
- Cek apakah redirect ke HomePage

### 2. Testing Lowongan API
- Login terlebih dahulu
- Buka halaman Lowongan
- Pastikan data dari API tampil
- Cek loading indicator

### 3. Testing Upload CV
- Login dan kirim lamaran
- Upload file CV
- Cek di folder Laravel: `storage/app/public/cv/`

## 🐛 Troubleshooting

### Error: Connection Refused
- Pastikan Laravel server berjalan: `php artisan serve`
- Cek base URL di `api_config.dart`
- Untuk testing dari device fisik, gunakan IP komputer bukan localhost

### Error: 401 Unauthorized
- Token mungkin expired atau tidak valid
- Logout dan login ulang
- Cek apakah token tersimpan dengan benar

### File Upload Gagal
- Pastikan `php artisan storage:link` sudah dijalankan
- Cek permission folder storage
- Cek max file size di php.ini

## 📚 Struktur File Service

```
lib/
├── services/
│   ├── api_config.dart         # Konfigurasi API
│   ├── auth_service.dart       # Service Autentikasi
│   ├── lowongan_service.dart   # Service Lowongan
│   └── lamaran_service.dart    # Service Lamaran
├── models/
│   ├── lowongan.dart           # Model Lowongan
│   └── lamaran.dart            # Model Lamaran
└── pages/
    ├── LoginPage.dart          # Halaman Login
    ├── RegisterPage.dart       # Halaman Register
    ├── LowonganPage.dart       # Halaman Lowongan
    └── LamaranPage.dart        # Halaman Lamaran
```

## ✅ Checklist Implementasi

- [x] Setup API Config
- [x] Auth Service (Login/Register/Logout)
- [x] Lowongan Service (Get All/Detail)
- [x] Lamaran Service (Get All/Submit/Upload)
- [x] Model dengan fromJson/toJson
- [x] Login & Register Page
- [ ] Update LowonganPage dengan API
- [ ] Update LamaranPage dengan API
- [ ] Implementasi Upload CV UI
- [ ] Testing End-to-End

## 📝 Catatan Penting

1. **Ubah Base URL** di `api_config.dart` sesuai dengan URL Laravel Anda
2. **Install Dependencies** dengan `flutter pub get`
3. **Testing** gunakan akun demo yang sudah disediakan
4. **Upload File** perlu permission storage di Android (tambahkan di AndroidManifest.xml)

## 🎯 Selesai!

Dengan dokumentasi ini, integrasi API sudah lengkap. Tinggal update beberapa halaman untuk menggunakan data dari API alih-alih data dummy.
