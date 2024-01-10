import 'package:dio/dio.dart';

class ApiService {
  static Future<Response?> getApi(
      {required Dio dio,
      required String url,
      required Map<String, dynamic>? data}) async {
    try {
      final Response response = await dio.get(url, queryParameters: data);
      return response;
    } on DioError catch (e) {
      return null;
    }
  }
}
