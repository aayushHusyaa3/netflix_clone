import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/utils/api_helpers.dart';
import 'package:flutter_application_2/app/utils/routes/app_routes.dart';
import 'package:flutter_application_2/app/utils/uiHelper/ui_helper.dart';
import 'package:flutter_application_2/dioException/dio_exceptions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final Dio dio = Dio();
  bool toogleValue = false;

  void toogleCheck() {
    notifyListeners();
  }

  Future<void> loginApi(context) async {
    String myEmail = emailController.text.trim();
    String myPass = passController.text.trim();
    try {
      if (myEmail.isEmpty || myPass.isEmpty) {
        myAlertBox(context, titleText: "Enter the required fields");
      }

      final Response response = await dio.post(
        ApiHelpers.loginUrl,
        data: {"email": myEmail, "password": myPass},
      );

      if (response.statusCode == 200) {
        clearTextField();
        myAlertBox(context, titleText: "Login Successful");
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushNamed(context, AppRoutes.navigationScreen);
        });

        final token = response.data['token'];
        await secureStorage.write(key: "token", value: token);
      } else {
        myAlertBox(context, titleText: "Login Failed: ${response.statusCode}");
      }
    } on DioException catch (exe) {
      catchDioExceptionHanlder(context, exe);
    }
  }

  Future<void> registerApi(context) async {
    String myName = nameController.text.toString();
    String myEmail = emailController.text.toString();
    String myPass = passController.text.toString();
    String myConfirmPas = confirmPassController.text.toString();
    try {
      if (myName.isEmpty ||
          myPass.isEmpty ||
          myConfirmPas.isEmpty ||
          myEmail.isEmpty) {
        myAlertBox(context, titleText: "Enter the required Field");
      }
      final Response response = await dio.post(
        ApiHelpers.registerUrl,
        data: {
          "email": myEmail,
          "name": myName,
          "password": myPass,
          "password_confirmation": myConfirmPas,
        },
      );
      if (response.statusCode == 200) {
        clearTextField();

        myAlertBox(context, titleText: "Regsiter Succesful");
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushNamed(context, AppRoutes.login);
        });
      }
    } on DioException catch (exe) {
      catchDioExceptionHanlder(context, exe);
    }
  }

  void clearTextField() {
    nameController.clear();
    emailController.clear();
    passController.clear();
    confirmPassController.clear();
  }
}
