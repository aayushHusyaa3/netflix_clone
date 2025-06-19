import 'package:dio/dio.dart';
import 'package:flutter_application_2/app/api/api_helpers.dart';
import 'package:flutter_application_2/app/api/api_path.dart';
import 'package:flutter_application_2/repo/login_repo.dart';

class LoginService implements LoginRepo {
  @override
  Future<Response> loginRepo({
    required String email,
    required String password,
  }) async {
    final Response response = await ApiHelper.post(
      path: ApiPath.loginUrl,
      data: {"email": email, "password": password},
    );
    return response;
  }
}
