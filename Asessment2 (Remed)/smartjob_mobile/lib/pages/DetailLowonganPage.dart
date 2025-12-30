// lib/pages/DetailLowonganPage.dart
import 'package:flutter/material.dart';
import '../models/lowongan.dart';

class DetailLowonganPage extends StatelessWidget {
  const DetailLowonganPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Menangkap data arguments
    final Lowongan lowongan =
        ModalRoute.of(context)!.settings.arguments as Lowongan;

    return Scaffold(
      appBar: AppBar(title: const Text("Detail Lowongan")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon header
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.work_outline,
                    size: 60,
                    color: Colors.blue.shade400,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Nama Posisi
              Center(
                child: Text(
                  lowongan.posisi,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Nama Perusahaan
              Center(
                child: Text(
                  lowongan.perusahaan,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),

              const SizedBox(height: 24),
              const Divider(thickness: 1),
              const SizedBox(height: 16),

              // Info Row: Lokasi & Tipe
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Lokasi
                  Column(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 28,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Lokasi",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(
                        lowongan.lokasi,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  // Tipe Pekerjaan
                  Column(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.green,
                        size: 28,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Tipe",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(
                        lowongan.tipe,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Deskripsi
              const Text(
                "Deskripsi Pekerjaan:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  lowongan.deskripsi,
                  style: const TextStyle(height: 1.6),
                ),
              ),

              const SizedBox(height: 30), 

              // Tombol Lamar Sekarang
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/apply', arguments: lowongan);
                  },
                  icon: const Icon(Icons.send),
                  label: const Text("Lamar Sekarang"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

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
