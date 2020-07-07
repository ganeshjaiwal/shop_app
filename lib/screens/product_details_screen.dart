import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../providers/products_provider.dart';
import '../providers/cart_provider.dart';
import '../screens/cart_screen.dart';
import '../widgets/badge.dart';

class ProductDetailsScreen extends StatefulWidget {
  static String routeName = 'product-details';
  const ProductDetailsScreen({Key key}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _current = 0;
  int randomNumber = new Random().nextInt(50) + 5;
  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);
    final imgList = [
      loadedProduct.imageUrl + '?i=1',
      loadedProduct.imageUrl + '?i=2',
      loadedProduct.imageUrl + '?i=3',
      loadedProduct.imageUrl + '?i=4',
    ];
    final increasedPrice = loadedProduct.price + randomNumber;
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
        actions: <Widget>[
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ..._buildImageCorosal(imgList),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  Text(
                    loadedProduct.description,
                    softWrap: true,
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 20,
              ),
              alignment: Alignment.topLeft,
              child: Row(
                children: <Widget>[
                  Text(
                    "\$ ${loadedProduct.price}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "\$${increasedPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        decoration: TextDecoration.lineThrough,
                        decorationThickness: 1),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "(${(100 - (loadedProduct.price / increasedPrice) * 100).toStringAsFixed(0)}% OFF)",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.pink.shade500),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 20,
              ),
              alignment: Alignment.topLeft,
              child: Text(
                "inclusive of all taxes",
                style: TextStyle(
                  color: Colors.greenAccent.shade400,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Divider(
              height: 25,
              color: Colors.grey.shade200,
              thickness: 8,
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildImageCorosal(List<String> imgList) {
    return [
      CarouselSlider(
        options: CarouselOptions(
          height: 250.0,
          initialPage: 0,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
          aspectRatio: 2.0,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
        ),
        items: imgList.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                  left: 2.0,
                  right: 2.0,
                  bottom: 5.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.blueGrey.shade100,
                      spreadRadius: 2.0,
                      blurRadius: 5.0,
                    ),
                    new BoxShadow(
                        color: Colors.blueGrey.shade100,
                        spreadRadius: 2.0,
                        blurRadius: 5.0,
                        offset: Offset.infinite),
                  ],
                ),
                child: ClipRRect(
                  child: Image.network(
                    item,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: Text("Loading..."),
                      );
                    },
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              );
            },
          );
        }).toList(),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgList
            .asMap()
            .map(
              (index, item) {
                print("index: $index");
                print("current: $_current");
                return MapEntry(
                  index,
                  Container(
                    width: _current == index ? 5.0 : 4.0,
                    height: _current == index ? 5.0 : 4.0,
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 2.0,
                    ),
                    decoration: BoxDecoration(
                        boxShadow: _current == index
                            ? [
                                new BoxShadow(
                                  color: Colors.blueGrey.shade400,
                                  spreadRadius: 1.0,
                                  blurRadius: 5.0,
                                ),
                              ]
                            : [],
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Theme.of(context).primaryColor.withOpacity(0.7)
                            : Color.fromRGBO(0, 0, 0, 0.4)),
                  ),
                );
              },
            )
            .values
            .toList(),
      ),
    ];
  }
}
