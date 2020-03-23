import 'package:flutter/material.dart';
import 'package:trip/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('搜索'),
        ),
        body: Column(
          children: <Widget>[
            SearchBar(),
            SearchBar(searchBarType: SearchBarType.home,defaultText: '我是测试',),
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
