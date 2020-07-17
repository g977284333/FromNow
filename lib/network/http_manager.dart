import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fromnow/config/config.dart';
import 'package:fromnow/network/header_interceptor.dart';
import 'package:fromnow/network/log_interceptor.dart';
import 'package:fromnow/utils/Logger.dart';

class HttpManager {
  static const String TAG = "HttpManager";

  static HttpManager _instance;
  Dio _dio;
  BaseOptions _baseOptions;

  static HttpManager getInstance() {
    if (null == _instance) _instance = new HttpManager();
    return _instance;
  }

  HttpManager() {
    _baseOptions = new BaseOptions(
      baseUrl: HttpAPI.BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 10000,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json;charset=UTF-8",
        HttpHeaders.acceptEncodingHeader: "gzip",
      },
      contentType: Headers.jsonContentType,
      //表示期望以那种格式(方式)接受响应数据。接受三种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.plain,
    );

    _dio = Dio(_baseOptions);

    if (Config.DEBUG) {
      setProxy();
    }

    _dio.interceptors.add(HeaderInterceptors(_dio));
    _dio.interceptors.add(LogInterceptors());
  }

  /// 设置代理
  void setProxy() {}

  /// Get请求
  get(
    url, {
    Map<String, dynamic> queryStringParam,
    Function successCallBack,
    CancelToken cancelToken,
    Function errorCallBack,
  }) async {
    _request(url, Method.GET, queryStringParam, successCallBack);
  }

  /// Post请求
  post(String url, Options postParams, Function successCallBack,
      [Map<String, dynamic> queryStringParam,
      Function errorCallBack,
      CancelToken cancelToken]) async {
    _request(url, Method.POST, queryStringParam, successCallBack, postParams,
        errorCallBack, cancelToken);
  }

  /// 基础请求逻辑
  _request(String url, Method method, Map<String, dynamic> queryStringParam,
      Function successCallBack,
      [Options postParams,
      Function errorCallBack,
      CancelToken cancelToken]) async {
    Response response;
    Map<String, dynamic> resultMap;
    if (method == null) {
      if (errorCallBack != null) {
        errorCallBack("Method type should not be null!");
      }
      throw "Method type should not be null!";
    }

    switch (method) {
      case Method.GET:
        try {
          response = await _dio.get(url,
              queryParameters: queryStringParam, cancelToken: cancelToken);
        } on DioError catch (e) {
          if (errorCallBack != null) {
            errorCallBack(_formatError(e));
          }
        }
        break;
      case Method.POST:
        try {
          response = await _dio.post(url,
              queryParameters: queryStringParam,
              options: postParams,
              cancelToken: cancelToken);
        } on DioError catch (e) {
          if (errorCallBack != null) {
            errorCallBack(_formatError(e));
          }
        }
        break;
      default:
        break;
    }

    try {
      resultMap = json.decode(response.data);
    } on DioError catch (e) {
      errorCallBack(
          "Json decode error: ${e.toString()} response: ${response.toString()}");
    }
    if (response.statusCode == 200) {
      if (successCallBack != null) {
        successCallBack(resultMap);
      }
    } else {
      if (errorCallBack != null) {
        errorCallBack(
            "response code is ${response.statusCode} msg ${response.statusMessage}");
      }
    }
  }

  /// 格式化错误
  String _formatError(DioError e) {
    String errorMsg;
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      errorMsg = "连接超时 ${e.toString()}";
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      errorMsg = "请求超时 ${e.toString()}";
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      errorMsg = "响应超时 ${e.toString()}";
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      errorMsg = "出现异常 ${e.toString()}";
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      errorMsg = "请求取消 ${e.toString()}";
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      errorMsg = "未知错误 ${e.toString()}";
    }
    Logger.i(TAG, errorMsg);
    return "errorMsg";
  }

  /// 下载文件
  downloadFile(urlPath, savePath, Function progressCallback,
      [Function errorCallBack,
      Map<String, dynamic> queryStringParam,
      CancelToken cancelToken]) async {
    Response response;
    try {
      response = await _dio.download(
        urlPath,
        savePath,
        queryParameters: queryStringParam,
        cancelToken: cancelToken,
        onReceiveProgress: (int count, int total) {
          //进度
          Logger.i(TAG, "$count $total");
          progressCallback(count, total);
        },
      );
    } on DioError catch (e) {
      errorCallBack(_formatError(e));
    }
    return response.data;
  }

  /// 上传文件
  uploadFile(String url, File file, Function successCallBack,
      [Map<String, dynamic> queryStringParam,
      Options postParams,
      Function errorCallBack,
      CancelToken cancelToken]) async {}
}

enum Method {
  GET,
  POST,
}
