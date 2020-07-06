import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final prodId;
  final quantity;
  const CartItem({
    Key key,
    this.quantity,
    this.prodId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context);
    final catrItemDetailsMaxwidth = MediaQuery.of(context).size.width - 140;
    final productInCart = productsProvider.findById(prodId);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      // height: 160,
      child: Dismissible(
        key: ValueKey(prodId),
        background: Container(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          color: Theme.of(context).accentColor,
          child: Icon(
            Icons.favorite,
            color: Colors.white,
            size: 30,
          ),
        ),
        secondaryBackground: Container(
          padding: EdgeInsets.only(right: 20),
          alignment: Alignment.centerRight,
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete_sweep,
            color: Colors.white,
            size: 30,
          ),
        ),
        // direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          if (DismissDirection.startToEnd == direction) {
            productInCart.addToFavorite();
          }
          cartProvider.removeItem(prodId);
        },
        confirmDismiss: (direction) => this.promptUser(direction, context),
        child: Card(
          elevation: 3,
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 120,
                  padding: EdgeInsets.all(5),
                  child: Image.network(productInCart.imageUrl),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        productInCart.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: catrItemDetailsMaxwidth,
                        child: Text(
                          productInCart.description,
                          softWrap: true,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Container(
                        width: catrItemDetailsMaxwidth,
                        padding: EdgeInsets.symmetric(
                          vertical: 1,
                          horizontal: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Quantity: ",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      quantity == 1
                                          ? Icons.delete_outline
                                          : Icons.remove_circle_outline,
                                      size: 20,
                                      color: Colors.blueGrey,
                                    ),
                                    onPressed: () {
                                      cartProvider.removeQuantityByOne(prodId);
                                    },
                                  ),
                                  Text(
                                    '$quantity',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_circle_outline,
                                      size: 20,
                                      color: Colors.blueGrey,
                                    ),
                                    onPressed: () {
                                      cartProvider.addQuantityByOne(prodId);
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        width: catrItemDetailsMaxwidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Price: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    '\$${productInCart.price}',
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      '$quantity x \$${productInCart.price} = ',
                                      style: TextStyle(color: Colors.grey)),
                                  Text(
                                    '\$' +
                                        (quantity * productInCart.price)
                                            .toStringAsFixed(2),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> promptUser(
      DismissDirection direction, BuildContext context) async {
    String title;
    String content;
    if (direction == DismissDirection.startToEnd) {
      // This is a delete action
      title = "Add to favorite";
      content =
          "Do you want to remove this item from the cart and add it to favorite?";
    } else {
      // This is an archive action
      title = "Remove from cart";
      content = "Do you want to delete this item from the cart?";
    }
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  return Navigator.of(context).pop(true);
                },
                child: Text("Yes"),
              ),
              new FlatButton(
                onPressed: () {
                  return Navigator.of(context).pop(false);
                },
                child: Text("No"),
              ),
            ],
          ),
        ) ??
        false;
  }
}
