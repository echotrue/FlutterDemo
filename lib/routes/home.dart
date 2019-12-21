import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/drawer.dart';

class Home extends StatelessWidget {
  final String title;

  Home({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.print),
              onPressed: () {},
              color: Colors.white,
            ),
            PopupMenuButton(itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(child: Text('share')),
                PopupMenuItem(child: Text('favorite')),
                PopupMenuItem(child: Text('about'))
              ];
            })
          ],
        ),
        body: Center(child: Column()),
        drawer: new AppDrawer());
  }
}
