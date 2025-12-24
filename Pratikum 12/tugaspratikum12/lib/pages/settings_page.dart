// lib/pages/settings_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../chart/cart_cubit.dart';
import '../chart/cart_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.settings, size: 80, color: Colors.grey),
            const SizedBox(height: 20),

            // Menampilkan Data dari State Cubit
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Text(
                      'Total Item: ${state.totalItems}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Total Harga: Rp ${state.totalPrice}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 30),

            // Tombol Reset dengan AlertDialog (Syarat Tugas)
            ElevatedButton.icon(
              icon: const Icon(Icons.delete_forever),
              label: const Text("Kosongkan Keranjang"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => _showClearDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Yakin ingin menghapus semua isi keranjang?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              // Panggil Fungsi Cubit
              context.read<CartCubit>().clearCart();
              Navigator.pop(context); // Tutup Dialog
            },
            child: const Text(
              "Ya, Hapus",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
