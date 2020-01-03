import 'package:flutter/material.dart';
import 'package:flutter_demo/Button.dart';
import 'package:flutter_demo/routes/form.dart';
import 'package:flutter_demo/routes/future.dart';
import 'package:flutter_demo/routes/home.dart';
import 'package:flutter_demo/routes/line.dart';
import 'package:flutter_demo/routes/listtile.dart';
import 'package:flutter_demo/routes/login.dart';

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
          fontFamily: 'AppFont',
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 16.0),
            body1: TextStyle(fontSize: 14.0),
          )),
      routes: {
        '/': (context) => Home(title: appTitle),
        '/form': (context) => CustomForm(),
        '/button': (context) => CustomButton(),
        '/line': (context) => Line(),
        '/sync': (context) => MyFuture(),
        '/news_list': (context) => NewsList(),
        '/login': (context) => LoginForm(),
      },
    );
  }
}
