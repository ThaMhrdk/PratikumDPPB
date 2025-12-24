import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addToCart(Product product) {
    final updated = List<Product>.from(state.items)..add(product);
    emit(state.copyWith(items: updated));
  }

  void removeAt(int index) {
    final updated = List<Product>.from(state.items)..removeAt(index);
    emit(state.copyWith(items: updated));
  }

  void clearCart() {
    emit(const CartState(items: []));
  }
}
