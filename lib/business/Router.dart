import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fromnow/business/home/home_page_view.dart';
import 'package:fromnow/business/login/login_page_view.dart';
import 'package:fromnow/main.dart';

/// 配置路由
final routes = {
  '/': (context) => MyHomePage(),
  '/home': (context) => HomePageView(),
  '/login': (context) => LoginPageView(),
//  '/login':(context, {arguments}) => LoginPageView(arguments:arguments)
};

// 固定写法
var onGenerateRoute = (RouteSettings settings) {
  //统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
