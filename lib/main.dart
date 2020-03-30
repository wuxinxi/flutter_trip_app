import 'package:flutter/material.dart';

import 'widget/nav.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '旅行',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primarySwatch: Colors.blue, primaryColorLight: Colors.blue),
      home: Nav(),
    );
  }
}
