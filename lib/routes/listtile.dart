import 'package:flutter/material.dart';
import 'package:flutter_demo/common/http/httpEntity.dart';

class NewsList extends StatefulWidget {
  _MyNewsList createState() => _MyNewsList();
}

class _MyNewsList extends State<NewsList> {
  ScrollController _scrollController = new ScrollController();

  bool isLoading = false;

  static const endTag = 'end';
  var items = <dynamic>[endTag];

//  List items = new List();

  // get data
  _getMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    final response = await getNewsList();
    setState(() {
      isLoading = false;
      //
      items.insertAll(items.length - 1, response['data']);
    });
  }

  void initState() {
    super.initState();
    //初始获取数据
    this._getMoreData();
    //滑动到底部获取数据
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          items.length < 20) {
        this._getMoreData();
      }
    });
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: items.length - 1,
      itemExtent: 100.0,
      itemBuilder: (BuildContext context, int index) {
        if (index == (items.length - 2)) {
          //最后一个
          print('===== last one');
          if (items.length > 20) {
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "没有更多了",
                  style: TextStyle(color: Colors.grey),
                ));
          } else {
            return Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: CircularProgressIndicator(strokeWidth: 2.0)),
            );
          }
        } else {
          return Card(
            child: ListTile(
              leading: Image.network(
                items[index]['imgList'][0].toString().trim(),
                fit: BoxFit.cover,
                width: 100.0,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return RefreshProgressIndicator();
                  /*return CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    semanticsLabel: "loading",
                  );*/
                },
              ),
              title: Text(items[index]['title']),
              subtitle: Text(items[index]['source']),
              onTap: () {
                print(items[index]);
              },
              trailing: Icon(Icons.chevron_right),
              isThreeLine: true,
            ),
          );
        }
      },
      controller: _scrollController,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView"),
        centerTitle: true,
      ),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
