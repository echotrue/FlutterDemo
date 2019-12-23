import 'package:flutter/material.dart';
import 'package:flutter_demo/common/http/httpEntity.dart';

class MyFuture extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FutureBuilder"),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
          future: getNewsList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return Text("Contents : ${snapshot.data['code']}");
              }
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
