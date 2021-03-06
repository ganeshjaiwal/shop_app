import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/edit_product_screen.dart';
import './providers/orders_provider.dart';
import './screens/manage_products_screen.dart';
import './screens/orders_screen.dart';
import './screens/cart_screen.dart';
import './providers/cart_provider.dart';
import './providers/products_provider.dart';
import './helper.dart';
import './screens/product_details_screen.dart';
import './screens/product_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrdersProvider(),
        )
      ],
      child: MaterialApp(
        title: 'W3Shopee',
        theme: ThemeData(
          primarySwatch: Helper.createMaterialColor(Color(0xFF155658)),
          accentColor: Helper.createMaterialColor(Color(0xFFf7b329)),
          fontFamily: "Lato",
        ),
        home: ProductOverview(),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          ManageProductScreen.routeName: (ctx) => ManageProductScreen(),
          EditProductScreen.routName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
