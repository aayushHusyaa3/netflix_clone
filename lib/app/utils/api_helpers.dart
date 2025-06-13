class ApiHelpers {
  static String baseurl = "http://192.168.1.212:8000/api";
  static String loginUrl = "http://192.168.1.212:8000/api/login";
  static String registerUrl = "http://192.168.1.212:8000/api/register";
  static String homeUrl = "/movies";
  static String profileUrl = '/profile';
  static String getFavourite = '/view-favorite';
  static String postFavourite = '/add-favorite';
  static String removeFavourite = '/remove-favorite';
  static String editProfile = '/profile-edit';
  static String searchMovies = '/search-movies';
  static String logOut = '/logout';
}

// import 'dart:io';
// import 'dart:developer';
// import "package:dio/dio.dart";
// import 'package:flutter/material.dart';
// import 'package:flutter_application_2/app/utils/apiConstants.dart';
// import 'package:flutter_application_2/app/utils/api_exceptions.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class ApiHelpers {
//   static Dio dio = Dio();
//   static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

//   static Future<String> _getAccessToken() async {
//     return await _secureStorage.read(key: "access_token") ?? "";
//   }

//   static Future<Response> get({
//     required String path,
//     required BuildContext context,
//     String? acceptHeader,
//     Map<String, dynamic> queryParms = const {},
//   }) async {
//     try {
//       final String accessToken = await _getAccessToken();
//       log("Access token from apihelpers get is $accessToken ");

//       log("Api Url get: ${ApiConstants.baseUrl + path}");
//       log("queryParms: $queryParms");

//       final Response response = await dio.get(
//         ApiConstants.baseUrl + path,
//         queryParameters: queryParms,
//         options: Options(
//           headers: {
//             HttpHeaders.authorizationHeader: "Bearer $accessToken",
//             HttpHeaders.contentTypeHeader: "application/json",
//             HttpHeaders.acceptHeader: acceptHeader ?? "application/json",
//           },
//         ),
//       );
//       log("Api response ::::::: ${response.data}");

//       if (response.data == null || response.data is String) {
//         throw ApiException.emptyResponse();
//       }
//       return response;
//     } on DioError catch (error) {
//       log("DioError: ${error.type}");
//       throw ApiException.fromDioError(error, context);
//     }
//   }

//   static Future<Response> post({
//     required String path,
//     required BuildContext context,
//     String? contentType,
//     Map<String, dynamic> queryParms = const {},
//     required dynamic body,
//   }) async {
//     try {
//       final String accessToken = await _getAccessToken();
//       log("Access token from apihelpers post is $accessToken ");

//       log("Api Url post: ${ApiConstants.baseUrl + path}");
//       log("queryParms: $queryParms");

//       final Response response = await dio.post(
//         ApiConstants.baseUrl + path,
//         queryParameters: queryParms,
//         data: body,
//         options: Options(
//           headers: {
//             HttpHeaders.authorizationHeader: "Bearer $accessToken",
//             HttpHeaders.contentTypeHeader: contentType ?? "application/json",
//             HttpHeaders.acceptHeader: "application/json",
//           },
//         ),
//       );
//       log("Api response ::::::: ${response.data}");

//       if (response.data == null) {
//         throw ApiException.emptyResponse();
//       }
//       return response;
//     } on DioError catch (error) {
//       throw ApiException.fromDioError(error, context);
//     }
//   }

//   static Future<Response> patch({
//     required String path,
//     required BuildContext context,
//     String? contentType,
//     Map<String, dynamic> queryParms = const {},
//     required dynamic body,
//   }) async {
//     try {
//       final String accessToken = await _getAccessToken();
//       log("Access token from apihelpers patch is $accessToken ");

//       log("queryParms: $queryParms");
//       log("Api Url patch: ${ApiConstants.baseUrl + path}");

//       final Response response = await dio.patch(
//         ApiConstants.baseUrl + path,
//         queryParameters: queryParms,
//         data: body,
//         options: Options(
//           headers: {
//             HttpHeaders.authorizationHeader: "Bearer $accessToken",
//             HttpHeaders.contentTypeHeader: contentType ?? "application/json",
//             HttpHeaders.acceptHeader: "application/json",
//           },
//         ),
//       );
//       log("Api response patch ::::::: ${response.data}");

//       if (response.data == null) {
//         throw ApiException.emptyResponse();
//       }
//       return response;
//     } on DioError catch (error) {
//       throw ApiException.fromDioError(error, context);
//     }
//   }

//   static Future<Response> put({
//     required String path,
//     required BuildContext context,
//     String? contentType,
//     Map<String, dynamic> queryParms = const {},
//     required dynamic body,
//   }) async {
//     try {
//       final String accessToken = await _getAccessToken();
//       log("Access token from apihelpers put is $accessToken ");

//       log("queryParms: $queryParms");
//       log("Api Url put: ${ApiConstants.baseUrl + path}");

//       final Response response = await dio.put(
//         ApiConstants.baseUrl + path,
//         queryParameters: queryParms,
//         data: body,
//         options: Options(
//           headers: {
//             HttpHeaders.authorizationHeader: "Bearer $accessToken",
//             HttpHeaders.contentTypeHeader: contentType ?? "application/json",
//             HttpHeaders.acceptHeader: "application/json",
//           },
//         ),
//       );
//       log("Api response put ::::::: ${response.data}");

//       if (response.data == null) {
//         throw ApiException.emptyResponse();
//       }
//       return response;
//     } on DioError catch (error) {
//       throw ApiException.fromDioError(error, context);
//     }
//   }

//   static Future<Response> delete({
//     required String path,
//     required BuildContext context,
//     String? contentType,
//     Map<String, dynamic> queryParms = const {},
//   }) async {
//     try {
//       final String accessToken = await _getAccessToken();
//       log("Access token from apihelpers delete is $accessToken ");

//       log("queryParms: $queryParms");
//       log("Api Url delete: ${ApiConstants.baseUrl + path}");

//       final Response response = await dio.delete(
//         ApiConstants.baseUrl + path,
//         queryParameters: queryParms,
//         options: Options(
//           headers: {
//             HttpHeaders.authorizationHeader: "Bearer $accessToken",
//             HttpHeaders.contentTypeHeader: contentType ?? "application/json",
//             HttpHeaders.acceptHeader: "application/json",
//           },
//         ),
//       );
//       log("Api response delete ::::::: ${response.data}");

//       if (response.data == null) {
//         throw ApiException.emptyResponse();
//       }
//       return response;
//     } on DioError catch (error) {
//       throw ApiException.fromDioError(error, context);
//     }
//   }
// }
