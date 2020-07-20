import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fromnow/framework/mvvm/page_state.dart';
import 'package:fromnow/framework/mvvm/statepage/mf_page_empty.dart';
import 'package:fromnow/framework/mvvm/statepage/mf_page_error.dart';
import 'package:fromnow/framework/mvvm/statepage/mf_page_loading.dart';
import 'package:provider/provider.dart';

import 'base_view_model.dart';
import 'base_view_state.dart';
import 'iview.dart';

abstract class BaseView<T extends BaseViewModel> extends StatefulWidget
    implements IView {
  T viewModel;

  @override
  State<StatefulWidget> createState() {
    viewModel = createViewModel();
    viewModel?.title = getTitle();
    return BaseViewState(this, viewModel, registProviders());
  }

  T createViewModel();

  String getTitle() {
    return "";
  }

  /// titleView
  @override
  AppBar createAppBar(BuildContext ctx) {
    return AppBar(
      title: Selector(builder: (ctx, String title, _) {
        return Text(
          title ?? "",
          style: TextStyle(color: Color(0xFF474245)),
        );
      }, selector: (ctx, T model) {
        return model.title;
      }),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: getAppBarElevation(),
      leading: GestureDetector(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Image.asset(
            'images/ic_back.png',
            fit: BoxFit.scaleDown,
          ),
        ),
        onTap: () {
          Navigator.of(ctx).pop();
          onBack();
        },
      ),
    );
  }

  /// 显示loading页面
  void showLoading() {
    viewModel?.setPageState(PageState.loading);
  }

  /// 显示内容
  void showContent() {
    viewModel?.setPageState(PageState.content);
  }

  /// 显示错误页面
  void showError() {
    viewModel?.setPageState(PageState.error);
  }

  /// 空页面
  void showEmpty() {
    viewModel?.setPageState(PageState.empty);
  }

  /// 是否需要有多状态布局 默认需要
  bool showMultiPageState() {
    return true;
  }

  /// 注册其它的provider 默认没有其它provider
  List registProviders() {
    return null;
  }

  /// 构造加载中页面
  Widget createLoadingPageView() {
    return MFPageLoading();
  }

  /// 构造错误提示页面
  Widget createErrorPageView() {
    return MFPageError(
      viewModel: viewModel,
    );
  }

  /// 构造空页面
  @override
  Widget createEmptyPageView() {
    return MFPageEmpty(
      viewModel: viewModel,
    );
  }

  /// 界面可见 从后台切换到前台
  void resumed() {}

  /// 界面不可见 从前台切换到后台
  void paused() {}

  /// 点击返回按钮
  void onBack() {}

  getAppBarElevation() {
    return 0.2;
  }

  @override
  void dispose() {
    print("dispose");
    // 当前view监听释放
  }
}
