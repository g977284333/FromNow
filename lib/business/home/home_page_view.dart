import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fromnow/business/home/HomeViewModel.dart';
import 'package:fromnow/framework/mvvm/base_view.dart';

class HomePageView extends BaseView<HomeViewModel> {
  @override
  Widget buildView(BuildContext context) {
    return GestureDetector(
      child: ListView(
        children: <Widget>[
          _buildHeaderView(),
        ],
      ),
    );
  }

  @override
  HomeViewModel createViewModel() {
    return HomeViewModel();
  }

  @override
  void initState(BuildContext context) {}

  Widget _buildHeaderView() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/home_top_bg.jpg'), fit: BoxFit.cover)),
      child: Row(
        children: <Widget>[
          Text("Seven Zone",
              style: TextStyle(color: Colors.white, fontSize: 12)),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 40,
                child: ClipOval(
                  child: Image.network(
                      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1580587706041&di=0d6e369fc135a9c427cda631e10ebe22&imgtype=0&src=http%3A%2F%2Fwww.beihaiting.com%2Fuploads%2Fallimg%2F170330%2F10723-1F3301UI5427.jpg"),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: Text("咨询"),
                color: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  double getAppBarHeight() {
    return 0;
  }
}
