import 'package:flutter/material.dart';

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
    return Container(
      child: Card(
        child: Container(
          child: Row(
            children: <Widget>[
              Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg"),
              Container(
                child: Column(
                  children: <Widget>[Text("Test")],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
