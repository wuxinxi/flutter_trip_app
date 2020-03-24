import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:trip/generated/json/home_model_entity_helper.dart';
import 'package:trip/io/http/dio.dart';
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
  TravelTabModel tabModel = TravelTabModel.fromJson(json.decode(res.toString()));
  print(tabModel.url);
  return tabModel;
}
