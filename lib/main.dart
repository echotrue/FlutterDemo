import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_demo/Button.dart';
import 'package:flutter_demo/form.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final appTitle = 'Flutter demo';

  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        primarySwatch: Colors.blue,
        fontFamily: '微软雅黑'
      ),
      routes: {
        '/': (context) => Home(title: appTitle),
        '/form': (context) => CustomForm(),
        '/button': (context) => CustomButton(),
      },
      /*home: Home(
        title: appTitle,
      ),*/
    );
  }
}

class Home extends StatelessWidget {
  final String title;

  Home({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('Home Page!')),
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          DrawerHeader(
            child: Text(
              'Drawer Header',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text(
              'Form demo',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w900),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/form');
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Button'),
            onTap: () {
              Navigator.pushNamed(context, '/button');
            },
          )
        ]),
      ),
    );
  }
}
