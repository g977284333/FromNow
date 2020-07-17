import 'package:flutter/services.dart';
import 'package:fromnow/utils/Logger.dart';

class BasicChannel {
  static const String CHANNEL = "cn.fromnow.data/plugin";

  //StringCodec()为编码格式
  BasicMessageChannel<String> _basicMessageChannel =
      BasicMessageChannel(CHANNEL, StringCodec());

  void initState() {
    _basicMessageChannel.setMessageHandler((message) => Future<String>(() {
          print(message);
          //给Android端的返回值
          return "收到Native消息：" + message;
        }));
  }

  ///向native发送消息
  void sendToNative() {
    Future<String> future = _basicMessageChannel.send("");
    future.then((message) {
      Logger.i("CHANNEL", "返回值：" + message);
    });
  }
}
