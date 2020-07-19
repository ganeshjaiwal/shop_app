import 'package:flutter/material.dart';

class ManageProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const ManageProductItem({
    Key key,
    this.title,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
