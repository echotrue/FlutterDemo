import 'package:flutter/material.dart';
import 'package:flutter_demo/common/app_style.dart';
import 'package:flutter_demo/common/http/httpEntity.dart';

class EditUser extends StatefulWidget {
  EditUser({this.userName, this.realName, this.email, this.userId, this.phone});

  final String userName;
  final String realName;
  final String email;
  final int userId;
  final String phone;

  @override
  _EditUser createState() => _EditUser();
}

class _EditUser extends State<EditUser> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    nameController.text = widget.realName;
    passwordController.text = '';
    emailController.text = widget.email;
    phoneController.text = widget.phone;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
//        backgroundColor: Colors.white,
        elevation: 0,
//        automaticallyImplyLeading: false,
        /*leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blueAccent,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),*/
        actions: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: GestureDetector(
                  child: Icon(Icons.save),
                  onTap: _submit,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
//                autofocus: true,
                validator: (value) {
                  return value.trim().length > 0 ? null : "姓名不能为空";
                },
                controller: nameController,
                /*decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: '用户名',
                      prefixIcon: Icon(Icons.account_circle)),*/
              ),
              TextFormField(
                obscureText: true,
                controller: passwordController,
              ),
              TextFormField(
                validator: (value) {
                  return value.trim().length > 0 ? null : "邮箱不能为空";
                },
                controller: emailController,
              ),
              TextFormField(
                validator: (value) {
                  return value.trim().length > 0 ? null : "手机不能为空";
                },
                controller: phoneController,
              )
            ],
          ),
        ),
      ),
      /* floatingActionButton: FloatingActionButton(
//        onPressed: _submit,
        tooltip: '保存用户信息',
        child: Icon(Icons.save),
      ),*/
    );
  }

  _submit() async {
    var userMap = {
      'user_id': widget.userId,
      'user_realname': nameController.text,
      'user_phone': phoneController.text,
      'user_email': emailController.text,
      'user_name': widget.userName,
    };
    if (passwordController.text.isNotEmpty) {
      userMap['user_passwd'] = passwordController.text;
    }
    if ((_formKey.currentState as FormState).validate()) {
      showLoading(context);
      Future re;
      try {
        re = editUserInfo(userMap);
        re.then((v) {
          if (v['code'] != 200) {
            showToast(v['message']);
            return false;
          }
          //关闭loading
          Navigator.pop(context);
          return true;
        }).whenComplete(() {
          Navigator.of(context).pop();
        }).catchError((e) {
          showToast(e.toString());
          return false;
        });
      } catch (e) {
        showToast(e.toString());
        print(e.toString());
      } finally {}
    }
  }
}
