import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:trip/dao/home_dao.dart';
import 'package:trip/model/common_model.dart';
import 'package:trip/model/grid_nav_model.dart';
import 'package:trip/model/home_model.dart';
import 'package:trip/model/sale_box_model.dart';
import 'package:trip/pages/search_page.dart';
import 'package:trip/widget/grid_nav.dart';
import 'package:trip/widget/loading_container.dart';
import 'package:trip/widget/local_nav.dart';
import 'package:trip/widget/sales_box.dart';
import 'package:trip/widget/search_bar.dart';
import 'package:trip/widget/sub_nav.dart';
import 'package:trip/widget/webview.dart';

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = "网红打卡地 景点 酒店 美食";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
    'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg'
  ];

  double appBarAlpha = 0;

  List<CommonModel> bannerList;
  List<CommonModel> localNavList;
  GridNavModel gridNavModel;
  List<CommonModel> subNavList;
  SaleBoxModel salesBoxModel;

  bool _loading = true;

  @override
  void initState() {
    super.initState();

    _handleRefresh();
  }

  /// 监听列表滑动，控制导航栏透明度
  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  /// 加载首页数据
  Future<Null> _handleRefresh() async {
    // 方法1
//    HomeDao.fetch().then((result) {
//      setState(() {
//        resultString = json.encode(result);
//      });
//    }).catchError((error) {
//      setState(() {
//        resultString = error.toString();
//      });
//    });

    // 方法2
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        bannerList = model.bannerList;
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        subNavList = model.subNavList;
        salesBoxModel = model.salesBox;

        _loading = false;
      });
    } catch (error) {
      setState(() {
        print(error);
        _loading = false;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child:  NotificationListener(
                  // ignore: missing_return
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                  },
                  child: _listView,
                ),
              )
            ),
            _appbar,
          ],
        ),
      )
    );
  }

  Widget get _appbar {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)
            ),
            child: SearchBar(
              searchBarType: appBarAlpha > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakButtonClick: _jumpToSpeak,
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () {},
            ),
          ),
        ),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]
          ),
        )
      ],
    );
  }

  Widget get _listView {
    return ListView(
      children: <Widget>[
        _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: GridNav(gridNavModel: gridNavModel),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(subNavList: subNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SalesBox(salesBox: salesBoxModel),
        ),
      ],
    );
  }

  Widget get _banner {
    return Container(
      height: 160,
      child: Swiper(
        itemCount: bannerList?.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              CommonModel model = bannerList[index];
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      WebView(
                        url: model.url,
                      )
                  )
              );
            },
            child: Image.network(
              bannerList[index].icon,
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: SwiperPagination(),
      ),
    );
  }

  _jumpToSearch() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchPage(hint: SEARCH_BAR_DEFAULT_TEXT,)
        ));
  }

  _jumpToSpeak() {

  }

  _leftButtonClick() {

  }
}