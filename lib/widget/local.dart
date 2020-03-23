import 'package:flutter/material.dart';
import 'package:trip/model/home_model_entity.dart';

import 'webview.dart';

class LocalWidget extends StatelessWidget {
  final List<HomeModelLocalNavList> localNavList;

  LocalWidget({Key key, @required this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('重构LocalWidget');
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

  Widget _item(context, HomeModelLocalNavList localNav) {
    return InkWell(
      borderRadius: BorderRadius.circular(180),
      splashColor: Colors.grey,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: localNav.url,
                      title: localNav.title,
                      hideAppBar: localNav.hideAppBar,
                      statusBarColor: localNav.statusBarColor,
                    )));
      },
      child: Column(
        children: <Widget>[
          Image.network(localNav.icon, width: 32.0, height: 32.0),
          Container(padding: EdgeInsets.only(top: 3.0)),
          Text(
            localNav.title,
            style: TextStyle(fontSize: 14.0),
          )
        ],
      ),
    );
  }

  _items(context) {
    if (localNavList == null) return null;
    List<Widget> items = [];
    localNavList.forEach((localNav) {
      items.add(_item(context, localNav));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }
}
