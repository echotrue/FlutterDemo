import 'package:flutter/material.dart';
import 'package:flutter_demo/common/http/httpEntity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_demo/routes/article_detail.dart';
//import 'package:transparent_image/transparent_image.dart';

class NewsList extends StatefulWidget {
  _MyNewsList createState() => _MyNewsList();
}

class _MyNewsList extends State<NewsList> {
  ScrollController _scrollController = new ScrollController();

  bool isLoading = false;

  static const endTag = 'end';
  var items = <dynamic>[endTag];

  //src=web&tagId=5a96291f6fb9a0535b535438&page=0&pageSize=2&sort=rankIndex
  int page = 1;
  int totalItem = 0;

  // get data
  _getMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    Map<String, dynamic> dataMap = {
      "src": "web",
      "tagId": "5a96291f6fb9a0535b535438",
      "page": page,
      "pageSize": 10,
      "sort": "rankIndex"
    };
    final response = await getNewsList(dataMap);
//    print(response);
    setState(() {
      page += 1;
      totalItem = response['d']['total'];
      isLoading = false;
      items.insertAll(items.length - 1, response['d']['entrylist']);
//      print(page.toString() + '--------' + totalItem.toString());
    });
  }

  void initState() {
    super.initState();
    //初始获取数据
    this._getMoreData();
    //滑动到底部获取数据
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && items.length < totalItem) {
        this._getMoreData();
      }
    });
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildList() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: items.length - 1,
//      itemExtent: 80.0,
      itemBuilder: (BuildContext context, int index) {
//        print(index.toString()+'----'+items.length.toString());
        if (index == (items.length - 2)) {
          //最后一个
          if (items.length > totalItem) {
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "这就是我的底线",
                  style: TextStyle(color: Colors.grey),
                ));
          } else {
            return Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: SizedBox(width: 24.0, height: 24.0, child: CircularProgressIndicator(strokeWidth: 2.0)),
            );
          }
        } else {
          return Center(
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 16, right: 16),
              leading: SizedBox(
                  width: 56,
                  height: 56,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(items[index]['user']['avatarLarge'].trim()),
                    foregroundColor: Color(0x55000000),
                  )),
              title: Text(
                items[index]['title'],
                maxLines: 2,
                style: Theme.of(context).textTheme.body1,
              ),
              subtitle: Text(
                items[index]['createdAt'],
              ),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (_) {
                    return new ArticleDetail(
                      url: items[index]['originalUrl'],
                      title: items[index]['title'],
                    );
                  },
                ));
              },
              trailing: Container(
                child: Icon(
                  Icons.chevron_right,
                  size: 30.0,
                ),
              ),
            ),
          );
        }
      },
      controller: _scrollController,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          indent: 20.0,
          endIndent: 20.0,
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Article"),
        centerTitle: true,
      ),
      body: Container(
        child: items.length == 1 ? CircularProgressIndicator() : _buildList(),
        alignment: Alignment.center,
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
