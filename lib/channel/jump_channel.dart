import 'package:flutter/services.dart';

class JumpChannel {
  static const String CHANNEL = "cn.fromnow.jump/plugin";
  static const jumpChannel = MethodChannel(CHANNEL);

  Future<Null> jumpToNative(String method, Map<String, String> map) async {
    String result = await jumpChannel.invokeMethod(method, map);

    return result;
  }
}
