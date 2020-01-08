import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpUtils {
  // global dio object
  static Dio dio;

  // default options
//  static const String API_PREFIX = 'https://www.mxnzp.com/api';
  static const String API_PREFIX = 'http://192.168.1.197:8003/ci/api';

  ///user/login

  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;

  // http method
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  // create dio instance
  static Dio createInstance() {
    if (dio == null) {
      BaseOptions options = new BaseOptions(
        baseUrl: API_PREFIX,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );
      dio = new Dio(options);
    }
    return dio;
  }

  // request method
  static Future<Map> request(String url, {data, method}) async {
    data = data ?? {};
    method = method ?? 'GET';

    //token
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    data.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });

    print('request url :[' + method + ' ' + url + ']');
    print('request params:' + data.toString());

    Dio dio = createInstance();

    var result;

    try {
      Response response = await dio.request(url,
          data: data,
          options:
              new Options(method: method, headers: {"Access-Token": token}));
      result = response.data;
//      print('response：' + response.toString());
    } on DioError catch (e) {
      print('request error:' + e.toString());
    }
    return result;
  }

  static clear() {
    dio = null;
  }
}
