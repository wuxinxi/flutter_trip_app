import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CATCH_URLS = [
  'm.ctrip.com/',
  'm.ctrip.com/html5/',
  'm.ctrip.com/webapp/you/',
  'm.ctrip.com/webapp/activity/wifi/'
];

class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView({this.url,
    this.statusBarColor,
    this.title,
    this.hideAppBar,
    this.backForbid = false});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final FlutterWebviewPlugin webviewPlugin = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChange;
  StreamSubscription<WebViewHttpError> _onHttpError;
  bool existing = false;

  @override
  void initState() {
    super.initState();
    webviewPlugin.close();
    _onUrlChanged = webviewPlugin.onUrlChanged.listen((url) {});

    _onStateChange = webviewPlugin.onStateChanged.listen((state) {
      print('当前状态：${state.toString()}');
      switch (state.type) {
        case WebViewState.shouldStart:
          break;
        case WebViewState.startLoad:
          print('url:${state.url}');
          if (isToMain(state.url) && !existing) {
            if (widget.backForbid) {
              webviewPlugin.launch(widget.url);
            } else {
              Navigator.pop(context);
              existing = true;
            }
          }
          break;
        case WebViewState.finishLoad:
          break;
        case WebViewState.abortLoad:
          break;
      }
    });

    _onHttpError = webviewPlugin.onHttpError.listen((error) {
      print('错误码：${error.code},url=${error.url}');
    });
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    _onStateChange.cancel();
    _onHttpError.cancel();
    webviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color btnColor =
    statusBarColorStr == 'ffffff' ? Colors.black : Colors.white;
    Color bgColor = Color(int.parse('0xff' + statusBarColorStr));
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(bgColor, btnColor),
          Expanded(
            child: WebviewScaffold(
                url: widget.url,
                withZoom: true,
                hidden: true,
                appCacheEnabled: true,
                ignoreSSLErrors: true,
                initialChild: Center(
                  child: CircularProgressIndicator(),
                )),
          )
        ],
      ),
    );
  }

  _appBar(bgColor, btnColor) {
    if (widget.hideAppBar ?? false) {
      //隐藏appBar时
      return Container(color: bgColor, height: 30.0);
    }
    return Container(
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: FractionallySizedBox(
        //宽度充满
        widthFactor: 1.0,
        child: Stack(
          children: <Widget>[
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Icon(Icons.close, color: btnColor, size: 26.0),
              ),
            ),
            //标题
            Positioned(
              child: Center(
                child: Text(widget.title,
                    style: TextStyle(color: bgColor, fontSize: 18.0)),
              ),
              left: 0,
              right: 0,
            )
          ],
        ),
      ),
    );
  }

  isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) {
        contain = true;
      }
    }
    return contain;
  }
}
