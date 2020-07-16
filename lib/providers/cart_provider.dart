import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  int quantity;
  final String prodId;

  CartItem({
    @required this.id,
    @required this.price,
    @required this.title,
    @required this.quantity,
    @required this.prodId,
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
          prodId: prodId,
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
        prodId: prodId,
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

  double get totalAmount {
    double amount = 0;
    _items.forEach((key, value) {
      amount += value.quantity * value.price;
    });
    return amount;
  }

  bool isAvailableInCart(prodId) {
    return _items.containsKey(prodId);
  }

  void addQuantityByOne(String prodId) {
    _items[prodId].quantity += 1;
    notifyListeners();
  }

  void removeQuantityByOne(String prodId) {
    if (_items[prodId].quantity == 1) {
      _items.removeWhere((key, value) => key == prodId);
    } else {
      _items[prodId].quantity -= 1;
    }
    notifyListeners();
  }

  void removeItem(String prodId) {
    this._items.remove(prodId);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
