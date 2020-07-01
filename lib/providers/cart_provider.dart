import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem({
    @required this.id,
    @required this.price,
    @required this.title,
    @required this.quantity,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(
    String prodId,
    double price,
    String title,
  ) {
    if (_items.containsKey(prodId)) {
      _items.remove(prodId);
    } else {
      _items.putIfAbsent(
        prodId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void addQuantity(String prodId) {
    _items.update(
      prodId,
      (existingCartItem) => CartItem(
        id: existingCartItem.id,
        title: existingCartItem.title,
        price: existingCartItem.price,
        quantity: 1,
      ),
    );
    notifyListeners();
  }

  int get itemsCount {
    int cnt = 0;
    for (var item in _items.keys) {
      cnt += _items[item].quantity;
    }
    return cnt;
  }

  bool isAvailableInCart(prodId) {
    return _items.containsKey(prodId);
  }
}
