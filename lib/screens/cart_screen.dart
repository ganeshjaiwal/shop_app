import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart' as CartItemWidget;

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);
  static const routeName = "cart-screen";
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        actions: <Widget>[
          OutlineButton.icon(
              borderSide: BorderSide(color: Colors.transparent),
              onPressed: () {},
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).accentColor,
              ),
              label: Text(
                "Checkout",
                style: TextStyle(color: Theme.of(context).accentColor),
              ))
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                Text(
                  "Subtotal (${cartProvider.itemsCount} items): ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                Text(
                  "\$${cartProvider.totalAmount}",
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (ctx, i) => CartItemWidget.CartItem(
                prodId: cartProvider.items.keys.toList()[i],
                quantity: cartProvider.items.values.toList()[i].quantity,
              ),
            ),
          )
        ],
      ),
    );
  }
}
