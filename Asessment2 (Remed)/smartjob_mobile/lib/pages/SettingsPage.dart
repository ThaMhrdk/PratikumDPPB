// lib/pages/SettingsPage.dart
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // State untuk Switch/Checkbox dummy
  bool _notifikasiLowonganBaru = true;
  bool _modeGelap = false;
  bool _notifikasiStatusLamaran = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pengaturan")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Notifikasi
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  "Notifikasi",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),

              // Card untuk pengaturan notifikasi
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Switch 1: Notifikasi Lowongan Baru (ON/OFF)
                    SwitchListTile(
                      title: const Text("Notifikasi Lowongan Baru"),
                      subtitle: const Text(
                        "Dapatkan notifikasi saat ada lowongan baru",
                      ),
                      value: _notifikasiLowonganBaru,
                      onChanged: (bool value) {
                        setState(() {
                          _notifikasiLowonganBaru = value;
                        });
                      },
                      secondary: const Icon(
                        Icons.work_outline,
                        color: Colors.blue,
                      ),
                      activeColor: Colors.blue,
                    ),
                    const Divider(height: 1),

                    // Switch 2: Notifikasi Status Lamaran (ON/OFF)
                    SwitchListTile(
                      title: const Text("Notifikasi Status Lamaran"),
                      subtitle: const Text(
                        "Dapatkan notifikasi update status lamaran",
                      ),
                      value: _notifikasiStatusLamaran,
                      onChanged: (bool value) {
                        setState(() {
                          _notifikasiStatusLamaran = value;
                        });
                      },
                      secondary: const Icon(
                        Icons.notifications_active,
                        color: Colors.orange,
                      ),
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Header Tampilan
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  "Tampilan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),

              // Card untuk pengaturan tampilan
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Switch 3: Mode Gelap (ON/OFF)
                    SwitchListTile(
                      title: const Text("Mode Gelap"),
                      subtitle: const Text("Aktifkan tema gelap aplikasi"),
                      value: _modeGelap,
                      onChanged: (bool value) {
                        setState(() {
                          _modeGelap = value;
                        });
                      },
                      secondary: Icon(
                        _modeGelap ? Icons.dark_mode : Icons.light_mode,
                        color: _modeGelap ? Colors.indigo : Colors.amber,
                      ),
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Header Tentang
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  "Tentang",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),

              // Card informasi aplikasi
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.info_outline,
                        color: Colors.blue,
                      ),
                      title: const Text("Versi Aplikasi"),
                      subtitle: const Text("1.0.0"),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.business, color: Colors.blue),
                      title: const Text("Pengembang"),
                      subtitle: const Text(
                        "Dinas Tenaga Kerja Kabupaten Bandung",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Tombol Kembali
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Kembali"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
