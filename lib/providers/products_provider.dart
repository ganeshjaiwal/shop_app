import 'package:flutter/material.dart';

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

  void addItem(ProductProvider product) {
    final newProd = ProductProvider(
      title: product.title,
      price: product.price,
      description: product.description,
      imageUrl: product.imageUrl,
      id: DateTime.now().toString(),
    );
    _items.add(newProd);
    notifyListeners();
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
