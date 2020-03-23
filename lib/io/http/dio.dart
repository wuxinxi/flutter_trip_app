import 'package:dio/dio.dart';

class DioFactory {
  factory DioFactory() => _getInstance();

  static DioFactory get instance => _getInstance();
  static DioFactory _instance;

  Dio dio;

  DioFactory._internal() {
    dio = Dio();
  }

  static DioFactory _getInstance() {
    if (_instance == null) {
      _instance = DioFactory._internal();
    }
    return _instance;
  }

  Future request(url, {method = 'POST', formData}) async {
    Dio dio = DioFactory.instance.dio;
    Response response;
    try {
      if (method == 'POST') {
        response = await dio.post(url, data: formData);
      } else {
        response = await dio.get(url);
      }
      if (response.statusCode == 200) {
        return response;
      }
      throw Exception('请求错误[${response.statusCode}]');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
