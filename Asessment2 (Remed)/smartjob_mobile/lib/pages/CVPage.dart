// lib/pages/cv_page.dart
import 'package:flutter/material.dart';

class CVPage extends StatelessWidget {
  const CVPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CV Saya"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        // Agar bisa di-scroll jika gambar panjang
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            // Menampilkan Image Asset (Sesuai Modul 9)
            child: Image.asset(
              'assets/images/CV.png', // Pastikan nama file sesuai
              fit: BoxFit.contain, // Menyesuaikan gambar agar muat di layar
            ),
          ),
        ),
      ),
    );
  }
}
