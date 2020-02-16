import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:async';

/*
 * 封装 restful 请求
 *
 * GET、POST、DELETE、PATCH
 * 主要作用为统一处理相关事务：
 *  - 统一处理请求前缀；
 *  - 统一打印请求信息；
 *  - 统一打印响应信息；
 *  - 统一打印报错信息；
 */
class DioRequest {
  /// global dio object
  static Dio dio;

  /// default options
  static const String API_PREFIX = 'https://novel.dkvirus.com/api/v1';
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  ///Get请求测试
  static void getHttp() async {
    try {
      Response response = await Dio().get(API_PREFIX);
      print("response$response");
    } catch (e) {
      print(e);
    }
  }

  /// request method
  //url 请求链接
  //parameters 请求参数
  //metthod 请求方式
  //onSuccess 成功回调
  //onError 失败回调
  static Future<Map> request<T>(String url,
      {parameters,
        method,
        Function(String data) onSuccess,
        Function(String error) onError}) async {
    parameters = parameters ?? {};
    method = method ?? 'GET';

    /// 请求处理
    parameters.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });

    Dio dio = createInstance();
    //请求结果
    try {
      Response response = await dio.request(url, data: parameters, options: new Options(method: method));
      if (response.statusCode == 200) {
        var data = json.decode(response.data);
        if (data["code"] == 200) {
          onSuccess(data);
        }else{
          onError(data["msg"]);
        }
      } else {
        throw Exception('statusCode:${response.statusCode}');
      }
    } on DioError catch (e) {
      print('请求出错：' + e.toString());
      onError(e.toString());
    }
  }

  /// 创建 dio 实例对象
  static Dio createInstance() {
    if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      var options = BaseOptions(
        connectTimeout: 15000,
        receiveTimeout: 15000,
        responseType: ResponseType.plain,
        validateStatus: (status) {
          // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
          return true;
        },
        baseUrl: "http://poetry.huhustory.com/",
      );

      dio = new Dio(options);
    }
    return dio;
  }

  /// 清空 dio 对象
  static clear() {
    dio = null;
  }
}