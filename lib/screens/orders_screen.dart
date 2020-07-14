import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_rawer.dart';
import '../providers/orders_provider.dart' show OrdersProvider;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static String routeName = 'orders';
  const OrdersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: ordersProvider.orders.length > 0
          ? ListView.builder(
              itemCount: ordersProvider.orders.length,
              itemBuilder: (ctx, index) => OrderItem(
                orderItem: ordersProvider.orders[index],
              ),
            )
          : Center(
              child: Text("You don't have order to show."),
            ),
    );
  }
}
