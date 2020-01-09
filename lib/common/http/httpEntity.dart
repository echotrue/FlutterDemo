// sync example
import 'package:flutter_demo/common/http/httpUtils.dart';

Future<String> mockNetworkData() async {
  return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
}

Future<Map<String, dynamic>> getNewsList() async {
  return await HttpUtils.request('/news/list?typeId=509&page=1',
      method: HttpUtils.GET, data: {'typeId': 509, 'page': 1});
}

// Get user info todo delete delayed
Future getUserInfo() {
  return Future.delayed(Duration(milliseconds: 300), () async {
    return await HttpUtils.request('/user/info');
  });
}

// Edit user
Future editUserInfo(Map<String, dynamic> userInfo) async {
  return await HttpUtils.request('/user',
      method: HttpUtils.PUT, data: userInfo);
}

// Project List
// pageNo=1&pageSize=10
Future projectList(Map<String, int> params) {
  return Future.delayed(Duration(milliseconds: 300), () async {
    return await HttpUtils.request('/system/project',
        method: HttpUtils.GET, data: params);
  });
}

///cloud/regions?pageNo=1&pageSize=10
