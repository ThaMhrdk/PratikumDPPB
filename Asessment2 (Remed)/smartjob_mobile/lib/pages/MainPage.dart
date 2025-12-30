// lib/pages/MainPage.dart
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'LowonganPage.dart';
import 'LamaranPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Daftar halaman untuk navigasi bawah sesuai ketentuan: Home, Lowongan, Lamaran
  final List<Widget> _pages = [
    const HomePage(),
    const LowonganPage(),
    const LamaranPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      // Implementasi Bottom Navigation Bar dengan 3 item sesuai ketentuan
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Lowongan'),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Lamaran',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
