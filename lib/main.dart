import 'package:flutter/material.dart';

import './screens/product_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'W3Shopee',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.deepOrangeAccent,
        fontFamily: "Lato",
      ),
      home: ProductOverview(),
    );
  }
}
