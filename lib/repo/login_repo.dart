import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class LoginRepo {
  const LoginRepo();

  Future<Response> loginRepo({
    required String email,
    required String password,
    required BuildContext context,
  });
}
