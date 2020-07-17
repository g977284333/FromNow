import 'package:dio/dio.dart';
import 'package:fromnow/config/config.dart';

class LogInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    if (Config.DEBUG) {
      print(
          "\n======================================== 请求数据 ===========================================");
      print("url: ${options.uri.toString()}");
      print("headers: ${options.headers}");
      print("params: ${options.data}");
      print(
          "\n============================================================================================");
    }
    return super.onRequest(options);
  }

  @override
  Future onError(DioError err) {
    if (Config.DEBUG) {
      print(
          "\n======================================== 错误响应数据 ===========================================");
      print("type: ${err.type}");
      print("message: ${err.message}");
      print("response: ${err.response}");
      print("stackTrace: ${err.error}");
      print(
          "\n============================================================================================");
    }
    return super.onError(err);
  }

  @override
  Future onResponse(Response response) {
    if (Config.DEBUG) {
      print(
          "\n======================================== 响应数据 ===========================================");
      print("code: ${response.statusCode}");
      print("data: ${response.data}");
      print(
          "\n============================================================================================");
    }
    return super.onResponse(response);
  }
}
