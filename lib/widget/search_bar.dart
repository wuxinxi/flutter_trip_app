import 'package:flutter/material.dart';

enum SearchBarType { home, normal, homeLight }

class SearchBar extends StatefulWidget {
  //是否可用
  final bool enabled;

  //是否隐藏左边返回按钮
  final bool hideLeft;
  final SearchBarType searchBarType;
  final String hint;
  final String defaultText;
  final void Function() leftBtnClick;
  final void Function() rightBtnClick;
  final void Function() speakClick;
  final void Function() inputBoxClick;
  final ValueChanged<String> onChanged;

  SearchBar(
      {Key key,
      this.enabled = true,
      this.hideLeft,
      this.searchBarType = SearchBarType.normal,
      this.hint,
      this.defaultText,
      this.leftBtnClick,
      this.rightBtnClick,
      this.speakClick,
      this.inputBoxClick,
      this.onChanged})
      : super(key: key);

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    //检查是否有默认值
    if (widget.defaultText != null) {
      setState(() => _controller.text = widget.defaultText);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal
        ? _getNormalSearch()
        : _getHomeSearch();
  }

  _getNormalSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _click(
              Container(
                padding: EdgeInsets.fromLTRB(6.0, 5.0, 5.0, 5.0),
                child: widget?.hideLeft ?? false
                    ? null
                    : Icon(Icons.arrow_back_ios,
                        color: Colors.grey, size: 26.0),
              ),
              widget.leftBtnClick),
          Expanded(flex: 1, child: _inputBox()),
          _click(
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text('搜索',
                    style: TextStyle(fontSize: 18.0, color: Colors.blue)),
              ),
              widget.rightBtnClick)
        ],
      ),
    );
  }

  _getHomeSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _click(
              Container(
                padding: EdgeInsets.fromLTRB(6.0, 5.0, 5.0, 5.0),
                child: Row(
                  children: <Widget>[
                    Text('深圳',
                        style:
                            TextStyle(fontSize: 15.0, color: _homeFontColor())),
                    Icon(Icons.expand_more, color: _homeFontColor(), size: 23.0)
                  ],
                ),
              ),
              widget.leftBtnClick),
          Expanded(flex: 1, child: _inputBox()),
          _click(
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Icon(Icons.message,color: Colors.grey,size: 23.0),
              ),
              widget.rightBtnClick)
        ],
      ),
    );
  }

  _homeFontColor() {
    return widget.searchBarType == SearchBarType.homeLight
        ? Colors.black54
        : Colors.white;
  }

  _inputBox() {
    Color inputBoxColor = widget.searchBarType == SearchBarType.home
        ? Colors.white
        : Color(int.parse('0xffEDEDED'));
    return Container(
      height: 40.0,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
          color: inputBoxColor,
          borderRadius: BorderRadius.circular(
              widget.searchBarType == SearchBarType.normal ? 5.0 : 20.0)),
      child: Row(
        children: <Widget>[
          Icon(Icons.search,
              size: 23.0,
              color: widget.searchBarType == SearchBarType.normal
                  ? Color(0xffA9A9A9)
                  : Colors.blue),
          Expanded(
            flex: 1,
            child: widget.searchBarType == SearchBarType.normal
                ? TextField(
                    controller: _controller,
                    onChanged: _onChanged,
                    autofocus: true,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        border: InputBorder.none,
                        hintText: widget.hint ?? '',
                        hintStyle: TextStyle(fontSize: 15.0)),
                    style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w300))
                : _click(
                    Container(
                      child: Text(widget.defaultText,
                          style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                    ),
                    widget.inputBoxClick),
          ),
          !showClear
              ? _click(
                  Icon(Icons.mic,
                      size: 23.0,
                      color: widget.searchBarType == SearchBarType.normal
                          ? Colors.blue
                          : Colors.grey),
                  widget.speakClick)
              : _click(Icon(Icons.clear, size: 23.0, color: Colors.grey), () {
                  setState(() => _controller.clear());
                  _onChanged('');
                }),
        ],
      ),
    );
  }

  _click(Widget child, void Function() callBack) {
    return InkWell(
      onTap: () {
        if (callBack != null) {
          callBack();
        }
      },
      child: child,
    );
  }

  _onChanged(String text) {
    setState(() => showClear = text.length > 0);
    if (widget.onChanged != null) {
      widget.onChanged(text);
    }
  }
}
