import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                child: Text(
                  widget.orderItem.products.length.toString(),
                ),
              ),
              title: Text(widget.orderItem.amount.toStringAsFixed(2)),
              subtitle: Text(
                DateFormat("dd mm yyyy hh:mm").format(widget.orderItem.date),
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
          ),
          if (_expanded)
            Container(
              height: min(widget.orderItem.products.length * 120.0 + 50, 300),
              child: ListView.builder(
                itemCount: widget.orderItem.products.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.only(bottom: 4),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text("1"),
                      ),
                      // Image.network(
                      //   prodProvider
                      //       .findById(widget.orderItem.products[index].id)
                      //       .imageUrl,
                      //   width: 60,
                      // ),
                      title: Text("11111"
                          // prodProvider
                          //     .findById(widget.orderItem.products[index].id)
                          //     .title,
                          ),
                      subtitle: Text("222222"
                          // prodProvider
                          //     .findById(widget.orderItem.products[index].id)
                          //     .description,
                          ),
                      trailing: Text(
                        "x${widget.orderItem.products[index].quantity}",
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
