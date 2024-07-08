import 'package:dio/dio.dart';
import 'package:flutter_demo/http/http_method.dart';

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