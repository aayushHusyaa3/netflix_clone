import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class ApiException implements Exception {
  String errorMsg = "";
  int? statusCode;
  dynamic data;

  ApiException(this.errorMsg, {this.statusCode, this.data});
  ApiException.emptyResponse() {
    errorMsg = "Something went wrong";
  }

  ApiException.fromDioException(DioError error, BuildContext context) {
    statusCode = error.response?.statusCode;
    data = error.response?.data;

    final type = error.type;

    if (type == DioErrorType.cancel) {
      errorMsg = "Request to server was cancelled";
    } else if (type == DioErrorType.connectTimeout) {
      errorMsg = "Timed out while trying to connect!";
    } else if (type == DioErrorType.receiveTimeout) {
      errorMsg = "Timed out while waiting for data!";
    } else if (type == DioErrorType.sendTimeout) {
      errorMsg = "Timed out while trying to send data!";
    } else if (type == DioErrorType.response) {
      errorMsg = _handleResponseError(error: error, context: context);
    } else {
      errorMsg = "Something went wrong. Please try again later!";
    }
  }

  String _handleResponseError({
    required DioError error,
    required BuildContext context,
  }) {
    final status = error.response!.statusCode;

    // if (status == 401) {
    // }

    log("Error status code: $status");

    return _getErrorMessage(
        error: error,
        defaultMessage: "Something went wrong. Please try again later.");
  }

  String _getErrorMessage({
    required DioError error,
    required String defaultMessage,
  }) {
    log("Full error response: ${error.response}");
    final data = error.response?.data;

    if (data == null) return defaultMessage;

    if (data is Map<String, dynamic>) {
      if (data.containsKey("message") && data["message"] is String) {
        log("message is present in response");

        return data["message"];
      }
    }

    return defaultMessage;
  }
}
