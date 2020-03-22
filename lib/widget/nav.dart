import 'package:flutter/material.dart';
import 'package:trip/pages/home_page.dart';
import 'package:trip/pages/me_page.dart';
import 'package:trip/pages/search_page.dart';
import 'package:trip/pages/travel_page.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  final PageController _controller = PageController();
  var currentIndex = 0;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[HomePage(), SearchPage(), TravelPage(), MePage()],
        controller: _controller,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() => currentIndex = index);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('搜索')),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt), title: Text('旅拍')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('个人中心')),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
