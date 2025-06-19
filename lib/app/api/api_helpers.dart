import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_application_2/app/api/api_exceptions.dart';
import 'package:flutter_application_2/app/api/api_path.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ApiHelpers {
  static Dio dio = Dio();
  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();

  static Future<String> _getAccessToken() async {
    return await secureStorage.read(key: "token") ?? "";
  }

  static Future<Response> post({
    required String path,
    required BuildContext context,
    String? contentType,
    Map<String, dynamic> queryParms = const {},
    required dynamic body,
  }) async {
    try {
      final String accessToken = await _getAccessToken();
      log("Access token from apihelpers post is $accessToken ");

      log("Api Url post: ${ApiPath.baseUrl + path}");
      log("queryParms: $queryParms");

      final Response response = await dio.post(
        ApiPath.baseUrl + path,
        queryParameters: queryParms,
        data: body,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
          HttpHeaders.contentTypeHeader: contentType ?? "application/json",
          HttpHeaders.acceptHeader: "application/json",
        }),
      );
      log("Api response ::::::: ${response.data}");

      if (response.data == null) {
        throw ApiException.emptyResponse();
      }
      return response;
    } on DioError catch (error) {
      log("Error type iss: ${error.type}");

      throw ApiException.fromDioException(error, context);
    }
  }
}
