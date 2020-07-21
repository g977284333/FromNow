import 'package:fromnow/framework/mvvm/base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  String _username = ""; //用户名
  String _password = ""; //密码

  bool _isShowClear = false; // 是否显示输入框尾部的清除按钮
  bool _isShowPwd = false; // 是否显示输入框尾部的隐藏密码按钮
  bool _isPrivacyChecked = false; // 是否选择了用户隐私协议

  get username => _username;

  set username(value) {
    _username = value;
  }

  get isShowClear => _isShowClear;

  setIsShowClear(value) {
    _isShowClear = value;
    notifyListeners();
  }

  bool get isShowPwd => _isShowPwd;

  setIsShowPwd(bool value) {
    _isShowPwd = value;
    notifyListeners();
  }

  String get password => _password;

  setPassword(String value) {
    _password = value;
  }

  bool get isPrivacyChecked => _isPrivacyChecked;

  setIsPrivacyChecked(bool value) {
    _isPrivacyChecked = value;
    notifyListeners();
  }
}
