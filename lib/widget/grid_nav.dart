import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trip/model/home_model_entity.dart';

import 'webview.dart';

class GirdNav extends StatelessWidget {
  final HomeModelGridNav gridNav;

  GirdNav({Key key, @required this.gridNav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      child: PhysicalModel(
        child: Column(
          children: _gridNavItem(context),
        ),
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(7.0),
      ),
    );
  }

  _gridNavItem(context) {
    List<Widget> items = [];
    if (gridNav == null) return items;

    if (gridNav.hotel != null) {
      HomeModelGridNavHotel hotel = gridNav.hotel;
      List<String> centerTitle = [hotel.item1.title, hotel.item2.title];
      List<String> centerUrls = [hotel.item1.url, hotel.item2.url];

      List<String> rightTitles = [hotel.item3.title, hotel.item4.title];
      List<String> rightUrl = [hotel.item3.url, hotel.item4.url];
      items.add(_gradNavItem(
          context,
          hotel.mainItem.icon,
          hotel.mainItem.title,
          hotel.mainItem.url,
          hotel.startColor,
          hotel.endColor,
          centerTitle,
          centerUrls,
          rightTitles,
          rightUrl));
    }
    if (gridNav.flight != null) {
      HomeModelGridNavFlight flight = gridNav.flight;
      List<String> centerTitle = [flight.item1.title, flight.item2.title];
      List<String> centerUrls = [flight.item1.url, flight.item2.url];

      List<String> rightTitles = [flight.item3.title, flight.item4.title];
      List<String> rightUrl = [flight.item3.url, flight.item4.url];
      items.add(_gradNavItem(
          context,
          flight.mainItem.icon,
          flight.mainItem.title,
          flight.mainItem.url,
          flight.startColor,
          flight.endColor,
          centerTitle,
          centerUrls,
          rightTitles,
          rightUrl));
    }
    if (gridNav.travel != null) {
      HomeModelGridNavTravel travel = gridNav.travel;
      List<String> centerTitle = [travel.item1.title, travel.item2.title];
      List<String> centerUrls = [travel.item1.url, travel.item2.url];

      List<String> rightTitles = [travel.item3.title, travel.item4.title];
      List<String> rightUrl = [travel.item3.url, travel.item4.url];
      items.add(_gradNavItem(
          context,
          travel.mainItem.icon,
          travel.mainItem.title,
          travel.mainItem.url,
          travel.startColor,
          travel.endColor,
          centerTitle,
          centerUrls,
          rightTitles,
          rightUrl));
    }
    return items;
  }

  _gradNavItem(
      context,
      String mainIcon,
      String mainTitle,
      String mainUrl,
      String startColorStr,
      String endColorStr,
      List<String> centerTitles,
      List<String> centerUrls,
      List<String> rightTitles,
      List<String> rightUrls) {
    List<Widget> items = [];
    items.add(_mainItem(context, mainIcon, mainTitle, mainUrl));
    items.add(_rightItem(context, centerTitles, centerUrls));
    items.add(_rightItem(context, rightTitles, rightUrls));
    List<Widget> expandedItems = [];
    items.forEach((item) {
      expandedItems.add(Expanded(child: item, flex: 1));
    });
    Color startColor = Color(int.parse('0xff' + startColorStr));
    Color endColor = Color(int.parse('0xff' + endColorStr));
    return Container(
      height: 100.0,
      margin: EdgeInsets.only(top: 3.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [startColor, endColor])),
      child: Row(children: expandedItems),
    );
  }

  _mainItem(context, String icon, String title, String url) {
    return _onClick(
        context,
        Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            CachedNetworkImage(
                height: 88,
                width: 121,
                alignment: AlignmentDirectional.bottomEnd,
                imageUrl: icon),
            Container(
              margin: EdgeInsets.only(top: 15.0),
              child: Text(title,
                  style: TextStyle(fontSize: 16.0, color: Colors.white)),
            )
          ],
        ),
        url,
        title);
  }

  _rightItem(BuildContext context, List<String> titles, List<String> urls) {
    return Column(
      children: <Widget>[
        //垂直全充满
        Expanded(child: _item(context, titles[0], urls[0], true)),
        Expanded(child: _item(context, titles[1], urls[1], false)),
      ],
    );
  }

  _item(BuildContext context, String title, String url, bool isFirst) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      //撑满父布局
      widthFactor: 1.0,
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                  left: borderSide,
                  bottom: isFirst ? borderSide : BorderSide.none)),
          child: _onClick(
              context,
              Center(
                  child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              )),
              url,
              title)),
    );
  }

  _onClick(context, widget, url, title) {
    return InkWell(
      child: widget,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: url,
                      title: title,
                    )));
      },
    );
  }
}
