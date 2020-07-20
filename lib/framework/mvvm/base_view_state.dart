import 'package:flutter/material.dart';
import 'package:fromnow/framework/mvvm/base_view.dart';
import 'package:fromnow/framework/mvvm/base_view_model.dart';
import 'package:fromnow/framework/mvvm/iview.dart';
import 'package:fromnow/framework/mvvm/page_state.dart';
import 'package:provider/provider.dart';

import 'page_state_view_model.dart';

class BaseViewState<T extends BaseViewModel> extends State<BaseView>
    with WidgetsBindingObserver {
  /// 布局构造状态
  IView _iView;

  ///对应viewModel
  T _viewModel;

  /// 其他的provider
  List<ChangeNotifier> _providers;

  BaseViewState(this._iView, this._viewModel, this._providers);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _iView?.initState(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget contentView = _iView?.buildView(context);
    return MultiProvider(
        providers: createProviders(context),
        child: Scaffold(
          appBar: PreferredSize(
              child: _iView?.createAppBar(context) ?? null,
              preferredSize: Size.fromHeight(50)),
          body: Stack(
            children: createPageView(contentView),
          ),
        ));
  }

  /// 构造页面内容
  List<Widget> createPageView(Widget contentView) {
    List<Widget> widgets = List();
    widgets.add(contentView);
    bool canLoading = _iView == null ? false : _iView.showMultiPageState();
    if (canLoading) {
      // 加载中页面
      Widget loadingView =
          createStateView(_iView?.createLoadingPageView(), PageState.loading);
      if (loadingView != null) {
        widgets.add(loadingView);
      }
      // 错误页面
      Widget errorView =
          createStateView(_iView?.createErrorPageView(), PageState.error);
      if (errorView != null) {
        widgets.add(errorView);
      }
      // 空页面
      Widget emptyView =
          createStateView(_iView?.createEmptyPageView(), PageState.empty);
      if (emptyView != null) {
        widgets.add(emptyView);
      }
    }
    return widgets;
  }

  Widget createStateView(Widget stateView, PageState state) {
    if (stateView == null) {
      return null;
    }
    // 加载布局
    Widget sate = Consumer(
        builder: (context, PageStateViewModel viewModel, _) => Visibility(
              child: stateView,
              visible: viewModel?.pageState == state,
            ));
    return sate;
  }

  /// 创建别的 状态值监听器
  List<ChangeNotifierProvider> createProviders(BuildContext context) {
    List<ChangeNotifierProvider> providers = List();
    var baseProvider = ChangeNotifierProvider(
      create: (context) => _viewModel,
    );
    providers.add(baseProvider);
    if (_providers != null && _providers.isNotEmpty) {
      ChangeNotifierProvider provider;
      // 添加别的model
      for (ChangeNotifier notifier in _providers) {
        provider = ChangeNotifierProvider(create: (context) => notifier);
        providers.add(provider);
      }
    }
    bool showPageState = _iView == null ? false : _iView.showMultiPageState();
    // 添加页面多状态布局
    if (showPageState && (_viewModel?.pageStateModel ?? null) != null) {
      var pageStateProvider = ChangeNotifierProvider(
          create: (context) => _viewModel?.pageStateModel);
      providers.add(pageStateProvider);
    }
    return providers;
  }

  /// 生命周期
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _iView?.resumed();
    } else if (state == AppLifecycleState.paused) {
      _iView?.paused();
    }
  }

  @override
  void dispose() {
    _iView?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    // 释放资源
    if (_providers != null && _providers.isNotEmpty) {
      for (ChangeNotifier changeNotifier in _providers) {
        changeNotifier?.dispose();
      }
    }
    super.dispose();
  }
}
