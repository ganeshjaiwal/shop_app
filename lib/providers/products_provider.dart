import 'package:flutter/material.dart';

import '../models/product.dart';
import '../dummy_products.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items {
    return [..._items];
  }

  void addItem() {
    // TODO Add Item to list of Items
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
