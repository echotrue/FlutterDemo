import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_demo/common/app_style.dart';
import 'package:flutter_demo/common/http/httpUtils.dart';

class LoginForm extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool pwdShow = false; //密码是否明文显示
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
//    usernameController.text =
    if (usernameController.text != null) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.only(top: 100, bottom: 30),
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  Text("DGame CI System",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25)),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: usernameController,
                    validator: (v) {
                      return v.trim().length > 0 ? null : "账号不能为空";
                    },
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: '用户名',
                        prefixIcon: Icon(Icons.account_circle)),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      return value.trim().length > 0 ? null : "密码不能为空";
                    },
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: '密码',
                        prefixIcon: Icon(Icons.lock)),
                  ),
                  SizedBox(height: 40),
                  Container(
//                    margin: EdgeInsets.only(top: 80),
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: _onLogin,
                      child: Text('Login'),
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onLogin() async {
    if ((_formKey.currentState as FormState).validate()) {
//      SizedBox(width: 24,height: 24,child: CircularProgressIndicator());
      showLoading(context);
//      await HttpUtils.request('/user/login',method: HttpUtils.GET,data: {username:_formKey.currentState.us});
//      print('验证通过');
//      sleep(Duration(seconds: 6));
//      Navigator.pop(context);
    }
  }
}
