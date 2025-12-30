// lib/main.dart
import 'package:flutter/material.dart';
import 'package:smartjob_mobile/pages/DetailLowonganPage.dart';
import 'package:smartjob_mobile/pages/DetailLamaranPage.dart';
import 'package:smartjob_mobile/pages/ProfilePage.dart';
import 'package:smartjob_mobile/pages/HomePage.dart';
import 'package:smartjob_mobile/pages/LoginPage.dart';
import 'package:smartjob_mobile/pages/RegisterPage.dart';
import 'package:smartjob_mobile/pages/ApplyLamaranPage.dart';
import 'pages/MainPage.dart';
import 'pages/SettingsPage.dart';

void main() {
  runApp(const SmartJobMobile());
}

class SmartJobMobile extends StatelessWidget {
  const SmartJobMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Title sesuai ketentuan
      title: 'SmartJob Mobile',
      // Pengaturan Theme dengan warna utama
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      // Set Halaman Awal
      initialRoute: '/',
      // Implementasi Named Routes sesuai ketentuan + API routes
      routes: {
        '/': (context) => const MainPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/detaillowongan': (context) => const DetailLowonganPage(),
        '/detaillamaran': (context) => const DetailLamaranPage(),
        '/apply': (context) => const ApplyLamaranPage(),
      },
    );
  }
}
