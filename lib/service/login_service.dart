import 'package:dio/dio.dart';
import 'package:flutter_application_2/app/api/api_helpers.dart';
import 'package:flutter_application_2/app/api/api_path.dart';
import 'package:flutter_application_2/repo/login_repo.dart';
import 'package:flutter/material.dart';

class LoginService implements LoginRepo {
  @override
  Future<Response> loginRepo(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final Response response = await ApiHelpers.post(
      path: ApiPath.loginUrl,
      context: context,
      body: {"email": email, "password": password},
    );
    return response;
  }
}
