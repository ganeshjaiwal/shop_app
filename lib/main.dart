import 'package:flutter/material.dart';

import './helper.dart';
import './screens/product_details_screen.dart';
import './screens/product_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'W3Shopee',
      theme: ThemeData(
        primarySwatch: Helper.createMaterialColor(Color(0xFF155658)),
        accentColor: Helper.createMaterialColor(Color(0xFFf7b329)),
        fontFamily: "Lato",
      ),
      home: ProductOverview(),
      routes: {
        ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
      },
    );
  }
}
