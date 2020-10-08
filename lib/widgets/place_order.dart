import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart';
import '../providers/products_provider.dart';
import '../providers/cart_provider.dart';

class PlaceOrder extends StatelessWidget {
  const PlaceOrder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(
              "Place Order",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline5.fontSize,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dotted,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: createListOfItems(cartProvider, productsProvider),
              //     CartItemWidget.CartItem(
              //   prodId: cartProvider.items.keys.toList()[i],
              //   quantity: cartProvider.items.values.toList()[i].quantity,
              // ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Total: \$${cartProvider.totalAmount.toStringAsFixed(2)}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      try {
                        await ordersProvider.addOrder(
                          cartProvider.items.values.toList(),
                          cartProvider.totalAmount,
                        );
                        Navigator.pop(context);
                        cartProvider.clearCart();
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            elevation: 2,
                            title: Text("Order Placed"),
                            content: Text(
                                "Your order has been placed successfully."),
                            actions: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Ok"),
                                color: Colors.greenAccent,
                              ),
                            ],
                          ),
                        );
                      } catch (err) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            elevation: 2,
                            title: Text("Error!"),
                            content: Text(err.toString()),
                            actions: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Ok"),
                                color: Colors.redAccent,
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    color: Colors.pinkAccent.shade400,
                    child: Text(
                      "Place Oreder",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget createListOfItems(cartProvider, productsProvider) {
    List<Widget> items = [];
    for (int i = 0; i < cartProvider.items.length; i++) {
      items.add(
        Card(
          elevation: 2,
          margin: EdgeInsets.only(bottom: 4),
          child: ListTile(
            leading: Image.network(
              productsProvider
                  .findById(cartProvider.items.keys.toList()[i])
                  .imageUrl,
              width: 60,
            ),
            title: Text(
              productsProvider
                  .findById(cartProvider.items.keys.toList()[i])
                  .title,
            ),
            subtitle: Text(
              productsProvider
                  .findById(cartProvider.items.keys.toList()[i])
                  .description,
            ),
            trailing: Text(
              "x${cartProvider.items.values.toList()[i].quantity}",
            ),
          ),
        ),
      );
    }
    return Column(
      children: [...items],
    );
  }
}
