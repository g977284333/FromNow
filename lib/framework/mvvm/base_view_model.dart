import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:fromnow/framework/mvvm/page_state.dart';
import 'package:fromnow/framework/mvvm/page_state_view_model.dart';

class BaseViewModel extends ChangeNotifier {
  PageStateViewModel _pageStateViewModel;
  List<StreamSubscription> subscriptionList = List();
  String title;

  BaseViewModel() {
    _pageStateViewModel = new PageStateViewModel();
  }

  setPageStateViewModel(PageStateViewModel value) {
    _pageStateViewModel = value;
  }

  setPageState(PageState pageState) {
    _pageStateViewModel?.setViewState(pageState);
  }

  /// 动态修改标题
  void changeTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  PageStateViewModel get pageStateModel => _pageStateViewModel;

  execute(Stream observable, void onData(dynamic event),
      {Function onError, void onDone(), bool cancelOnError}) {
    subscriptionList.add(observable.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError));
  }

  /// 空页面的点击事件
  void onDataEmptyClick() {}

  /// 网络错误点击
  void onNetErrorClick() {}

  @override
  void dispose() {
    for (StreamSubscription streamSubscription in subscriptionList) {
      streamSubscription?.cancel();
    }
    super.dispose();
  }
}
