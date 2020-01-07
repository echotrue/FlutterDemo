// sync example
import 'package:flutter_demo/common/http/httpUtils.dart';

Future<String> mockNetworkData() async {
  return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
}

Future<Map<String, dynamic>> getNewsList() async {
  return await HttpUtils.request('/news/list?typeId=509&page=1',
      method: HttpUtils.GET, data: {'typeId': 509, 'page': 1});
}

// Get user info
Future<Map<String, dynamic>> getUserInfo() async {
  return await HttpUtils.request('/user/info');
}
