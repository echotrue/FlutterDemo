import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Button demo'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'RaisedButton',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              RaisedButton(
                onPressed: () {},
                disabledColor: Colors.red,
                disabledTextColor: Colors.amber,
                child: Text("普通按钮"),
                textColor: Colors.white,
                color: Colors.blue,
                highlightColor: Colors.deepPurple,
                hoverColor: Colors.grey,
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'FlatButton',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              FlatButton(
                onPressed: () {},
                child: Text('普通按钮'),
                textColor: Colors.white,
                color: Colors.blue,
                highlightColor: Colors.deepPurple,
                hoverColor: Colors.grey,
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'OutlineButton',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              OutlineButton(
                onPressed: () {},
                child: Text('普通按钮'),
                textColor: Colors.red,
                splashColor: Colors.blue,
                highlightColor: Colors.black,
                shape: BeveledRectangleBorder(
                  side: BorderSide(
                    color: Colors.red,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'IconButton',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.check_box),
                disabledColor: Colors.blue,
                color: Colors.blue,
                focusColor: Colors.yellow,
                hoverColor: Colors.purple,
                highlightColor: Colors.green,
                splashColor: Colors.red,
              ),
            ],
          )
        ],
      ),
    );
  }
}
