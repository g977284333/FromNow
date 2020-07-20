import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoGalleryRoute extends PageRouteBuilder {
  final Widget page;

  PhotoGalleryRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

/// 图片预览
class PhotoGallery extends StatefulWidget {
  List imgDataList = [];

  PageController controller;

  GestureTapCallback onLongPress;

  /// 长按事件
  OnTapPageItem onTap;

  /// 点击事件

  bool hiddenIndicator;

  /// 是否隐藏指示器
  Color indicatorNormalColor;

  /// 指示器球的正常颜色
  Color indicatorCurrentColor;

  /// 指示器球的当前颜色
  double indicatorWidth;

  /// 指示器球的宽高
  double indicatorMargin;

  /// 默认的位置
  int initialPage;

  PhotoGallery(
      {Key key,
      @required this.imgDataList,
      this.controller,
      this.onLongPress,
      this.hiddenIndicator = false,
      this.indicatorWidth = 6,
      this.indicatorMargin = 2,
      this.indicatorCurrentColor = Colors.white,
      this.indicatorNormalColor = Colors.grey,
      this.initialPage = 0})
      : super(key: key) {
    if (initialPage < 0) {
      initialPage = 0;
    } else if (imgDataList != null && initialPage >= imgDataList.length) {
      initialPage = imgDataList.length - 1;
    }
    controller = PageController(initialPage: initialPage, viewportFraction: 1);
  }

  @override
  State<StatefulWidget> createState() {
    return _PhotoGalleryState(initialPage);
  }
}

class _PhotoGalleryState extends State<PhotoGallery> {
  int _currentIndex = 0;

  _PhotoGalleryState(this._currentIndex);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: GestureDetector(
              child: new Container(
                color: Colors.black,
                child: _pageView(),
              ),
            )),
        Positioned(
          top: MediaQuery.of(context).padding.top + 30,
          width: MediaQuery.of(context).size.width,
          child: _isShowIndicator()
              ? Center(
                  child: Text(
                      "${_currentIndex + 1}/${widget.imgDataList.length}",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                )
              : new Container(),
        ),
        Positioned(
          right: 10,
          top: MediaQuery.of(context).padding.top + 15,
          child: IconButton(
            icon: Icon(Icons.close, size: 30, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom + 60,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _isShowIndicator() ? _buildIndicators() : Container(),
            ),
          ),
        )
      ]),
    );
  }

  /// 创建轮播View
  _pageView() {
    return PageView(
      controller: widget.controller,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      children: widget.imgDataList
          .map<GestureDetector>((url) => _buildItem(url))
          .toList(),
      physics: _isCanScroll()
          ? AlwaysScrollableScrollPhysics()
          : NeverScrollableScrollPhysics(),
    );
  }

  /// 创建Item
  _buildItem(String img) {
    CachedNetworkImage image = CachedNetworkImage(
      imageUrl: img,
      fit: BoxFit.scaleDown,
    );

    return new GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap(img);
        }
      },
      onLongPress: widget.onLongPress,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          image,
        ],
      ),
    );
  }

  /// 创建指示器
  _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _buildIndicatorItem(),
    );
  }

  _buildIndicatorItem() {
    return List.generate(
      widget.imgDataList.length,
      (index) => GestureDetector(
        child: new Container(
          width: widget.indicatorWidth,
          height: widget.indicatorWidth,
          margin: EdgeInsets.only(
              left: widget.indicatorMargin, right: widget.indicatorMargin),
          decoration: ShapeDecoration(
              color: _currentIndex == index
                  ? widget.indicatorCurrentColor
                  : widget.indicatorNormalColor,
              shape: CircleBorder()),
        ),
      ),
    ).toList();
  }

  /// 是否展示指示器
  _isShowIndicator() {
    if (widget.hiddenIndicator ||
        widget.imgDataList.length == 0 ||
        widget.imgDataList.length == 1) {
      return false;
    }
    return true;
  }

  /// 是否可以滚动
  _isCanScroll() {
    if (widget.imgDataList.length == 0 || widget.imgDataList.length == 1)
      return false;
    return true;
  }
}

/// 点击事件
typedef void OnTapPageItem(String url);
