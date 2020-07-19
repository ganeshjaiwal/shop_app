import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/products_provider.dart';

import '../providers/orders_provider.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem orderItem;
  const OrderItem({Key key, this.orderItem}) : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    final prodProvider = Provider.of<ProductsProvider>(context, listen: false);
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            elevation: 2,
            child: ListTile(
              onTap: () {
                setState(
                  () {
                    _expanded = !_expanded;
                  },
                );
              },
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                child: Text(
                  widget.orderItem.products.length.toString(),
                ),
              ),
              title: Text(
                "\$" + widget.orderItem.amount.toStringAsFixed(2),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                DateFormat("dd/mm/yyyy hh:mm").format(widget.orderItem.date),
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(
                    () {
                      _expanded = !_expanded;
                    },
                  );
                },
              ),
            ),
          ),
          if (_expanded)
            Container(
              height: min(widget.orderItem.products.length * 120.0 + 50, 300),
              child: ListView(
                children: createListOfOrderItems(
                  widget.orderItem.products,
                  prodProvider,
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> createListOfOrderItems(
    List<CartItem> products,
    ProductsProvider productsProvider,
  ) {
    final catrItemDetailsMaxwidth = MediaQuery.of(context).size.width - 140;
    return products.map(
      (prod) {
        final productInCart = productsProvider.findById(prod.prodId);
        return Card(
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
                                      '${prod.quantity} x \$${productInCart.price} = ',
                                      style: TextStyle(color: Colors.grey)),
                                  Text(
                                    '\$' +
                                        (prod.quantity * productInCart.price)
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
        );
      },
    ).toList();
  }
}
