import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('布局'),
        centerTitle: true,
      ),
      body: Container(
        width: 100.0,
        color: Colors.red,
        child: Row(
          children: <Widget>[],
        ),
      ),
    );
  }
}
