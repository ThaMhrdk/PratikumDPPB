// lib/chart/cart_state.dart

// 1. Model Produk
class Product {
  final String name;
  final int price;

  const Product({required this.name, required this.price});
}

// 2. State Keranjang
class CartState {
  final List<Product> items;

  const CartState({this.items = const []});

  // Helper untuk menghitung total item
  int get totalItems => items.length;

  // Helper untuk menghitung total harga
  int get totalPrice =>
      items.fold(0, (total, product) => total + product.price);

  // Fungsi untuk update state (immutable)
  CartState copyWith({List<Product>? items}) {
    return CartState(items: items ?? this.items);
  }
}
