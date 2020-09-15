import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/HttpException.dart';

class ProductProvider with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;
  final String productsUrl =
      'https://ganesh-flutter-demo-apps.firebaseio.com/W3Shopee/products/';

  ProductProvider({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggelFavoriteStatus() async {
    isFavorite = !isFavorite;
    notifyListeners();
    final response = await http.patch(
      this.productsUrl + this.id + '.json',
      body: json.encode({
        'isFavorite': isFavorite,
      }),
    );
    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;
      notifyListeners();
      throw HttpException("Unable to update favrite status.");
    }
  }

  void addToFavorite() {
    isFavorite = true;
    notifyListeners();
  }
}
