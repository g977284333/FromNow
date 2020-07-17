import 'package:flutter/material.dart';
import 'package:fromnow/mvvm/anim/fram_aniam_layout.dart';

/// 加载数据布局
class MFPageLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> paths = List();
    paths.add('images/loading/ic_loading_icon_0.png');
    paths.add('images/loading/ic_loading_icon_1.png');
    paths.add('images/loading/ic_loading_icon_2.png');
    paths.add('images/loading/ic_loading_icon_3.png');
    paths.add('images/loading/ic_loading_icon_4.png');
    paths.add('images/loading/ic_loading_icon_5.png');

    return Container(
      color: Colors.white,
      child: Center(
          child: MFFramAnimLayout(
        paths,
        width: 100,
        height: 100,
        duration: 500,
      )),
    );
  }
}
