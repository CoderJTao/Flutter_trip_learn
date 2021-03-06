import 'package:flutter/material.dart';
import 'package:trip/pages/home_page.dart';
import 'package:trip/pages/my_page.dart';
import 'package:trip/pages/search_page.dart';
import 'package:trip/pages/travel_page.dart';


class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;

  int _currentIndex = 0;

  final PageController _controller = PageController(
    initialPage: 0
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(hideLeft: true),
          TravelPage(),
          MyPage(),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          _bottomNavigationBarItem(Icons.home, '首页', 0),
          _bottomNavigationBarItem(Icons.search, '搜索', 1),
          _bottomNavigationBarItem(Icons.camera_alt, '旅拍', 2),
          _bottomNavigationBarItem(Icons.account_circle, '我的', 3),
        ],
      ),
    );
  }

  _bottomNavigationBarItem(IconData icon, String text, int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ),
        title: Text(text, style: TextStyle(
            color: _currentIndex != index ? _defaultColor : _activeColor
        ),)
    );
  }
}