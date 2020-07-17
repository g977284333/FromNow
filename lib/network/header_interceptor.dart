import 'package:dio/dio.dart';

class HeaderInterceptors extends InterceptorsWrapper {
  Dio dio;

  HeaderInterceptors(this.dio);

  @override
  onRequest(RequestOptions options) {
    return super.onRequest(options);
  }
}
