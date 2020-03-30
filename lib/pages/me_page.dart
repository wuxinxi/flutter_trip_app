import 'package:flutter/material.dart';
import 'package:trip/config/url.dart';
import 'package:trip/widget/webview.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _header(),
          _center(),
          _base(),
          _baseEnd(),
        ],
      ),
    ));
  }

  _header() {
    return Container(
        height: 180.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.lightBlueAccent,
          Colors.blueAccent,
          Colors.blue
        ])),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(top: 40.0, right: 10.0),
              child: InkWell(
                child: Icon(Icons.message, size: 23.0, color: Colors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                '登录我,咱们说走就走',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Text('登录/注册',
                      style: TextStyle(fontSize: 14.0, color: Colors.white)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                WebView(url: meUrl,title: '登录')));
                  },
                ),
                Container(
                  margin: EdgeInsets.only(right: 10.0, left: 10.0),
                ),
                FlatButton(
                  color: Color(0x000000ff),
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: Colors.white),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Text('手机号查单',
                      style: TextStyle(fontSize: 14.0, color: Colors.white)),
                  onPressed: () {},
                )
              ],
            )
          ],
        ));
  }

  _center() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10.0, left: 10.0),
                child:
                    Icon(Icons.monetization_on, size: 26.0, color: Colors.grey),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: '钱包\n',
                      style: TextStyle(fontSize: 16.0, color: Colors.black87)),
                  TextSpan(
                      text: '礼品卡  |  现金  |  返现',
                      style: TextStyle(fontSize: 14.0, color: Colors.grey))
                ]),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 15.0),
            height: 1.0,
            color: Color(0xffdadbdb),
          ),
          Container(
            height: 80.0,
            child: Row(
              children: <Widget>[
                _expandedTitle(Icons.pages, '优惠券', '领券', isFirst: true),
                _expandedTitle(Icons.card_giftcard, '积分', '兑好礼'),
                _expandedTitle(Icons.credit_card, '拿去花', '分期付款'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _expandedTitle(icon, title, subTitle, {bool isFirst = false}) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Color(0xffdadbdb));
    return Expanded(
        child: Container(
      decoration:
          isFirst ? null : BoxDecoration(border: Border(left: borderSide)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 26.0, color: Colors.grey),
              Text(title,
                  style: TextStyle(fontSize: 16.0, color: Colors.black87))
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 3.0),
            child: Text(subTitle,
                style: TextStyle(fontSize: 14.0, color: Colors.grey)),
          )
        ],
      ),
    ));
  }

  _base() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _baseItem('常用信息', '旅客/地址/发票抬头'),
          _baseItem('我的收藏', '降价产品有提醒'),
          _baseItem('浏览历史', '近15天浏览记录'),
          _baseItem('我要合作', '供应商/代理合作', isEnd: true),
        ],
      ),
    );
  }

  _baseEnd() {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _baseItem('出行工具', '航空动态/翻译助手等', isEnd: true),
        ],
      ),
    );
  }
}

_baseItem(title, subTitle, {bool isEnd = false}) {
  return Material(
    child: Ink(
        color: Colors.white,
        child: InkResponse(
          splashColor: Colors.grey,
          highlightShape: BoxShape.rectangle,
          containedInkWell: true,
          onTap: () {},
          child: Container(
              height: 50.0,
              alignment: Alignment.bottomLeft,
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(title, style: TextStyle(fontSize: 16.0)),
                          Row(
                            children: <Widget>[
                              Text(subTitle,
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey)),
                              Icon(Icons.keyboard_arrow_right,
                                  size: 23.0, color: Colors.grey)
                            ],
                          )
                        ]),
                  )),
                  Expanded(
                    flex: 0,
                    child: Container(
                      margin: EdgeInsets.only(left: 10.0),
                      color: Color(0xffdadbdb),
                      height: isEnd ? 0.0 : 1.0,
                    ),
                  )
                ],
              )),
        )),
  );
}
