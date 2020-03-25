// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trip/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    Random random = Random(200);
    for (int i = 0; i < 10; i++) {
      print('${random.nextInt(300)}');
    }
  });
}
