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
          padding: EdgeInsets.only(right: 20),
          alignment: Alignment.centerRight,
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete_sweep,
            color: Colors.white,
            size: 30,
          ),
        ),
        direction: DismissDirection.endToStart,
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
                                    '\$${quantity * productInCart.price}',
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
}
