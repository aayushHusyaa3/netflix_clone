import 'package:dio/dio.dart';
import 'package:flutter_application_2/app/api/api_exceptions.dart';
import 'package:flutter_application_2/app/api/api_path.dart';

class ApiHelper {
  static final Dio dio = Dio();
  static Future<Response> post({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    try {
      final Response response = await dio.post(
        ApiPath.baseUrl + path,
        data: data,
      );
      return response;
    } on DioException catch (exe) {
      throw ApiException.fromDioError(exe);
    }
  }
}
