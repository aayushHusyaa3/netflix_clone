import 'package:equatable/equatable.dart';

enum LoginStatus { emptyInfo, initialLogin, logginIn, loggedIn, loginFailure }

class LoginState extends Equatable {
  final LoginStatus status;
  final String? message;
  final bool isChecked;

  const LoginState({
    required this.status,
    this.message,
    this.isChecked = false,
  });

  LoginState copyWith({LoginStatus? status, String? message, bool? isChecked}) {
    return LoginState(
      status: status ?? this.status,
      message: message ?? this.message,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  @override
  List<Object?> get props => [status, message, isChecked];
}
