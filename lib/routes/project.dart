import 'package:flutter/material.dart';
import 'package:flutter_demo/common/app_style.dart';
import 'package:flutter_demo/common/http/httpEntity.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:transparent_image/transparent_image.dart';

class ProjectList extends StatefulWidget {
  _ProjectList createState() => _ProjectList();
}

class _ProjectList extends State<ProjectList> {
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;
  static const endTag = 'end';
  var items = <dynamic>[endTag];

//pageNo: 1
//pageSize: 10
  int pageNo = 1;
  int pageSize = 10;

  void initState() {
    super.initState();
    //初始获取数据
    _getMoreData();
    //滑动到底部
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _getMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    final response = await projectList({"pageNo": pageNo, "pageSize": pageSize});

//    print(response);
    var step = response['result']['pageNo'] >= response['result']['totalPage'] ? 0 : 1;

    setState(() {
      isLoading = false;
      items.insertAll(items.length - 1, response['result']['data']);
      pageNo += step;
    });
  }

  Widget build(BuildContext context) {
    final title = '项目管理';

    return Scaffold(
      appBar: new AppBar(
        title: new Text(title),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('/project_edit');
            },
            tooltip: '添加项目',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.zero,
        child: items.length == 1 ? _buildProjectSkeleton() : _build(),
      ),
    );
  }

  _build() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: items.length - 1,
      itemBuilder: (BuildContext context, int index) {
        //加载到最后一个了
//        print(index.toString() + items.length.toString());
        if (index == items.length) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: SizedBox(width: 24.0, height: 24.0, child: CircularProgressIndicator(strokeWidth: 2.0)),
          );
        }
        return _buildItem(items[index]);
      },
      controller: _scrollController,
    );
  }

  _buildItem(item) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.indigoAccent,
            child: Text(item['project_name'].substring(0, 1)),
            foregroundColor: Colors.white,
          ),
          title: Text(item['project_name']),
          subtitle: Text(item['project_code']),
          trailing: Container(
            child: Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
            ),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: '编辑',
          color: Colors.blue,
          icon: Icons.edit,
          onTap: () {
            Navigator.of(context).pushNamed('/project_edit');
          },
        ),
        IconSlideAction(
          caption: '删除',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => _showSnackBar('Delete'),
        ),
      ],
    );
  }

  _showSnackBar(String action) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示？'),
            content: Text('确定删除该条记录？'),
            actions: <Widget>[
              FlatButton(
                child: Text('取消'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              FlatButton(
                child: Text('确定'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
        });
  }

  //构建骨架屏
  _buildProjectSkeleton() {
    List<Widget> listSkeleton = List();
    for (var i = 1; i <= 7; i++) {
      listSkeleton.add(_itemSkeleton);
    }
    return ListView(
      children: listSkeleton,
    );
  }

  get _itemSkeleton => Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.white,
          child: ListTile(
            leading: SkeletonAnimation(
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.white,
              ),
            ),
            title: SkeletonAnimation(
                child: Container(
              width: 100,
              height: 10,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(100.0)),
            )),
            subtitle: SkeletonAnimation(
                child: Container(
              width: 200,
              height: 10,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(100.0)),
            )),
            trailing: Container(
              child: Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
              ),
            ),
          ),
        ),
      );
}
