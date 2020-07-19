import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  // final String title;
  // final String id;
  // final String imageUrl;
  // final double price;
  // const ProductItem({
  //   Key key,
  //   this.title,
  //   this.id,
  //   this.imageUrl,
  //   this.price,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false);
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Color(0xFFe4e3e3))),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailsScreen.routeName,
            arguments: product.id,
          );
        },
        child: GridTile(
          child: Column(
            children: <Widget>[
              Container(
                height: 190,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                // alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                  product.title,
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Consumer<ProductProvider>(
                    builder: (ctx, product, child) => IconButton(
                      icon: Icon(product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border),
                      onPressed: () {
                        product.toggelFavoriteStatus();
                      },
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.price.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFb12d17),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Consumer<CartProvider>(
                    builder: (_, cartItem, ch) => IconButton(
                      icon: Icon(cartItem.isAvailableInCart(product.id)
                          ? Icons.shopping_cart
                          : Icons.add_shopping_cart),
                      onPressed: () {
                        if (!cartItem.isAvailableInCart(product.id)) {
                          Toast.show(
                            "✓ Added to cart!",
                            context,
                            textColor: Colors.white,
                            backgroundColor: Colors.black54,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM,
                          );
                          // Scaffold.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Container(
                          //       alignment: Alignment.center,
                          //       width: 200,
                          //       height: 50,
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.all(
                          //           Radius.circular(50),
                          //         ),
                          //         color: Colors.red,
                          //       ),
                          //       child: Text("✓ Added to cart!"),
                          //     ),
                          //     elevation: 2.0,
                          //     backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                          //     duration: Duration(seconds: 50),
                          //     // shape: RoundedRectangleBorder(
                          //     //   borderRadius: BorderRadius.all(
                          //     //     Radius.circular(50),
                          //     //   ),
                          //     // ),
                          //   ),
                          // );
                        } else {
                          Toast.show(
                            "✓ Removed from cart!",
                            context,
                            textColor: Colors.white,
                            backgroundColor: Colors.black54,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM,
                          );
                        }
                        cartItem.addItem(
                          product.id,
                          product.price,
                          product.title,
                        );
                      },
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              )
            ],
          ),
          // footer: GridTileBar(
          //   backgroundColor: Colors.black87,
          //   leading: IconButton(
          //     icon: Icon(Icons.favorite),
          //     onPressed: () {},
          //     color: Theme.of(context).accentColor,
          //   ),
          //   title: Text(title),
          //   trailing: IconButton(
          //     icon: Icon(Icons.shopping_cart),
          //     onPressed: () {},
          //     color: Theme.of(context).accentColor,
          //   ),
          // ),
        ),
      ),
    );
  }
}
