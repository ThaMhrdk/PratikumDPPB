// lib/pages/DetailLamaranPage.dart
import 'package:flutter/material.dart';
import '../models/lamaran.dart';

class DetailLamaranPage extends StatelessWidget {
  const DetailLamaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Menangkap data arguments
    final Lamaran lamaran =
        ModalRoute.of(context)!.settings.arguments as Lamaran;

    // Warna berdasarkan status
    Color statusColor;
    IconData statusIcon;
    if (lamaran.status == 'Diterima') {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle;
    } else if (lamaran.status == 'Ditolak') {
      statusColor = Colors.red;
      statusIcon = Icons.cancel;
    } else {
      statusColor = Colors.orange;
      statusIcon = Icons.hourglass_empty;
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Detail Lamaran")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon header dengan status
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(statusIcon, size: 60, color: statusColor),
                ),
              ),
              const SizedBox(height: 24),

              // Nama Posisi
              Center(
                child: Text(
                  lamaran.posisi,
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
                  lamaran.perusahaan,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),

              const SizedBox(height: 16),

              // Status Badge
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor),
                  ),
                  child: Text(
                    lamaran.status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Divider(thickness: 1),
              const SizedBox(height: 16),

              // Info Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Tanggal Lamaran
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.blue,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Tanggal Lamaran",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                lamaran.tanggal,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                  lamaran.deskripsi,
                  style: const TextStyle(height: 1.6),
                ),
              ),

              const SizedBox(height: 30),

              // Tombol Kembali
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Kembali"),
                  style: ElevatedButton.styleFrom(
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
