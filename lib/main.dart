import 'package:flutter/material.dart';
import 'package:flutter_demo/Button.dart';
import 'package:flutter_demo/routes/edit_user.dart';
import 'package:flutter_demo/routes/future.dart';
import 'package:flutter_demo/routes/home.dart';
import 'package:flutter_demo/routes/project.dart';
import 'package:flutter_demo/routes/listtile.dart';
import 'package:flutter_demo/routes/login.dart';
import 'package:flutter_demo/routes/user_center.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final appTitle = 'Flutter demo';
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.blue,
          primarySwatch: Colors.blue,
          fontFamily: 'HeadlandOne , AppFont',
          /*textTheme: TextTheme(
            headline: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 16.0),
            body1: TextStyle(fontSize: 14.0),
          )*/),
      navigatorKey: navigatorKey,
      onGenerateRoute: onGenerateRoute,
      /*routes: {
        '/': (context) => Home(title: appTitle),
        '/form': (context) => CustomForm(),
        '/button': (context) => CustomButton(),
        '/line': (context) => Line(),
        '/sync': (context) => MyFuture(),
        '/news_list': (context) => NewsList(),
        '/login': (context) => LoginForm(),
      },*/
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
//    routeHook
    tokenHook(settings, navigatorKey);
    Map<String, Widget> routes = {
      '/': Home(title: appTitle),
      '/user_center': UserCenter(),
      '/edit_user': EditUser(),
      '/button': CustomButton(),
      '/project': ProjectList(),
      '/sync': MyFuture(),
      '/news_list': NewsList(),
      '/login': LoginForm(),
    };

    bool mathMap = false;
    Route<dynamic> mathWidget;

    for (String key in routes.keys) {
      if (key == settings.name) {
        mathMap = true;
        mathWidget =
            MaterialPageRoute(builder: (BuildContext context) => routes[key]);
        break;
      }
    }
    if (mathMap) {
      return mathWidget;
    }

    return MaterialPageRoute(
        builder: (context) => Container(child: Text('404')));
  }

  tokenHook(RouteSettings settings, navigatorKey) async {
    String loginPath = '/login';
    if (settings.name == loginPath) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == '' || token == null) {
      navigatorKey.currentState.pushNamedAndRemoveUntil(
        loginPath,
        (route) => route == null,
      );
    }
  }
}
