
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  static Dio dio = Dio();

  static Dio getInstanceDio() {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) => requestInterceptor(options)));
    return dio;
  }

  static dynamic requestInterceptor(RequestOptions options) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    if (token != null) {
      options.headers.addAll({"Authorization": token});
    }
    return options;
  }
}