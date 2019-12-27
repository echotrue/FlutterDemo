import 'package:flutter/material.dart';
import 'package:flutter_demo/common/http/httpEntity.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:transparent_image/transparent_image.dart';

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
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: items.length - 1,
//      itemExtent: 80.0,
      itemBuilder: (BuildContext context, int index) {
        if (index == (items.length - 2)) {
          //最后一个
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
          return Center(
            child: ListTile(
              leading: CachedNetworkImage(
                imageUrl: items[index]['imgList'][0].toString().trim(),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 100.0,
                fit: BoxFit.cover,
              ),
              /*leading: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: items[index]['imgList'][0].toString().trim(),
                fit: BoxFit.cover,
                width: 100.0,
              ),*/
              /*leading: Image.network(
                items[index]['imgList'][0].toString().trim(),
                fit: BoxFit.cover,
                width: 100.0,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return RefreshProgressIndicator();
                  */ /*return CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    semanticsLabel: "loading",
                  );*/ /*
                },
              ),*/
              title: Text(
                items[index]['title'],
                maxLines: 2,
                style: Theme.of(context).textTheme.body1,
              ),
              subtitle: Text(
                items[index]['source'],
              ),
              onTap: () {
                print(items[index]);
              },
              trailing: Container(
                  child: Icon(
                Icons.chevron_right,
                size: 46.0,
              )),
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
        title: Text("ListView"),
        centerTitle: true,
      ),
      body: Container(
        child: items.length == 1 ? new LinearProgressIndicator() : _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
