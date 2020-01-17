import 'package:flutter/material.dart';
import 'package:flutter_demo/common/app_style.dart';
import 'package:flutter_demo/common/http/httpEntity.dart';
import 'package:flutter_demo/common/skeleton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeleton_text/skeleton_text.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserInfo(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError || snapshot.data == null || snapshot.data['code'] != 200) {
            Navigator.of(context).pushNamedAndRemoveUntil('login', ModalRoute.withName('/login'));
//            return showToast(snapshot.data['msg']);
          }
          var userInfo = snapshot.data['result'];
          return Drawer(
//            elevation: 10,
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              Container(
                width: 60.0,
                child: UserAccountsDrawerHeader(
                  accountName: Text(userInfo['user_name']),
                  accountEmail: Text(userInfo['user_email']),
                  currentAccountPicture: GestureDetector(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(userInfo['user_avatar']),
                      radius: 100.0,
//                      foregroundColor: Color(0x55000000),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/user_center');
                    },
                  ),
                  otherAccountsPictures: <Widget>[
                    IconButton(
                      icon: Icon(Icons.power_settings_new, size: 30),
                      color: Colors.white,
                      onPressed: () async {
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        final ok = await preferences.remove('token');
                        if (ok) {
                          showToast('退出成功');
                          Navigator.of(context).pushNamedAndRemoveUntil('/login', ModalRoute.withName('/login'));
                        }
                      },
                      tooltip: '退出登录',
                    )
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text(
                  'Flutter Article',
                  style: Theme.of(context).textTheme.body1,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/news_list');
                },
              ),
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text(
                  '项目管理',
                  style: Theme.of(context).textTheme.body1,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/project');
                },
              ),
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text(
                  'Button',
                  style: Theme.of(context).textTheme.body1,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/button');
                },
              ),
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text(
                  '异步加载',
                  style: Theme.of(context).textTheme.body1,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/sync');
                },
              ),

              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text(
                  'Login Page',
                  style: Theme.of(context).textTheme.body1,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              )
            ]),
          );
        }
        return Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            Container(
              width: 60.0,
              child: UserAccountsDrawerHeader(
                accountName: Shimmer.fromColors(
                    child: Text('Username'), baseColor: Colors.grey[300], highlightColor: Colors.white),
                accountEmail: Shimmer.fromColors(
                    child: Text('a*****@email.com'), baseColor: Colors.grey[300], highlightColor: Colors.white),
                currentAccountPicture: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.white,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(100.0)),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text(
                '布局',
                style: Theme.of(context).textTheme.body1,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/line');
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text(
                'Form demo',
                style: Theme.of(context).textTheme.body1,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/form');
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text(
                'Button',
                style: Theme.of(context).textTheme.body1,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/button');
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text(
                '异步加载',
                style: Theme.of(context).textTheme.body1,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/sync');
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text(
                'ListView Demo',
                style: Theme.of(context).textTheme.body1,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/news_list');
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text(
                'Login Page',
                style: Theme.of(context).textTheme.body1,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            )
          ]),
        );
      },
    );
  }
}
