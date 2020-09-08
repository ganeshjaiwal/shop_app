import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../providers/cart_provider.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';
import '../screens/cart_screen.dart';
import '../providers/products_provider.dart';

enum FilterSectionValue { Favorite, All }

class ProductOverview extends StatefulWidget {
  ProductOverview({Key key}) : super(key: key);

  @override
  _ProductOverviewState createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  var _shouldOnlyFav = false;
  var _isInit = false;
  var _isLoading = false;

  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<ProductsProvider>(context).fetchAndSetData();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = true;
    super.didChangeDependencies();
  }

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
            ],
          ),
          Consumer<CartProvider>(
            builder: (_, cartItem, ch) => Badge(
              child: ch,
              value: cartItem.itemsCount > 9 ? '9+' : '${cartItem.itemsCount}',
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_shouldOnlyFav),
    );
  }
}
