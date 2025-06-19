import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/cubit/login/login_cubit.dart';
import 'package:flutter_application_2/service/login_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultipleBlocProvider extends StatelessWidget {
  final Widget child;
  const MultipleBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(LoginService()),
        ),
      ],
      child: child,
    );
  }
}
