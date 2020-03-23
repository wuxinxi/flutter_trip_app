import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trip/config/url.dart';
import 'package:trip/io/http/dio.dart';
import 'package:trip/model/search_model_entity.dart';
import 'package:trip/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String defaultText;
  final String hint;
  final searchUrl;

  SearchPage(
      {Key key,
      this.hideLeft = true,
      this.defaultText,
      this.hint,
      this.searchUrl =
          'https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword='})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  String keyWord;
  SearchModelEntity searchModel;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Column(
          children: <Widget>[
            _appBar(),
            ListView.builder(
                itemCount: searchModel?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  if (searchModel != null && searchModel.data.length > 0) {
                    return Text(searchModel.data[index].word);
                  }
                  return Text('失敗');
                })
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;

  _appBar() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Container(
            padding: EdgeInsets.only(top: 20.0),
            height: 80.0,
            decoration: BoxDecoration(color: Colors.white),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              defaultText: widget.defaultText ?? '',
              hint: widget.hint ?? '',
              leftBtnClick: () => Navigator.pop(context),
              onChanged: _onTextChange,
            ),
          ),
        )
      ],
    );
  }

  _onTextChange(String text) {
    keyWord = text;
    if (text.length == 0) {
      setState(() => searchModel = null);
      return;
    }
    String url = widget.searchUrl + text;
    search(url);
  }

  Future<SearchModelEntity> search(String url) async {
    Response response = await DioFactory.instance.request(url, method: "GET");
    SearchModelEntity searchModelEntity = SearchModelEntity();
    searchModelEntity.fromJson(json.decode(response.data.toString()));
    setState(() => searchModel = searchModelEntity);
  }
}
