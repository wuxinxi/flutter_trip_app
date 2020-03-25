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
      body: WebView(
        url: meUrl,
        hideAppBar: true,
        backForbid: true,
        statusBarColor: '4c5bca',
      ),
    );
  }
}
