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
}
