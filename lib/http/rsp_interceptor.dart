import 'package:dio/dio.dart';
import 'package:flutter_demo/http/base_model.dart';
import 'package:oktoast/oktoast.dart';

class ResponseInterceptor extends Interceptor {

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {

      try {
        var rsp = BaseModel.fromJson(response.data);
        //errorCode=日代表执行成功，不建议依赖任何非日的 errorCode.
        // errorcode =-1001 代表登录失效，需要重新登录。
        if (rsp.errorCode == 0) {
          if (rsp.data == null) {
            handler.next(Response(requestOptions: response.requestOptions, data: true));
          } else {
            handler.next(Response(requestOptions: response.requestOptions, data: rsp.data));
          }
        } else if (rsp.errorCode == -1001) {
          handler.reject(DioException(requestOptions: response.requestOptions, message: "未登录"));
          showToast("请先登录");
        }
      } catch(e) {
        handler.reject(DioException(requestOptions: response.requestOptions, message: "$e"));
      }

    } else {
      handler.reject(DioException(requestOptions: response.requestOptions));
    }
  }
}