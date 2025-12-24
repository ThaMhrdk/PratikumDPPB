// lib/pages/profile_page.dart
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.teal,
            backgroundImage: AssetImage('assets/images/profile.jpeg'),
          ),
          SizedBox(height: 16),
          Text(
            'Muhammad Anantha Mahardika Ridwan',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text('NIM: 707012400122'),
          Text('Kelas: D4SIKC-48-01'),
        ],
      ),
    );
  }
}
