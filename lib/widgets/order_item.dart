import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders_provider.dart' as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItem orderItem;
  const OrderItem({Key key, this.orderItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 2,
        child: ListTile(
          title: Text(orderItem.amount.toStringAsFixed(2)),
          subtitle: Text(
            DateFormat("dd mm yyyy hh:mm").format(orderItem.date),
          ),
          trailing: IconButton(
            icon: Icon(Icons.expand_more),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
