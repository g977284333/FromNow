import 'package:flutter/material.dart';

import '../base_view_model.dart';

/// 空态页
class MFPageEmpty<T extends BaseViewModel> extends StatelessWidget {
  final T viewModel;

  const MFPageEmpty({Key key, @required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/img_empty_default.png'),
            Material(
              child: Ink(
                padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                child: InkWell(
                  child: Text('重新加载',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  onTap: () {
                    viewModel?.onDataEmptyClick();
                  },
                ),
                decoration: BoxDecoration(
                    color: Color(0xFFFF4891),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
              ),
            ),
            Container(
              // 太距中不太好看
              height: 140,
            )
          ],
        ),
      ),
    );
  }
}
