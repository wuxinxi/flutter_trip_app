import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trip/model/home_model_entity.dart';

import 'webview.dart';

class SubNavWidget extends StatelessWidget {
  final List<HomeModelSubNavList> subNavList;

  SubNavWidget({Key key, @required this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('重构SubNavWidget');
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
          padding:
              EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0, right: 5.0),
          width: double.infinity,
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              color: Colors.white,
              shadows: [
                BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0)
              ]),
          child: _items(context)),
    );
  }

  Widget _item(context, HomeModelSubNavList subNav) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebView(
                        url: subNav.url,
                        title: subNav.title,
                        hideAppBar: subNav.hideAppBar,
                      )));
        },
        child: Column(
          children: <Widget>[
            CachedNetworkImage(imageUrl: subNav.icon, width: 16.0, height: 16.0),
            Container(padding: EdgeInsets.only(top: 3.0)),
            Text(
              subNav.title,
              style: TextStyle(fontSize: 14.0),
            )
          ],
        ),
      ),
    );
  }

  _items(context) {
    if (subNavList == null) return null;
    List<Widget> items = [];
    subNavList.forEach((localNav) {
      items.add(_item(context, localNav));
    });
    //总共两行，计算每一行icon个数
    int lineItemCount = (subNavList.length / 2 + 0.5).toInt();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, lineItemCount),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(lineItemCount, subNavList.length),
          ),
        )
      ],
    );
  }
}
