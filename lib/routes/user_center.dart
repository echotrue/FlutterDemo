import 'package:flutter/material.dart';
import 'package:flutter_demo/common/app_style.dart';
import 'package:flutter_demo/common/http/httpEntity.dart';
import 'package:flutter_demo/routes/edit_user.dart';
import 'package:shimmer/shimmer.dart';

class UserCenter extends StatefulWidget {
  @override
  _UserCenter createState() => _UserCenter();
}

class _UserCenter extends State<UserCenter> {
  var realName;
  var email;
  var userId;
  var phone;
  var userName;

  _setUserInfo(userInfo) {
    userId = userInfo['user_id'];
    realName = userInfo['user_realname'];
    email = userInfo['user_email'];
    phone = userInfo['user_phone'];
    userName = userInfo['user_name'];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.white,
          actions: <Widget>[
            Row(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10),
//                child: GestureDetector(
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return EditUser(
                          realName: realName,
                          userId: userId,
                          phone: phone,
                          email: email,
                          userName: userName,
                        );
                      }),
                    );
                  },
//                  hoverColor: Colors.purple,
//                  focusColor: Colors.red,
                  highlightColor: Colors.white, //点击时背景色
//                  splashColor: Colors.purple,
                  child: Text('编辑信息', style: TextStyle(fontSize: 14)),
                  padding: EdgeInsets.all(5),
                ),
              ),
            ])
          ],
        ),
        body: FutureBuilder(
          future: getUserInfo(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              showToast(snapshot.data['msg']);
              return null;
            }
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              _setUserInfo(snapshot.data['result']);
              return _userInfo(snapshot.data['result']);
            }
            return _userInfoSkeleton;
          },
        ));
  }

  _userInfo(userInfo) {
    return Column(
      children: <Widget>[
        SizedBox(height: 30),
        Center(
          child: SizedBox(
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(userInfo['user_avatar']),
            ),
            width: 100,
            height: 100,
          ),
        ),
        SizedBox(height: 30),
        Center(
          child: Column(
            children: <Widget>[
              Text(userInfo['user_name']),
              Divider(),
              Text(userInfo['user_realname']),
              SizedBox(height: 10),
              Text(userInfo['user_email']),
              SizedBox(height: 10),
              Text(userInfo['user_phone']),
              SizedBox(height: 10),
              Text(userInfo['user_status'].toString()),
              SizedBox(height: 10),
              Text(userInfo['user_role_id'].toString()),
              SizedBox(height: 10),
              Text(userInfo['user_created_time']),
              SizedBox(height: 10),
              Text(userInfo['role']['name']),
            ],
          ),
        ),
      ],
    );
  }

  //骨架屏
  get _userInfoSkeleton => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30),
          Center(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.white,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(100.0)),
              ),
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(100.0)),
                  ),
                  Divider(),
                  Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(100.0)),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 200,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(100.0)),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 120,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(100.0)),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(100.0)),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(100.0)),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 180,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(100.0)),
                  ),
                  SizedBox(height: 10),
//                Text(userInfo['role']['name']),
                ],
              ),
            ),
          ),
        ],
      );
}
