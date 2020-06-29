import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_item.dart';
import '../providers/products_provider.dart';

class ProductsGrid extends StatelessWidget {
  ProductsGrid();

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final loadedProducts = productsProvider.items;
    return GridView.builder(
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
    );
  }
}
