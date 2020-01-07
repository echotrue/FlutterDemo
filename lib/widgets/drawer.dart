import 'package:flutter/material.dart';
import 'package:flutter_demo/common/app_style.dart';
import 'package:flutter_demo/common/http/httpEntity.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserInfo(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return showToast('error');
          }
          var userInfo = snapshot.data['result'];
//          print(userInfo);
          return Drawer(
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
                      foregroundColor: Color(0x55000000),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/user_center');
                    },
                  ),
                  /*onDetailsPressed: () {
                    return showDialog(
                        context: context,
                        child: AlertDialog(
                          title: Text('详细信息'),
                          content: Text('~'),
                        ));
                  },*/
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
        }
        return Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            Container(
              width: 60.0,
              child: UserAccountsDrawerHeader(
                accountName: Text('--'),
                accountEmail: Text('--'),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 100.0,
                    foregroundColor: Color(0x55000000),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed('/user_center');
                  },
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
