import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

class ProductOverview extends StatelessWidget {
  ProductOverview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("W3Shopee"),
      ),
      body: ProductsGrid(),
    );
  }
}
