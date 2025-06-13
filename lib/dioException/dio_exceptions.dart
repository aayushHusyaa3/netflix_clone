import 'package:dio/dio.dart';
import 'package:flutter_application_2/app/utils/uiHelper/ui_helper.dart';

void catchDioExceptionHanlder(context, DioException exe) {
  String errorMsg = "";
  if (exe.type == DioExceptionType.connectionTimeout ||
      exe.type == DioExceptionType.sendTimeout ||
      exe.type == DioExceptionType.receiveTimeout) {
    errorMsg = "Connection timeout. Please try again";
  } else if (exe.type == DioExceptionType.badCertificate ||
      exe.type == DioExceptionType.badResponse) {
    errorMsg = "Sever Error: bad response";
  } else if (exe.type == DioExceptionType.cancel) {
    errorMsg = "Your Request was Cancled";
  } else if (exe.type == DioExceptionType.connectionError) {
    errorMsg = "Check Your Internet Connection";
  } else {
    errorMsg = "Something went wrong ${exe.message}";
  }
  mySnackBar(context, snackBarText: errorMsg);
}
