import 'package:equatable/equatable.dart';

enum LoginStatus { emptyInfo, initialLogin, logginIn, loggedIn, loginFailure }

class LoginState extends Equatable {
  final LoginStatus status;
  final String? message;
  const LoginState({required this.status, this.message});

  LoginState copyWith({LoginStatus? status, String? message}) {
    return LoginState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
