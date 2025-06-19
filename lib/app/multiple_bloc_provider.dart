import 'package:flutter/material.dart';
import 'package:flutter_application_2/cubit/cubit/loginn_cubit.dart';
import 'package:flutter_application_2/service/login_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultipleBlocProviders extends StatelessWidget {
  const MultipleBlocProviders({super.key, required Widget child})
      : _child = child;
  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(LoginService()),
        ),
      ],
      child: _child,
    );
  }
}
