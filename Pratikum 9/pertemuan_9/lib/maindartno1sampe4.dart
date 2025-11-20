import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // --- IMPLEMENTASI TITLE SECTION (SOAL 1) ---
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Wisata Gunung di Batu',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Text(
                  'Batu, Malang, Indonesia',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Icon(Icons.star, color: Colors.red[500]),
          const Text('41'),
        ],
      ),
    );

    // --- IMPLEMENTASI BUTTON SECTION (SOAL 2) ---
    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'CALL'),
        _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    );

    // --- IMPLEMENTASI TEXT SECTION (SOAL 3) ---
    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: const Text(
        'Batu, Malang adalah salah satu kota wisata terpopuler di Jawa Timur. '
        'Dikelilingi oleh pegunungan yang indah dan udara yang sejuk, '
        'kota ini menawarkan berbagai destinasi menarik mulai dari wisata alam hingga buatan. '
        'Sangat cocok untuk liburan keluarga maupun petualangan alam.\n\n'
        'Nama: Muhammad Anantha Mahardika Ridwan\n'
        'NIM: 707012400122',
        softWrap: true,
      ),
    );

    return MaterialApp(
      title: 'Flutter Layout: Muhammad Anantha Mahardika Ridwan - 707012400122',
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter layout demo')),
        // --- IMPLEMENTASI IMAGE SECTION (SOAL 4) ---
        // Mengganti Column dengan ListView agar bisa di-scroll [cite: 563]
        body: ListView(
          children: [
            // Menambahkan Gambar dari Aset
            Image.asset(
              'assets/images/gunung.jpg', // Ganti dengan nama file gambar Anda yang sebenarnya
              width: 600,
              height: 240,
              fit: BoxFit.cover, // Menutupi area gambar
            ),
            titleSection, // Soal 1
            buttonSection, // Soal 2
            textSection, // Soal 3
          ],
        ),
      ),
    );
  }

  // --- HELPER METHOD (SOAL 2) ---
  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
