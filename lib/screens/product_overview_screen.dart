import 'package:flutter/material.dart';

import '../widgets/product_item.dart';
import '../dummy_products.dart';
import '../models/product.dart';

class ProductOverview extends StatelessWidget {
  List<Product> loadedProducts = DUMMY_PRODUCTS;
  ProductOverview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("W3Shopee"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        padding: EdgeInsets.all(15),
        itemBuilder: (ctx, i) => ProductItem(
          title: loadedProducts[i].title,
          description: loadedProducts[i].description,
          imageUrl: loadedProducts[i].imageUrl,
        ),
        itemCount: loadedProducts.length,
      ),
    );
  }
}
