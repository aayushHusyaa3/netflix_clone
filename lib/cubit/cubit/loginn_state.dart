part of 'loginn_cubit.dart';

enum LoginStatus { emptyInfo, initialLogin, logginIn, loggedIn, loginFailure }

class LoginState extends Equatable {
  const LoginState({
    required this.error,
    required this.status,
  });

  final LoginStatus status;
  final String error;

  LoginState copyWith({
    LoginStatus? status,
    String? error,
  }) {
    return LoginState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}
