import 'package:flutter/material.dart';

class ProjectEdit extends StatelessWidget {
  final String projectTitle = '添加项目';

  ProjectEdit({Key key, projectTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(this.projectTitle),
        centerTitle: true,
        actions: <Widget>[
          Center(
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: GestureDetector(
                  child: Text('保存'),
                  onTap: () {},
                )),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(20),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
//                style: TextStyle(fontSize: 26),
                decoration: InputDecoration(
                  labelText: '项目名称',
                  labelStyle: TextStyle(fontSize: 16),
                  contentPadding: EdgeInsets.all(0),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(fontSize: 26),
                decoration: InputDecoration(
                  labelText: '项目代码',
                  labelStyle: TextStyle(fontSize: 16),
                  contentPadding: EdgeInsets.all(0),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(fontSize: 26),
                decoration: InputDecoration(
                  labelText: '所属区域',
                  labelStyle: TextStyle(fontSize: 16),
                  contentPadding: EdgeInsets.all(0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
