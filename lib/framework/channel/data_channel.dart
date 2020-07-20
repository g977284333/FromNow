import 'dart:async';

import 'package:flutter/services.dart';

class DataChannel {
  static const String CHANNEL = "cn.fromnow.data/plugin";
  static const counterPlugin = const EventChannel(CHANNEL);

  StreamSubscription _subscription;

  void initState() {
    //开启监听
    if (_subscription == null) {
      _subscription = counterPlugin
          .receiveBroadcastStream()
          .listen(_onEvent, onError: _onError);
    }
  }

  void dispose() {
    //取消监听
    if (_subscription != null) {
      _subscription.cancel();
    }
  }

  void _onEvent(Object event) {}

  void _onError(Object error) {}
}
