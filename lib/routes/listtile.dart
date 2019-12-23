import 'package:flutter/material.dart';
import 'package:flutter_demo/common/http/httpEntity.dart';
import 'package:flutter_demo/common/http/httpUtils.dart';

class NewsList extends StatefulWidget {
  _MyNewsList createState() => _MyNewsList();
}

class _MyNewsList extends State<NewsList> {
  ScrollController _scrollController = new ScrollController();

  bool isLoading = false;

  List items = new List();

  _getMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }

    final response = await getNewsList();
    setState(() {
      isLoading = false;
      if(response['data'] == null){
        print('没有更多数据');
      }
      items.addAll(response['data']);
//      items = response['data'];
    });
  }

  void initState() {
    this._getMoreData();
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: items.length + 1,
      itemBuilder: (BuildContext context, int index) {
        print(index.toString() + '====' + items.length.toString());
        if (index == items.length) {
          return new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Center(
              child: new Opacity(
                opacity: isLoading ? 1.0 : 00,
                child: new CircularProgressIndicator(),
              ),
            ),
          );
        }
        return Card(
          child: ListTile(
            leading: Image(
              image: NetworkImage(items[index]['imgList'][0]),
              width: 100.0,
            ),
            title: Text(items[index]['title']),
            onTap: () {
              print(items[index]);
            },
          ),
        );
//        return ;
      },
      controller: _scrollController,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List tile"),
        centerTitle: true,
      ),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
