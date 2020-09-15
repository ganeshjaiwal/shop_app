import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/HttpException.dart';

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
  final String orderUrl =
      'https://ganesh-flutter-demo-apps.firebaseio.com/W3Shopee/orders';
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartItems, double totalAmt) async {
    final resp = await http.post(
      orderUrl + '.json',
      body: json.encode(
        {
          'date': DateTime.now().toString(),
          'amount': totalAmt,
          'products': cartItems.toString(),
        },
      ),
    );
    if (resp.statusCode >= 400) {
      throw HttpException('Error placing your order');
    }
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(resp.body)['name'],
        date: DateTime.now(),
        amount: totalAmt,
        products: cartItems,
      ),
    );
    notifyListeners();
  }
}
