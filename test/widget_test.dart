// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_microdust/models/AirResult.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_microdust/main.dart';

void main() {
test('http 통신 테스트',() async {
 var response = await http.get('http://api.airvisual.com/v2/nearest_city?key=e556999a-9950-4709-8047-7b27a69c5846');
// 현재 json파일이 response.body에 있음
// 200은 통신코드인듯?
 expect(response.statusCode,200);
 

});
}
