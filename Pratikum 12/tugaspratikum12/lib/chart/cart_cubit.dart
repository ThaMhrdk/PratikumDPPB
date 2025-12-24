// lib/chart/cart_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  // Logika Tambah Item
  void addToCart(Product product) {
    final updatedItems = List<Product>.from(state.items)..add(product);
    emit(state.copyWith(items: updatedItems));
  }

  // Logika Kosongkan Keranjang
  void clearCart() {
    emit(const CartState(items: []));
  }
}
