import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

enum FilterSectionValue { Favorite, All }

class ProductOverview extends StatefulWidget {
  ProductOverview({Key key}) : super(key: key);

  @override
  _ProductOverviewState createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  var _shouldOnlyFav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("W3Shopee"),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (FilterSectionValue selectedValue) {
                setState(() {
                  if (selectedValue == FilterSectionValue.Favorite) {
                    _shouldOnlyFav = true;
                  } else {
                    _shouldOnlyFav = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text("Show Favorite"),
                      value: FilterSectionValue.Favorite,
                    ),
                    PopupMenuItem(
                      child: Text("Show All"),
                      value: FilterSectionValue.All,
                    ),
                  ])
        ],
      ),
      body: ProductsGrid(_shouldOnlyFav),
    );
  }
}
