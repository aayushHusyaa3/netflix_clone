// // import 'dart:developer';
// // import 'package:dio/.dart';
// // import 'package:examsnepal/app/utils/routers_logic/app_routes.dart';
// // import 'package:flutter/widgets.dart';

// // // class ApiException implements Exception {
// // //   String message = "";
// // //   int? statusCode; // Add statusCode

// // //   ApiException(this.message, {this.statusCode});
// // //   ApiException.emptyResponse() {
// // //     message = "Something went wrong. Please try again later !";
// // //   }

// // //   ApiException.fromDioError(DioError error, BuildContext context) {
// // //     statusCode = error.response?.statusCode; // Store status code
// // //     switch (error.type) {
// // //       case DioErrorType.other:
// // //         message = "Unable to connect to server!";
// // //         break;
// // //       case DioErrorType.cancel:
// // //         message = "Request to server was cancelled";
// // //         break;
// // //       case DioErrorType.connectTimeout:
// // //         message = "Timed out while trying to connect!";
// // //         break;
// // //       case DioErrorType.receiveTimeout:
// // //         message = "Timed out while waiting for data!";
// // //         break;
// // //       case DioErrorType.response:
// // //         message = _handleResponseError(error: error, context: context);
// // //         break;
// // //       case DioErrorType.sendTimeout:
// // //         message = "Timed out while trying to send data!";
// // //         break;
// // //       default:
// // //         message = "Something went wrong. Please try again later";
// // //         break;
// // //     }
// // //   }

// // //   String _handleResponseError(
// // //       {required DioError error, required BuildContext context}) {
// // //     switch (error.response!.statusCode!) {
// // //       // question pool case
// // //       case 400:
// // //         return _getErrorMessage(
// // //             error: error, defaultMessage: "Only three pool per day is allowed");
// // //       case 406:
// // //         return _getErrorMessage(
// // //             error: error,
// // //             defaultMessage: "Something went wrong. Please try again later.");
// // //       case 401:
// // //         Navigator.of(context)
// // //             .pushReplacementNamed(AppRoutes.login); // was login
// // //         // context.read<UserLoginCubit>().logout(context: context);
// // //         return _getErrorMessage(
// // //             error: error,
// // //             defaultMessage: "The request requires user authentication.");
// // //       case 403:
// // //         return _getErrorMessage(
// // //             error: error, defaultMessage: "Your subscription is inactive");

// // //       case 402:
// // //         return _getErrorMessage(
// // //             error: error, defaultMessage: "Previous password does not match");
// // //       case 429:
// // //         return _getErrorMessage(
// // //             error: error,
// // //             defaultMessage: "Too many attempts. Please try again later.");
// // //       case 404:
// // //         return _getErrorMessage(
// // //             error: error, defaultMessage: "No Results Found...");
// // //       case 412:
// // //         return _getErrorMessage(
// // //             error: error,
// // //             defaultMessage: "This question doubt has already been added.");

// // //       case 500:
// // //         return _getErrorMessage(
// // //             error: error,
// // //             defaultMessage:
// // //                 "An internal server error occurred while processing the request. Please try again later.");
// // //       case 502:
// // //         return _getErrorMessage(
// // //             error: error,
// // //             defaultMessage:
// // //                 "An internal server error occurred while processing the request. Please try again later.");
// // //       case 503:
// // //         return _getErrorMessage(
// // //             error: error,
// // //             defaultMessage:
// // //                 "Server is under maintenance. Please try again later.");
// // //       default:
// // //         return _getErrorMessage(
// // //             error: error,
// // //             defaultMessage: "Something went wrong. Please try again later.");
// // //     }
// // //   }

// // //   String _getErrorMessage(
// // //       {required DioError error, required String defaultMessage}) {
// // //     log(error.message.toString());
// // //     log(error.response.toString());

// // //     if (error.response == null || error.response!.data == null) {
// // //       return defaultMessage;
// // //     }

// // //     final data = error.response!.data;

// // //     if (data is Map<String, dynamic>) {
// // //       // Case 1: Direct "error" field
// // //       if (data.containsKey("error")) {
// // //         if (data["error"] is String) {
// // //           return data["error"];
// // //         } else if (data["error"] is List && data["error"].isNotEmpty) {
// // //           return data["error"][0].toString();
// // //         }
// // //       }

// // //       // Case 2: Nested "errors" field
// // //       if (data.containsKey("errors") &&
// // //           data["errors"] is Map<String, dynamic>) {
// // //         final errorsMap = data["errors"] as Map<String, dynamic>;
// // //         if (errorsMap.isNotEmpty) {
// // //           final firstKey = errorsMap.keys.first;
// // //           final firstError = errorsMap[firstKey];

// // //           if (firstError is List && firstError.isNotEmpty) {
// // //             return firstError[0].toString();
// // //           } else if (firstError is String) {
// // //             return firstError;
// // //           }
// // //         }
// // //       }
// // //     }

// // //     return defaultMessage;
// // //   }
// // // }

// // /// ApiException class to handle API errors for RESPONSE MESSAGE NOT CUSTOM MESSAGE
// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_2/app/utils/routes/app_routes.dart';

// class ApiException implements Exception {
//   String message = "";
//   int? statusCode;
//   dynamic data; // Add this line

//   ApiException(this.message,
//       {this.statusCode, this.data}); // Add data parameter
//   ApiException.emptyResponse() {
//     message = "Something went wrong. Please try again later!";
//   }

//   ApiException.fromDioError(DioError error, BuildContext context) {
//     statusCode = error.response?.statusCode;
//     data = error.response?.data; // ✅ Assign data from response

//     switch (error.type) {
//       case DioErrorType.other:
//         message = "Unable to connect to server!";
//         break;
//       case DioErrorType.cancel:
//         message = "Request to server was cancelled";
//         break;
//       case DioErrorType.connectTimeout:
//         message = "Timed out while trying to connect!";
//         break;
//       case DioErrorType.receiveTimeout:
//         message = "Timed out while waiting for data!";
//         break;
//       case DioErrorType.response:
//         message = _handleResponseError(error: error, context: context);
//         break;
//       case DioErrorType.sendTimeout:
//         message = "Timed out while trying to send data!";
//         break;
//       default:
//         message = "Something went wrong. Please try again later!";
//         break;
//     }
//   }

//   String _handleResponseError({
//     required DioError error,
//     required BuildContext context,
//   }) {
//     final status = error.response!.statusCode ?? 500;

//     if (status == 401) {
//       Navigator.of(context).pushReplacementNamed(AppRoutes.login);
//     }

//     return _getErrorMessage(
//         error: error,
//         defaultMessage: "Something went wrong. Please try again later.");
//   }

//   String _getErrorMessage({
//     required DioError error,
//     required String defaultMessage,
//   }) {
//     log("Full error response: ${error.response}");
//     final data = error.response?.data;

//     if (data == null) return defaultMessage;

//     if (data is Map<String, dynamic>) {
//       // ✅ Always check for top-level "message"
//       if (data.containsKey("message") && data["message"] is String) {
//         return data["message"];
//       }

//       // ✅ Check for "error"
//       if (data.containsKey("error")) {
//         if (data["error"] is String) {
//           return data["error"];
//         } else if (data["error"] is List && data["error"].isNotEmpty) {
//           return data["error"][0].toString();
//         }
//       }

//       // ✅ Check for "errors" map (nested)
//       if (data.containsKey("errors") &&
//           data["errors"] is Map<String, dynamic>) {
//         final errorsMap = data["errors"] as Map<String, dynamic>;
//         if (errorsMap.isNotEmpty) {
//           final firstKey = errorsMap.keys.first;
//           final firstError = errorsMap[firstKey];

//           if (firstError is List && firstError.isNotEmpty) {
//             return firstError[0].toString();
//           } else if (firstError is String) {
//             return firstError;
//           }
//         }
//       }
//     }

//     return defaultMessage;
//   }
// }
