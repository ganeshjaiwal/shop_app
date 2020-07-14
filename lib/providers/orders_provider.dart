import 'package:flutter/material.dart';

import '../providers/cart_provider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.date,
    @required this.products,
  });
}

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartItems, double totalAmt) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        date: DateTime.now(),
        amount: totalAmt,
        products: cartItems,
      ),
    );
    notifyListeners();
  }
}
