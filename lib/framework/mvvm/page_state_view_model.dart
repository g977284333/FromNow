import 'package:flutter/cupertino.dart';
import 'package:fromnow/framework/mvvm/page_state.dart';

class PageStateViewModel extends ChangeNotifier {
  // 初始化页面状态
  PageState _pageState;

  setViewState(PageState pageState) {
    this._pageState = pageState;
    notifyListeners();
  }
}
