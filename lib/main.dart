import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_demo/Button.dart';
import 'package:flutter_demo/form.dart';
import 'package:flutter_demo/routes/future.dart';
import 'package:flutter_demo/routes/home.dart';
import 'package:flutter_demo/routes/line.dart';

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
      ),
      routes: {
        '/': (context) => Home(title: appTitle),
        '/form': (context) => CustomForm(),
        '/button': (context) => CustomButton(),
        '/line': (context) => Line(),
        '/sync': (context) => MyFuture(),
      },
    );
  }
}
