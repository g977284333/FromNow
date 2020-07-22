import 'package:fromnow/framework/config/config.dart';
import 'package:stack_trace/stack_trace.dart';

/// 日志输出类
class Logger {
  static const String TAG = "Logger";

  static i(String tag, String msg) {
    _log(LogMode.info, tag, msg);
  }

  static d(String tag, String msg) {
    _log(LogMode.debug, tag, msg);
  }

  static w(String tag, String msg) {
    _log(LogMode.warning, tag, msg);
  }

  static e(String tag, String msg) {
    _log(LogMode.error, tag, msg);
  }

  static _log(LogMode mode, String tag, String msg) {
    if (!Config.DEBUG) {
      return;
    }

    String modeStr = "";
    switch (mode) {
      case LogMode.info:
        modeStr = "💚 Info: ";
        break;
      case LogMode.debug:
        modeStr = "💙 Debug: ";
        break;
      case LogMode.warning:
        modeStr = "💛 Warning: ";
        break;
      case LogMode.error:
        modeStr = "❤️ Error: ";
        break;
      default:
        modeStr = "💚 Info: ";
        break;
    }
    print("$modeStr $tag ${_getStackTrace()} - $msg ");
  }

  static String _getStackTrace() {
    var chain = Chain.current();
    // 将 core 和 flutter 包的堆栈合起来（即相关数据只剩其中一条）
    chain.foldFrames((frame) => frame.isCore || frame.package == "flutter");
    // 去除所有的帧信息
    var frames = chain.toTrace().frames;
    // 找到当前函数的信息帧
    final idx = frames.indexWhere((element) => element.member == "Logger");
    if (idx == -1 || idx + 1 >= frames.length) {
      return "";
    }
    // 调用当前函数的函数信息帧
    final frame = frames[idx + 1];
    return "${frame.uri.toString().split("/").last}(${frame.line})";
  }
}

enum LogMode {
  debug, // 💚 DEBUG
  warning, // 💛 WARNING
  info, // 💙 INFO
  error, // ❤️ ERROR
}
