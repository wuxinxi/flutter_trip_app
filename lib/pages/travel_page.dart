import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trip/config/url.dart';
import 'package:trip/io/dao/dao.dart';
import 'package:trip/model/travel_tab_model.dart';
import 'package:trip/pages/travel_tab_page.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  Future _future;

  ScrollPhysics _physics;

  @override
  void initState() {
    _future = travelTab(travelTabUrl);
    _physics = ClampingScrollPhysics();
    super.initState();
  }

  @override
  void dispose() {
    if (_tabController != null) {
      _tabController.dispose();
    }
    super.dispose();
  }

  Future refresh() async {
    setState(() {
      _future = travelTab(travelTabUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      alignment: Alignment.topCenter,
      child: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasError) {
                TravelTabModel model = snapshot.data;
                if (model != null &&
                    model.tabs != null &&
                    model.tabs.length > 0) {
                  if (_tabController == null) {
                    _tabController =
                        TabController(length: model.tabs.length, vsync: this);
                  }
                  return Column(
                    children: <Widget>[
                      _tabBar(model.tabs),
                      //这里必须要给一个尺寸包括
                      Expanded(
                        flex: 1,
                        child: TabBarView(
                            physics: _physics,
                            controller: _tabController,
                            children: _tabBarView()),
                      )
                    ],
                  );
                }
              }
              return Container(
                  alignment: Alignment.center,
                  child: Container(
                    color: Colors.pink,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: FlatButton(
                          child: Text('点我试试^_^',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                              textAlign: TextAlign.center),
                          onPressed: () => refresh()),
                    ),
                  ));
            }
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _tabBar(List<Tabs> tabs) {
    return TabBar(
      tabs: _items(tabs),
      controller: _tabController,
      isScrollable: true,
      unselectedLabelStyle: TextStyle(color: Colors.grey),
      //很奇怪在labelStyle设置color竟然无效
      labelColor: Colors.black,
      labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  _items(List<Tabs> tabs) {
    List<Widget> items = [];
    tabs.forEach((item) {
      items.add(Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Text('${item.labelName}')));
    });
    return items;
  }

  _tabBarView() {
    List<Widget> items = [];
    for (int i = 0; i < 6; i++) {
      items.add(TravelTabPage());
    }
    return items;
  }
}
