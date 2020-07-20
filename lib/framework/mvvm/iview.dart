import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class IView {
  /// 布局初始化之前调用
  @protected
  void initState(BuildContext context);

  /// 创建布局
  @protected
  Widget buildView(BuildContext context);

  /// 是否需要多状态布局
  bool showMultiPageState();

  /// 构造loadingView
  Widget createLoadingPageView();

  /// 构造错误提示页面
  Widget createErrorPageView();

  /// 空页面
  Widget createEmptyPageView();

  /// 设置标题栏
  Widget createAppBar(BuildContext context);

  /// 界面可见 从后台切换到前台
  void resumed();

  /// 界面不可见 从前台切换到后台
  void paused();

  /// 返回
  void onBack();

  /// 页面销毁时
  void dispose();
}
