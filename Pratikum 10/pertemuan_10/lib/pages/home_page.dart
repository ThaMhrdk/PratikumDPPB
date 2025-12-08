import 'package:flutter/material.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Selamat Datang di Home Page',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          const Text('Demonstrasi Pindah Halaman (PushNamed):'),
          const SizedBox(height: 10),
          // Tombol ke Profil
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            icon: const Icon(Icons.person),
            label: const Text('Ke Halaman Profil'),
          ),
          const SizedBox(height: 10),
          // Tombol ke Pengaturan
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: const Icon(Icons.settings),
            label: const Text('Ke Halaman Pengaturan'),
          ),
        ],
      ),
    );
  }
}
