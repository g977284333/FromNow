import 'package:dio/dio.dart';
import 'package:fromnow/framework/network/http_manager.dart';

class BaseModel {
  get(
    url, {
    Map<String, dynamic> queryStringParam,
    Function successCallBack,
    CancelToken cancelToken,
    Function errorCallBack,
  }) {
    HttpManager.getInstance().get(url,
        queryStringParam: queryStringParam,
        cancelToken: cancelToken,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  post(String url, Options postParams, Function successCallBack,
      [Map<String, dynamic> queryStringParam,
      Function errorCallBack,
      CancelToken cancelToken]) {
    HttpManager.getInstance().post(url, postParams, successCallBack,
        queryStringParam, errorCallBack, cancelToken);
  }
}
