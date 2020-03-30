import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trip/io/dao/dao.dart';
import 'package:trip/model/search_model_entity.dart';
import 'package:trip/widget/search_bar.dart';
import 'package:trip/widget/webview.dart';

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

const List<IconData> icons = [
  Icons.add_location,
  Icons.home,
  Icons.image,
  Icons.flight,
  Icons.face
];

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  String keyWord;
  SearchModelEntity searchModel;

  @override
  void dispose() {
    FocusScope.of(context).requestFocus(FocusNode());
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget divider = Divider(color: Colors.grey);
    return Scaffold(
        body: Column(
      children: <Widget>[
        _appBar(),
        MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Expanded(
                flex: 1,
                child: ListView.separated(
                    itemCount: searchModel?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return _item(index);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return divider;
                    })))
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
    search(url, text).then((searchModelEntity) {
      if (searchModelEntity.keyWord == keyWord) {
        setState(() => searchModel = searchModelEntity);
      }
    });
  }

  final Random random = Random();

  _item(int position) {
    if (searchModel != null && searchModel.data != null) {
      SearchModelData modelData = searchModel.data[position];
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      WebView(url: modelData.url, title: '详情页')));
        },
        child: Container(
            alignment: Alignment.centerLeft,
            padding:
                EdgeInsets.only(left: 5.0, right: 3.0, top: 3.0, bottom: 3.0),
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(1.0),
                  child: Icon(icons[random.nextInt(icons.length - 1)],
                      size: 26.0, color: Colors.blue),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 50,
                      child: _title(modelData),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 50,
                      child: _subTitle(modelData),
                    ),
                  ],
                )
              ],
            )),
      );
    }
    return Text('请求失败');
  }

  _title(SearchModelData modelData) {
    if (modelData == null) return null;
    List<TextSpan> spans = [];
    //left
    spans.addAll(_keywordTextSpans(modelData.word, searchModel.keyWord));
    //right
    spans.add(TextSpan(
        text: '   ' + (modelData.districtname ?? ''),
        style: TextStyle(fontSize: 15.0, color: Colors.grey)));
    return RichText(text: TextSpan(children: spans));
  }

  _subTitle(SearchModelData modelData) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: modelData.price ?? '',
            style: TextStyle(fontSize: 16.0, color: Colors.orange)),
        TextSpan(
            text: modelData.startScore == null
                ? ''
                : modelData.startScore.toString(),
            style: TextStyle(fontSize: 12.0, color: Colors.grey))
      ]),
    );
  }

  _keywordTextSpans(String word, String keyword) {
    List<TextSpan> spans = [];
    List<String> arr = word.split(keyword);
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16, color: Colors.orange);
    //print('android compiled'.split('d'));  [an, roi,  compile, ]
    //根据上述得知，需要在(i + 1) % 2 == 0的位置上增加关键词
    for (int i = 0; i < arr.length; i++) {
      if ((i + 1) % 2 == 0) {
        spans.add(TextSpan(text: keyword, style: keywordStyle));
      }
      String val = arr[i];
      if (val != null && val.length > 0) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}
