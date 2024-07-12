import 'package:dio/dio.dart';
import 'package:flutter_demo/http/cookie_interceptor.dart';
import 'package:flutter_demo/http/http_method.dart';
import 'package:flutter_demo/http/print_log_interceptor.dart';
import 'package:flutter_demo/http/rsp_interceptor.dart';

class DioInstance {
  static DioInstance? _instance;

  //静态的构造方法
  DioInstance._();

  static DioInstance instance() {
    return _instance ??= DioInstance._();
  }

  final Dio _dio = Dio();

  final _defaultTime = const Duration(seconds: 30);

  void initDio({
    required String baseUrl,
    String? httpMethod = HttpMethod.GET,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    String? contentType,
    ResponseType? responseType = ResponseType.json,
  }) {
    _dio.options = BaseOptions(
      method: httpMethod,
      baseUrl: baseUrl,
      connectTimeout: connectTimeout ?? _defaultTime,
      receiveTimeout: receiveTimeout ?? _defaultTime,
      sendTimeout: sendTimeout ?? _defaultTime,
      contentType: contentType,
      responseType: responseType,
    );

    //添加Cookie拦截器
    _dio.interceptors.add(CookieInterceptor());
    //添加打印拦截器
    _dio.interceptors.add(PrintLogInterceptor());
    //添加统一返回值的拦截器
    _dio.interceptors.add(ResponseInterceptor());
  }

  ///get请求
  Future<Response> get({
    required String path,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.get(
        path,
        queryParameters: params,
        options: options ?? Options(
          method: HttpMethod.GET,
          receiveTimeout: _defaultTime,
          sendTimeout: _defaultTime,
        ),
      cancelToken: cancelToken
    );
  }

  ///post请求
  Future<Response> post({
    required String path,
    Object? data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.post(
        path,
      data: data,
      queryParameters: params,
      options: options ?? Options(
        method: HttpMethod.POST,
        receiveTimeout: _defaultTime,
        sendTimeout: _defaultTime,
      ),
      cancelToken: cancelToken,
    );
  }

}