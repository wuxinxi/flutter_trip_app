import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:trip/config/url.dart';
import 'package:trip/generated/json/home_model_entity_helper.dart';
import 'package:trip/io/http/dio.dart';
import 'package:trip/model/home_model_entity.dart';
import 'package:trip/widget/local.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
const APPBAR_SCROLL_OFFSET=200;
class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
   StreamController<double>_streamController ;
   //通过AutomaticKeepAliveClientMixin可保持其实例而不再每次都重构
   Future _future;

  _onScroll(offset){
    double alpha=offset/APPBAR_SCROLL_OFFSET;
    if(alpha<0){
      alpha=0;
    }else if(alpha>1){
      alpha=1;
    }
    _streamController.sink.add(alpha);
  }
@override
  void initState() {
    //这里有点坑，必须使用broadcast，否则热启动的时候回提示多次订阅
      _streamController=StreamController.broadcast();
    super.initState();
    _future= DioFactory.instance.request(homeUrl, method: "GET");
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
      body: Center(
          child: FutureBuilder(
        future:_future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasError) {
              HomeModelEntity homeModelEntity = HomeModelEntity();
              homeModelEntityFromJson(
                  homeModelEntity, json.decode(snapshot.data.toString()));
              //移除顶部padding
              return Stack(
                children: <Widget>[
                  MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: NotificationListener(
                        onNotification: (scrollNotification){
                          //当深度是0的时候才处理，也就是ListView
                          if(scrollNotification is ScrollUpdateNotification && scrollNotification.depth==0){
                            _onScroll(scrollNotification.metrics.pixels);
                          }
                          return true;
                        },
                        child: ListView(
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
                            LocalWidget(localNavList: homeModelEntity.localNavList),
                            Container(
                              height: 500.0,
                              child: Text('哈哈'),
                            )
                          ],
                        ),
                      )),
                  //实现局部刷新
                  StreamBuilder<double>(
                    stream: _streamController.stream,
                    builder: ( context,  snapshot) {
                      //透明度
                    return Opacity(
                      opacity: snapshot.data==null?0:snapshot.data,
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Text('首页',style: TextStyle(color: Colors.red,fontSize: 16.0),),
                      ),
                    );
                  },
                  )
                ],
              );
            }
            return Text('请求失败');
          }
          return CircularProgressIndicator();
        },
      )),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
