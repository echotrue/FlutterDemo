// sync example
import 'package:dio/dio.dart';
import 'package:flutter_demo/common/http/httpUtils.dart';

Future<String> mockNetworkData() async {
  return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
}

Future<Map<String, dynamic>> getNewsList(Map<String, dynamic> data) async {
  data = data ?? {};
  Dio dio = new Dio(BaseOptions(
    baseUrl: 'https://timeline-merger-ms.juejin.im/v1',
    connectTimeout: 10000,
    receiveTimeout: 3000,
  ));

  try {
    Response response = await dio.get('/get_tag_entry', queryParameters: data, options: new Options(method: 'GET'));
    return response.data;
  } on DioError catch (e) {
    print('请求失败');
  }

  return null;
/*  return await HttpUtils.request('/news/list?typeId=509&page=1',
      method: HttpUtils.GET, data: {'typeId': 509, 'page': 1});*/
}

// Get user info todo delete delayed
Future getUserInfo() {
  return Future.delayed(Duration(milliseconds: 300), () {
    return {
      'code': 200,
      'result': {
        'user_name': 'axlrose',
        'user_email': 'axlrose.huang@gmail.com',
        'user_avatar': 'https://user-gold-cdn.xitu.io/1519790365175e2d3ba2174d5c8f3fdc4687a8bbf5768.jpg'
      }
    };
  });
  return Future.delayed(Duration(milliseconds: 300), () async {
    return await HttpUtils.request('/user/info');
  });
}

// Edit user
Future editUserInfo(Map<String, dynamic> userInfo) async {
  return await HttpUtils.request('/user', method: HttpUtils.PUT, data: userInfo);
}

// Project List
// pageNo=1&pageSize=10
Future projectList(Map<String, int> params) {
  return Future.delayed(Duration(milliseconds: 300), () async {
    return await HttpUtils.request('/system/project', method: HttpUtils.GET, data: params);
  });
}

///cloud/regions?pageNo=1&pageSize=10
