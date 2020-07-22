import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fromnow/business/login/Login_view_model.dart';
import 'package:fromnow/framework/mvvm/base_view.dart';
import 'package:fromnow/framework/utils/Logger.dart';

class LoginPageView extends BaseView<LoginViewModel> {
  final String TAG = "LoginPageView";

  // 焦点
  FocusNode _focusNodeUserName = new FocusNode();
  FocusNode _focusNodePassWord = new FocusNode();

  // 用户名输入框控制器，此控制器可以监听用户名输入框操作
  TextEditingController _userNameController = new TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget buildView(BuildContext context) {
    return new GestureDetector(
        onTap: () {
          // 点击空白区域，回收键盘
          Logger.i(TAG, "Touch block edge");
          _focusNodeUserName.unfocus();
          _focusNodePassWord.unfocus();
        },
        child: new ListView(
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          children: <Widget>[
            _buildTitle(),
            _buildTitleLine(),
            SizedBox(
              height: 60,
            ),
            _buildInputID(),
            _buildPrivacy(),
            SizedBox(height: 20.0),
            _buildLoginButton(context),
            SizedBox(height: 100.0),
            _buildThirdLogin(),
            SizedBox(height: 20),
            _buildRegisterAndPwdModified()
          ],
        ));
  }

  Widget _buildTitle() {
    return Padding(
      child: Text(
        "欢迎登录即刻",
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
      padding: EdgeInsets.fromLTRB(16, 32, 0, 0),
    );
  }

  Widget _buildTitleLine() {
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

  Widget _buildInputID() {
    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration:
          new BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
      child: new Form(
          key: _formKey,
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[buildLoginInput(), buildPassWordInput()],
          )),
    );
  }

  Widget buildLoginInput() {
    return new TextFormField(
      controller: _userNameController,
      focusNode: _focusNodeUserName,
      // 设置键盘类型
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "用户名",
        hintText: "请输入手机号",
        labelStyle: TextStyle(fontSize: 14),
        // 尾部添加清除按钮
        suffixIcon: (viewModel.isShowClear)
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
      validator: _validateUserName,
      // 保存数据
      onSaved: (String value) {
        viewModel.username(value);
      },
    );
  }

  Widget buildPassWordInput() {
    return new TextFormField(
      focusNode: _focusNodePassWord,
      decoration: InputDecoration(
        labelText: "密码",
        hintText: "请输入密码",
        labelStyle: TextStyle(fontSize: 14),
        // 是否显示密码
        suffixIcon: IconButton(
          icon: Icon(
              (viewModel.isShowPwd) ? Icons.visibility : Icons.visibility_off),
          iconSize: 16,
          // 点击改变显示或隐藏密码
          onPressed: () {
            Logger.i(TAG, "showPassword?");
            viewModel.setIsShowPwd(!viewModel.isShowPwd);
          },
        ),
      ),
      obscureText: !viewModel.isShowPwd,
      // 密码验证
      validator: _validatePassWord,
      onSaved: (String value) {
        viewModel.setPassword(value);
      },
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            "登录",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          color: Colors.blueAccent,
          shape: StadiumBorder(side: BorderSide(width: 0)),
          onPressed: () {
            //点击登录按钮，解除焦点，回收键盘
            _focusNodePassWord.unfocus();
            _focusNodeUserName.unfocus();

            if (_formKey.currentState.validate()) {
              // 只有输入通过验证，才会执行
              _formKey.currentState.save();
              // todo 登录操作
              Logger.i(
                  TAG,
                  "username: " +
                      viewModel.username +
                      " password " +
                      viewModel.password);
            }
          },
        ),
      ),
    );
  }

  Widget _buildPrivacy() {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new IconButton(
            icon: new Icon((viewModel.isPrivacyChecked)
                ? Icons.check_box
                : Icons.check_box_outline_blank),
            iconSize: 16,
            onPressed: () {
              viewModel.setIsPrivacyChecked(!viewModel.isPrivacyChecked);
            }),
        new Expanded(
            child: Text.rich(TextSpan(
                text: "我已认真阅读，理解并同意",
                style: TextStyle(fontSize: 12, color: Colors.black38),
                children: [
              TextSpan(
                  // 识别('recognizer')属性，一个手势识别器，它将接受触及此文本范围的事件。
                  // 手势('gestures')库的点击手势识别器('TapGestureRecognizer')类，识别点击手势。
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Logger.i(TAG, "点击了用户服务协议");
                    },
                  text: "《即可用户服务协议》",
                  style: TextStyle(fontSize: 12, color: Colors.blue)),
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Logger.i(TAG, "点击了用户服务协议");
                    },
                  text: "及",
                  style: TextStyle(fontSize: 12, color: Colors.black38)),
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Logger.i(TAG, "点击了隐私政策");
                    },
                  text: "《即可隐私政策》",
                  style: TextStyle(fontSize: 12, color: Colors.blue)),
            ])))
      ],
    );
  }

  _buildThirdLogin() {
    return new Column(
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(width: 80, height: 1, color: Colors.grey),
            new Text("其他登录方式",
                style: TextStyle(color: Colors.grey, fontSize: 14)),
            new Container(width: 80, height: 1, color: Colors.grey)
          ],
        ),
        SizedBox(height: 20),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              color: Colors.green[200],
              // 第三方库icon图标
              icon: Icon(Icons.add_comment),
              iconSize: 40.0,
              onPressed: () {
                Logger.i(TAG, "Third Login One");
              },
            ),
            IconButton(
              color: Colors.green[200],
              icon: Icon(Icons.message),
              iconSize: 40.0,
              onPressed: () {
                Logger.i(TAG, "Third Login Two");
              },
            ),
            IconButton(
              color: Colors.green[200],
              icon: Icon(Icons.email),
              iconSize: 40.0,
              onPressed: () {
                Logger.i(TAG, "Third Login Two");
              },
            )
          ],
        )
      ],
    );
  }

  Widget _buildRegisterAndPwdModified() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new GestureDetector(
          child: new Text("忘记密码？",
              style: TextStyle(color: Colors.blue, fontSize: 14)),
          onTap: () {
            Logger.i(TAG, "点击忘记密码");
          },
        ),
        new GestureDetector(
            child: new Text("立即注册",
                style: TextStyle(color: Colors.blue, fontSize: 14)),
            onTap: () {
              Logger.i(TAG, "点击立即注册");
            })
      ],
    );
  }

  /// 验证手机号
  String _validateUserName(value) {
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

  ///  验证密码
  String _validatePassWord(value) {
    if (value.isEmpty) {
      return '密码不能为空';
    } else if (value.trim().length < 6 || value.trim().length > 18) {
      return '密码长度不正确';
    }
    return null;
  }

  @override
  LoginViewModel createViewModel() {
    return LoginViewModel();
  }

  @override
  void initState(BuildContext context) {
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);
    // 监听用户名变化
    _userNameController.addListener(() {
      Logger.i(TAG, "UserName changed: " + _userNameController.text);
      // 监听文本框输入变化，控制清除按钮展示
      viewModel
          .setIsShowClear(_userNameController.text.length > 0 ? true : false);
    });
  }

  // 监听焦点
  Future<Null> _focusNodeListener() async {
    if (_focusNodeUserName.hasFocus) {
      Logger.i(TAG, "用户名获取焦点");
      _focusNodePassWord.unfocus();
    }

    if (_focusNodePassWord.hasFocus) {
      Logger.i(TAG, "密码获取焦点");
      _focusNodeUserName.unfocus();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _focusNodeUserName.removeListener(_focusNodeListener);
    _focusNodePassWord.removeListener(_focusNodeListener);
    _userNameController.dispose();
  }
}
