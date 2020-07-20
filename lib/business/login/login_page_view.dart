import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fromnow/business/login/Login_view_model.dart';
import 'package:fromnow/framework/mvvm/base_view.dart';

class LoginPageView extends BaseView<LoginViewModel> {
  @override
  Widget buildView(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new Column(
        children: <Widget>[new Text("Login")],
      ),
    );
  }

  @override
  LoginViewModel createViewModel() {
    return LoginViewModel();
  }

  @override
  void initState(BuildContext context) {}

  @override
  double getAppBarHeight() {
    return 0;
  }
}
