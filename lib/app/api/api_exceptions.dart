import 'package:dio/dio.dart';

class ApiException implements Exception {
  String? errorMsg;
  ApiException({this.errorMsg = ""});

  ApiException.emptyResponse() {
    errorMsg = "Something went wrong... Please wait again";
  }

  ApiException.fromDioError(DioException exe) {
    final statusCode = exe.response?.statusCode;
    final data = exe.response?.data;
    if (exe.type == DioExceptionType.connectionTimeout ||
        exe.type == DioExceptionType.sendTimeout ||
        exe.type == DioExceptionType.receiveTimeout) {
      errorMsg = "Connection timeout. Please try again";
    } else if (exe.type == DioExceptionType.badCertificate ||
        exe.type == DioExceptionType.badResponse) {
      if (statusCode != null) {
        errorMsg = data["message"];
      } else {
        errorMsg = "Unexcepted error occured... Please try again later";
      }
    } else if (exe.type == DioExceptionType.cancel) {
      errorMsg = "Your Request was Cancled";
    } else if (exe.type == DioExceptionType.connectionError) {
      errorMsg = "Check Your Internet Connection";
    } else {
      errorMsg = "Something went wrong ${data['message']}";
    }
  }
}
