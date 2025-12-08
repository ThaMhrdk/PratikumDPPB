import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Praktikum Navigasi',
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      debugShowCheckedModeBanner: false,
      // Definisi Named Routes
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(), // Halaman Utama dengan Tab Bar
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}

// Widget utama yang menampung Tab Bar
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Jumlah Tab
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Aplikasi Navigasi Flutter'),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          // Implementasi Tab Bar di bagian bawah AppBar
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.tealAccent,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.person), text: 'Profil'),
              Tab(icon: Icon(Icons.settings), text: 'Settings'),
            ],
          ),
        ),
        // Isi konten tiap Tab
        body: const TabBarView(
          children: [
            HomePageContent(), // Konten Tab 1
            ProfilePage(), // Konten Tab 2 (Bisa dilihat lewat tab)
            SettingsPage(), // Konten Tab 3 (Bisa dilihat lewat tab)
          ],
        ),
      ),
    );
  }
}
