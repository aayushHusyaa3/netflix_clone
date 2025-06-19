import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_2/app/api/api_exceptions.dart';
import 'package:flutter_application_2/cubit/login/login_state.dart';
import 'package:flutter_application_2/repo/login_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginRepo repo;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  LoginCubit(this.repo) : super(LoginState(status: LoginStatus.initialLogin));

  Future<void> loginCubit({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      emit(
        state.copyWith(
          status: LoginStatus.emptyInfo,
          message: "Enter the required Field",
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: LoginStatus.logginIn,
          message: "Logging..... Please wait",
        ),
      );
    }

    try {
      final Response response = await repo.loginRepo(
        email: email,
        password: password,
      );
      final token = response.data['token'];
      if (state.isChecked) {
        await secureStorage.write(key: "email", value: email);
      } else {
        await secureStorage.delete(key: "email");
      }

      await secureStorage.write(key: "token", value: token);
      emit(
        state.copyWith(
          status: LoginStatus.loggedIn,
          message: "Logged in Succesful",
        ),
      );
    } on ApiException catch (exe) {
      emit(
        state.copyWith(
          status: LoginStatus.loginFailure,
          message: "Login Failure: ${exe.errorMsg}",
        ),
      );
    } catch (exe) {
      emit(state.copyWith(status: LoginStatus.loginFailure, message: "$exe"));
    }
  }

  void clearMessage() {
    emit(state.copyWith(message: null));
  }

  void onCheckBoxClicked(bool newValue) {
    emit(state.copyWith(isChecked: newValue));
  }

  Future<String?> rememberEmail() async {
    final rememberEmail = await secureStorage.read(key: 'email');
    return rememberEmail!;
  }
}
