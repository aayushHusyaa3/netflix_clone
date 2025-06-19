import 'package:dio/dio.dart';

abstract class LoginRepo {
  const LoginRepo();

  Future<Response> loginRepo({required String email, required String password});
}
