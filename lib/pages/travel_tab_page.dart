import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:trip/io/dao/dao.dart';
import 'package:trip/model/TravelItem.dart';

class TravelTabPage extends StatefulWidget {
  @override
  TravelTabPageState createState() => TravelTabPageState();
}

class TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  Future _future;
  List<TravelItem> items;
  ScrollController _scrollController;

  @override
  void initState() {
    _future = testRequest();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      //当前区域等于最大的可滑动区域时（到底了)
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //加载更多
        loadMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future refresh() async {
    //刷新时因为数据源发生了改变因此不需要setState
    await testRequest().then((response) => items = response);
  }

  Future loadMore() async {
    //加载更多是源不变新增数据，因此需要手动刷新
    await testRequest()
        .then((response) => setState(() => items.addAll(response)));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: RefreshIndicator(
            child: FutureBuilder<List<TravelItem>>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('error');
                    }
                    if (items == null) {
                      items = snapshot.data;
                    }
                    print('items length=${items.length}');
                    return MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: StaggeredGridView.countBuilder(
                          crossAxisCount: 4,
                          itemCount: items.length,
                          controller: _scrollController,
                          itemBuilder: (BuildContext context, int index) =>
                              TravelItemWidget(
                                  item: items[index], index: index),
                          staggeredTileBuilder: (int index) =>
                              StaggeredTile.fit(2),
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                        ));
                  }
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }),
            onRefresh: refresh));
  }

  @override
  bool get wantKeepAlive => true;
}

class TravelItemWidget extends StatelessWidget {
  final TravelItem item;
  final int index;

  TravelItemWidget({Key key, this.item, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 10.0,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(3.0),
        color: Colors.white,
        child: Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    color: item.color,
                    height: item.height.toDouble(),
                  ),
                  Positioned(
                    bottom: 8.0,
                    left: 5.0,
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: ShapeDecoration(
                          color: Colors.black26,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      child: Text(
                        item.label,
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 3.0, left: 5.0, right: 5.0),
                child: Text(item.title,
                    maxLines: 3, overflow: TextOverflow.ellipsis),
              ),
              Container(
                  padding: EdgeInsets.only(
                      left: 5.0, right: 5.0, top: 5.0, bottom: 10.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      ClipOval(
                        child: Image.network(
                            'http://www.xxstudy.cn/static/images/avatar_15.png',
                            height: 24.0,
                            width: 24.0),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Text(item.name,
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.favorite_border,
                            size: 16.0,
                          ),
                          Text(' ${item.zan.toString()}')
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
