import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trip/generated/json/home_model_entity_helper.dart';
import 'package:trip/io/http/dio.dart';
import 'package:trip/model/TravelItem.dart';
import 'package:trip/model/home_model_entity.dart';
import 'package:trip/model/search_model_entity.dart';
import 'package:trip/model/travel_tab_model.dart';

//搜索dao
Future<SearchModelEntity> search(String url, String keyWord) async {
  Response response = await DioFactory.instance.request(url, method: "GET");
  SearchModelEntity searchModelEntity = SearchModelEntity();
  searchModelEntity.fromJson(json.decode(response.toString()));
  searchModelEntity.keyWord = keyWord;
  return searchModelEntity;
}

//主页刷新dao
Future<HomeModelEntity> homeRefresh(String homeUrl) async {
  Response res = await DioFactory.instance.request(homeUrl, method: "GET");
  HomeModelEntity homeModelEntity = HomeModelEntity();
  homeModelEntityFromJson(homeModelEntity, json.decode(res.toString()));
  print(homeModelEntity.config.searchUrl);
  return homeModelEntity;
}

//旅拍类别dao
Future<TravelTabModel> travelTab(String url) async {
  Response res = await DioFactory.instance.request(url, method: "GET");
  TravelTabModel tabModel =
      TravelTabModel.fromJson(json.decode(res.toString()));
  return tabModel;
}

Future<List<TravelItem>> testRequest() async {
  List<TravelItem> list = [];
  Random random = Random();
  await Future.delayed(Duration(milliseconds: 500)).then((v) {
    for (int i = 0; i < 15; i++) {
      TravelItem item = TravelItem(
          color: Color.fromARGB(255, random.nextInt(255), random.nextInt(255),
              random.nextInt(255)),
          title: '青元河畔风景宜人沁人心脾，砍柴喂马好不自在，$i 在这里那你呢？',
          name: '诸葛老$i',
          height: random.nextInt(300) + 100,
          zan: random.nextInt(1000),
          label: '看看大千世界');
      list.add(item);
    }
  });
  return list;
}
