import 'package:flutter/material.dart';

import '../screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  final String title;
  final String id;
  final String imageUrl;
  final double price;
  const ProductItem({
    Key key,
    this.title,
    this.id,
    this.imageUrl,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Color(0xFFe4e3e3))),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailsScreen.routeName,
            arguments: id,
          );
        },
        child: GridTile(
          child: Column(
            children: <Widget>[
              Container(
                height: 190,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                // alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {},
                    color: Theme.of(context).accentColor,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      price.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFb12d17),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
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
