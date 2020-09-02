import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../providers/product_provider.dart';
import '../dummy_products.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductProvider> _items = DUMMY_PRODUCTS;

  List<ProductProvider> get items {
    return [..._items];
  }

  List<ProductProvider> get favItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> fetchAndSetData() async {
    final url =
        "https://ganesh-flutter-demo-apps.firebaseio.com/W3Shopee/products.json";
    final response = await http.get(url);
    print(json.decode(response.body));
  }

  Future<void> addItem(ProductProvider product) async {
    String url =
        'https://ganesh-flutter-demo-apps.firebaseio.com/W3Shopee/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "title": product.title,
            "price": product.price,
            "description": product.description,
            "imageUrl": product.imageUrl,
            "isFavorite": product.isFavorite
          },
        ),
      );
      final newProd = ProductProvider(
        title: product.title,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProd);
      notifyListeners();
    } catch (error) {
      print("Error");
      throw error;
    }
  }

  ProductProvider findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void updateItem(ProductProvider product) {
    for (var i = 0; i < _items.length; i++) {
      if (_items[i].id == product.id) {
        _items[i] = product;
      }
    }
    notifyListeners();
  }

  void deleteItem(String id) {
    _items.removeWhere((element) => id == element.id);
    notifyListeners();
  }
}
