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
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        // padding: EdgeInsets.all(15),
        itemBuilder: (ctx, i) => ProductItem(
          title: loadedProducts[i].title,
          id: loadedProducts[i].id,
          imageUrl: loadedProducts[i].imageUrl,
          price: loadedProducts[i].price,
        ),
        itemCount: loadedProducts.length,
      ),
    );
  }
}
