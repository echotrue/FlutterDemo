import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        Container(
          width: 60.0,
          child: UserAccountsDrawerHeader(
            accountName: Text(
              'axlrose',
//              style: Theme.of(context).textTheme.title,
            ),
            accountEmail: Text('axlrose@gmail.com'),
            currentAccountPicture: CircleAvatar(
//              backgroundColor: Color(0xffff0000),
              backgroundImage: NetworkImage(
                  "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1576915213&di=488c2951c0ba8b9dfe53c123241e24dd&src=http://img.zcool.cn/community/01460b57e4a6fa0000012e7ed75e83.png@1280w_1l_2o_100sh.png"),
              radius: 100.0,
              foregroundColor: Color(0x55000000),
            ),
            onDetailsPressed: () {
              return showDialog(
                  context: context,
                  child: AlertDialog(
                    title: Text('详细信息'),
                    content: Text('~'),
                  ));
            },
          ),
        ),
        ListTile(
          leading: Icon(Icons.bookmark),
          title: Text(
            '布局',
            style: Theme.of(context).textTheme.title,
          ),
          onTap: () {
            Navigator.pushNamed(context, '/line');
          },
        ),
        ListTile(
          leading: Icon(Icons.bookmark),
          title: Text(
            'Form demo',
            style: Theme.of(context).textTheme.title,
          ),
          onTap: () {
            Navigator.pushNamed(context, '/form');
          },
        ),
        ListTile(
          leading: Icon(Icons.bookmark),
          title: Text(
            'Button',
            style: Theme.of(context).textTheme.title,
          ),
          onTap: () {
            Navigator.pushNamed(context, '/button');
          },
        ),
        ListTile(
          leading: Icon(Icons.bookmark),
          title: Text(
            '异步加载',
            style: Theme.of(context).textTheme.title,
          ),
          onTap: () {
            Navigator.pushNamed(context, '/sync');
          },
        ),
        ListTile(
          leading: Icon(Icons.bookmark),
          title: Text(
            'ListView Demo',
            style: Theme.of(context).textTheme.title,
          ),
          onTap: () {
            Navigator.pushNamed(context, '/news_list');
          },
        ),
        ListTile(
          leading: Icon(Icons.bookmark),
          title: Text(
            'Login Page',
            style: Theme.of(context).textTheme.title,
          ),
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
        )
      ]),
    );
  }
}
