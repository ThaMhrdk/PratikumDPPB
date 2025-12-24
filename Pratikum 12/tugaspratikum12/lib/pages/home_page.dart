// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../chart/cart_cubit.dart';
import '../chart/cart_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Data Dummy Produk
  final List<Product> products = const [
    Product(name: 'Laptop Gaming', price: 15000000),
    Product(name: 'Mouse Wireless', price: 200000),
    Product(name: 'Keyboard Mekanikal', price: 500000),
    Product(name: 'Monitor 24 Inch', price: 2000000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.shopping_bag, color: Colors.teal),
              title: Text(product.name),
              subtitle: Text('Rp ${product.price}'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                onPressed: () {
                  // Panggil Cubit untuk tambah data
                  context.read<CartCubit>().addToCart(product);

                  // Tampilkan SnackBar (Syarat Tugas)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} masuk keranjang!'),
                      duration: const Duration(seconds: 1),
                      backgroundColor: Colors.teal,
                    ),
                  );
                },
                child: const Text(
                  'Beli',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
