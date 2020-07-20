import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fromnow/business/login/Login_view_model.dart';
import 'package:fromnow/framework/mvvm/base_view.dart';
import 'package:fromnow/framework/utils/Logger.dart';

class LoginPageView extends BaseView<LoginViewModel> {
  final String TAG = "LoginPageView";

  // 焦点
  FocusNode _focusNodeUserName = new FocusNode();

  // 用户名输入框控制器，此控制器可以监听用户名输入框操作
  TextEditingController _userNameController = new TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _username = ""; //用户名
  var _isShowClear = false; // 是否显示输入框尾部的清除按钮

  @override
  Widget buildView(BuildContext context) {
    return new GestureDetector(
        onTap: () {
          // 点击空白区域，回收键盘
          Logger.i(TAG, "Touch block edge");
        },
        child: new ListView(
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          children: <Widget>[
            buildTitle(),
            buildTitleLine(),
            SizedBox(
              height: 70,
            ),
            buildInputID(),
          ],
        ));
  }

  Widget buildTitle() {
    return Padding(
      child: Text(
        "欢迎登录即刻",
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
      padding: EdgeInsets.fromLTRB(16, 32, 0, 0),
    );
  }

  Widget buildTitleLine() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 48,
          height: 2,
        ),
      ),
    );
  }

  Widget buildInputID() {
    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      child: new Form(
          key: _formKey,
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new TextFormField(
                controller: _userNameController,
                focusNode: _focusNodeUserName,
                // 设置键盘类型
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "请输入手机号",
                  prefixIcon: Icon(Icons.person),
                  // 尾部添加清除按钮
                  suffixIcon: (_isShowClear)
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            // 清空输入框内容
                            _userNameController.clear();
                          },
                        )
                      : null,
                ),
                // 验证用户名
                validator: validateUserName,
                // 保存数据
                onSaved: (String value) {
                  _username = value;
                },
              )
            ],
          )),
    );
  }

  String validateUserName(value) {
    // 正则匹配手机号
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    if (value.isEmpty) {
      return '用户名不能为空!';
    } else if (!exp.hasMatch(value)) {
      return '请输入正确手机号';
    }
    return null;
  }

  @override
  LoginViewModel createViewModel() {
    return LoginViewModel();
  }

  @override
  void initState(BuildContext context) {}
}
