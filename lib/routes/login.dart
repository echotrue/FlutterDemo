import 'package:flutter/material.dart';
import 'package:flutter_demo/common/app_style.dart';
import 'package:flutter_demo/common/http/httpUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
//              autovalidate: true,
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
//                        contentPadding: EdgeInsets.only(bottom: 2),
                      border: UnderlineInputBorder(),
                      hintText: '用户名',
                      prefixIcon: Icon(Icons.account_circle),
                    ),
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

      var user;
      try {
        user = await HttpUtils.request('/user/login',
            method: HttpUtils.POST,
            data: {
              'username': usernameController.text,
              'password': passwordController.text
            });
      } catch (e) {
        showToast(e.toString());
      } finally {
        //关闭loading
        Navigator.pop(context);

        if (user['code'] != 200) {
          showToast(user['message']);
        } else {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          final setToken =
              await preferences.setString('token', user['result']['token']);
          if (setToken) {
            /*var userInfo = getUserInfo();
            userInfo.then((v) async {
              if (v['code'] != 200) {
                showToast(v['message']);
                return false;
              }
              print(v['result']);
              await preferences.setString('user_info', jsonEncode(v['result']));

              return true;
            }, onError: (e) {
              showToast(e.toString());
              return false;
            });*/
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => route == null);
          } else {
            print('保存token失败');
          }
        }
      }
    }
  }
}
