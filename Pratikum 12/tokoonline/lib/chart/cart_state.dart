class Product {
  final String name;
  final int price;

  const Product({required this.name, required this.price});
}

class CartState {
  final List<Product> items;

  const CartState({this.items = const []});

  int get totalItems => items.length;

  int get totalPrice =>
      items.fold(0, (total, product) => total + product.price);

  CartState copyWith({List<Product>? items}) {
    return CartState(items: items ?? this.items);
  }
}
