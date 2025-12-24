import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../chart/cart_cubit.dart';
import '../chart/cart_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang Belanja')),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final items = state.items;

          if (items.isEmpty) {
            return const Center(child: Text('Keranjang masih kosong'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final p = items[index];
                    return ListTile(
                      title: Text(p.name),
                      subtitle: Text('Rp ${p.price}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          cartCubit.removeAt(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('1 item dihapus dari keranjang'),
                              duration: Duration(seconds: 1),
                            ), // SnackBar
                          );
                        },
                      ), // IconButton
                    ); // ListTile
                  },
                ), // ListView.builder
              ), // Expanded
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ), // EdgeInsets.symmetric
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Total item: ${state.totalItems}'),
                    Text('Total harga: Rp ${state.totalPrice}'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        _showClearDialog(context);
                      },
                      child: const Text('Kosongkan Keranjang'),
                    ), // ElevatedButton
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Kembali'),
                    ), // OutlinedButton
                  ],
                ), // Column
              ), // Padding
            ],
          ); // Column
        },
      ), // BlocBuilder
    ); // Scaffold
  }

  void _showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kosongkan Keranjang?'),
        content: const Text(
          'Apakah Anda yakin ingin menghapus semua item di keranjang?',
        ), // Text
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ), // TextButton
          TextButton(
            onPressed: () {
              context.read<CartCubit>().clearCart();
              Navigator.pop(context);
            },
            child: const Text('Ya, Hapus'),
          ), // TextButton
        ],
      ), // AlertDialog
    );
  }
}
