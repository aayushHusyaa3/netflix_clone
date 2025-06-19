import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/api/api_exceptions.dart';
import 'package:flutter_application_2/repo/login_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'loginn_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginRepo repo;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  LoginCubit(this.repo)
      : super(LoginState(status: LoginStatus.initialLogin, error: ""));

  void loginCubit({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(state.copyWith(status: LoginStatus.logginIn));

    try {
      final Response response = await repo.loginRepo(
        context: context,
        email: email,
        password: password,
      );
      final token = response.data['token'];
      secureStorage.write(key: "token", value: token);
      emit(
        state.copyWith(
          status: LoginStatus.loggedIn,
          // message: "Logged in Succesful",
        ),
      );
    } on ApiException catch (exe) {
      emit(state.copyWith(
          status: LoginStatus.loginFailure, error: exe.errorMsg));
    }
  }
}
