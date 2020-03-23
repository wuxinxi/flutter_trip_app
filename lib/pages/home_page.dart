import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:trip/config/url.dart';
import 'package:trip/generated/json/home_model_entity_helper.dart';
import 'package:trip/io/http/dio.dart';
import 'package:trip/model/home_model_entity.dart';
import 'package:trip/widget/local.dart';
import 'package:trip/widget/scales_box_nav.dart';
import 'package:trip/widget/search_bar.dart';
import 'package:trip/widget/sub_nav.dart';

import '../widget/grid_nav.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

const APPBAR_SCROLL_OFFSET = 200;
const SEARCH_BAR_DEFAULT_TEXT = '深圳/旅游/春游/酒店';

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  StreamController<double> _streamController;

  //通过AutomaticKeepAliveClientMixin可保持其实例而不再每次都重构
  Future _future;

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    _streamController.sink.add(alpha);
  }

  @override
  void initState() {
    //这里有点坑，必须使用broadcast，否则热启动的时候回提示多次订阅
    _streamController = StreamController.broadcast();
    super.initState();
    _future = callBack();
  }

  Future<HomeModelEntity> callBack() async {
    Response res = await DioFactory.instance.request(homeUrl, method: "GET");
    HomeModelEntity homeModelEntity = HomeModelEntity();
    homeModelEntityFromJson(homeModelEntity, json.decode(res.toString()));
    print(homeModelEntity.config.searchUrl);
    return homeModelEntity;
  }

  Future refresh() async {
    setState(() {
      _future = callBack();
    });
  }

  @override
  void dispose() {
    print('dispose 关闭');
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('主页 重构build');
    return Scaffold(
        body: Stack(
      children: <Widget>[
        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: NotificationListener(
              onNotification: (scrollNotification) {
                //当深度是0的时候才处理，也就是ListView
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  _onScroll(scrollNotification.metrics.pixels);
                }
                return true;
              },
              child: FutureBuilder<HomeModelEntity>(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (!snapshot.hasError) {
                      HomeModelEntity homeModelEntity = snapshot.data;
                      return ListView(
                        children: <Widget>[
                          Container(
                            height: 200.0,
                            width: double.infinity,
                            child: Swiper(
                              itemCount: homeModelEntity.bannerList.length,
                              itemBuilder: (context, index) {
                                return Image.network(
                                    homeModelEntity.bannerList[index].icon,
                                    fit: BoxFit.fill);
                              },
                              autoplay: true,
                              pagination: SwiperPagination(),
                              onTap: (index) {},
                            ),
                          ),
                          //2
                          LocalWidget(
                              localNavList: homeModelEntity.localNavList),
                          //3
                          GirdNav(gridNav: homeModelEntity.gridNav),
                          //4
                          SubNavWidget(subNavList: homeModelEntity.subNavList),
                          //5
                          ScalesBoxNav(scalesBox: homeModelEntity.salesBox)
                        ],
                      );
                    }
                    return Container(
                        alignment: Alignment.center,
                        child: Container(
                          color: Colors.pink,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: FlatButton(
                                child: Text(
                                  '点我试试^_^',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () => refresh()),
                          ),
                        ));
                  }
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                },
                future: _future,
              ),
            )),
        _appBar(),
      ],
    ));
  }

  _appBar() {
    //实现局部刷新
    return StreamBuilder<double>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        double alpha = snapshot.data == null ? 0 : snapshot.data;
        return Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                //渐变遮罩背景
                gradient: LinearGradient(
                    colors: [Color(0x66000000), Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 20.0),
                height: 80.0,
                decoration: BoxDecoration(
                  color: Color.fromARGB((alpha * 255).toInt(), 255, 255, 255),
                ),
                child: SearchBar(
                  searchBarType: alpha > 0.2
                      ? SearchBarType.homeLight
                      : SearchBarType.home,
                  inputBoxClick: () {},
                  speakClick: () {},
                  defaultText: SEARCH_BAR_DEFAULT_TEXT,
                  leftBtnClick: () {},
                ),
              ),
            ),
            //阴影
            Container(
              height: alpha > 0.2 ? 0.5 : 0,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 0.5)
              ]),
            )
          ],
        );
      },
    );
  }

//  SearchBar(
//  searchBarType:
//  alpha > 0.2 ? SearchBarType.homeLight : SearchBarType.home,
//  inputBoxClick: () {},
//  speakClick: () {},
//  defaultText: SEARCH_BAR_DEFAULT_TEXT,
//  leftBtnClick: () {},
//  );

  @override
  bool get wantKeepAlive => true;
}
