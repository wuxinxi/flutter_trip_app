import 'package:flutter/material.dart';
import 'package:trip/model/home_model_entity.dart';

import 'webview.dart';

class ScalesBoxNav extends StatelessWidget {
  final HomeModelSalesBox scalesBox;

  ScalesBoxNav({Key key, @required this.scalesBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _actionWidget(context, scalesBox.icon, scalesBox.moreUrl),
        _bigCard(
            context,
            [scalesBox.bigCard1.icon, scalesBox.bigCard2.icon],
            [scalesBox.bigCard1.title, scalesBox.bigCard2.title],
            [scalesBox.bigCard1.url, scalesBox.bigCard2.url]),
        _smallCard(
            context,
            [scalesBox.smallCard1.icon, scalesBox.smallCard2.icon],
            [scalesBox.smallCard1.title, scalesBox.smallCard2.title],
            [scalesBox.smallCard1.url, scalesBox.smallCard2.url]),
        _smallCard(
            context,
            [scalesBox.smallCard3.icon, scalesBox.smallCard4.icon],
            [scalesBox.smallCard3.title, scalesBox.smallCard4.title],
            [scalesBox.smallCard3.url, scalesBox.smallCard4.url]),
      ],
    );
  }

  _actionWidget(context, icon, moreUrl) {
    return Container(
      height: 50.0,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _onClick(context, Image.network(icon, height: 18.0), moreUrl),
          Container(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 3.0, bottom: 3.0),
            child: Text('获取更多福利>>', style: TextStyle(color: Colors.white)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                gradient:
                    LinearGradient(colors: [Colors.pinkAccent, Colors.pink])),
          )
        ],
      ),
    );
  }

  _bigCard(context, icons, titles, urls) {
    return Container(
        height: 140.0,
        child: Flex(direction: Axis.horizontal, children: <Widget>[
          Expanded(
              flex: 1,
              child: _onClick(
                  context, Image.network(icons[0], fit: BoxFit.fill), urls[0])),
          Expanded(
              flex: 1,
              child: _onClick(
                  context, Image.network(icons[1], fit: BoxFit.fill), urls[1]))
        ]));
  }

  _smallCard(context, icons, titles, urls) {
    return Container(
      height: 80.0,
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: _onClick(
                  context, Image.network(icons[0], fit: BoxFit.fill), urls[0],
                  title: titles[0])),
          Expanded(
              flex: 1,
              child: _onClick(
                  context, Image.network(icons[1], fit: BoxFit.fill), urls[1],
                  title: titles[1]))
        ],
      ),
    );
  }

  _onClick(context, widget, url, {title}) {
    return InkWell(
      child: widget,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: url,
                      title: title ?? '',
                    )));
      },
    );
  }
}
