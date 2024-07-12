import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/utils/sp_utils.dart';

class CookieInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //取出本地cookie，
    SpUtils.getStringList(Constants.K_Cookie_List).then((cookieList) {
      //塞到请求头里
      options.headers[HttpHeaders.cookieHeader] = cookieList;
      //继续往下执行
      handler.next(options);
    });
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {

    if (response.requestOptions.path.contains("user/login")) {
      //取出cookie信息
      dynamic list = response.headers[HttpHeaders.setCookieHeader];
      if (list is List) {
        List<String> cookieList = [];
        for (String? cookie in list) {
          print("CookieInterceptor cookie = ${cookie.toString()}");
          cookieList.add(cookie ?? "");
        }

        SpUtils.saveStringList(Constants.K_Cookie_List, cookieList);
      }
    }

    super.onResponse(response, handler);
  }
}