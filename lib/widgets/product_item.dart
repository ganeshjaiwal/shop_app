import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                  IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () {},
                    color: Theme.of(context).accentColor,
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
