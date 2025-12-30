// lib/pages/LowonganPage.dart
import 'package:flutter/material.dart';
import '../models/lowongan.dart';
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
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadLowongan();
  }

  Future<void> _loadLowongan() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final lowongan = await _lowonganService.getAllLowongan();
      if (!mounted) return;
      setState(() {
        _lowonganList = lowongan;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Gagal memuat data: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Lowongan Pekerjaan"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadLowongan),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Memuat lowongan...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(_errorMessage!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadLowongan,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    if (_lowonganList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.work_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('Belum ada lowongan tersedia'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadLowongan,
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadLowongan,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _lowonganList.length,
        itemBuilder: (context, index) {
          final Lowongan lowongan = _lowonganList[index];
          // Setiap item ditampilkan sebagai Card
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/detaillowongan',
                  arguments: lowongan,
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                // Kombinasi Row dan Column di dalam Card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nama posisi (besar/bold)
                    Text(
                      lowongan.posisi,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Row untuk nama perusahaan
                    Row(
                      children: [
                        const Icon(
                          Icons.business,
                          size: 18,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          lowongan.perusahaan,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Row untuk lokasi kerja dan tipe pekerjaan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Lokasi kerja
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 18,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              lowongan.lokasi,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        // Tipe pekerjaan
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: lowongan.tipe == 'Full-time'
                                ? Colors.green.shade100
                                : lowongan.tipe == 'Part-time'
                                ? Colors.orange.shade100
                                : Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            lowongan.tipe,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: lowongan.tipe == 'Full-time'
                                  ? Colors.green.shade800
                                  : lowongan.tipe == 'Part-time'
                                  ? Colors.orange.shade800
                                  : Colors.blue.shade800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
