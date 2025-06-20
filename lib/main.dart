import 'package:flutter/material.dart';

import 'package:flutter_application_2/app/utils/routes/app_router.dart';
import 'package:flutter_application_2/app/utils/routes/app_routes.dart';
import 'package:flutter_application_2/screens/login.dart';
import 'package:flutter_application_2/service/multiple_bloc_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    MultipleBlocProvider(child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(brightness: Brightness.dark),
          onGenerateRoute: AppRouter().generateRoute,
          initialRoute: AppRoutes.splashScreen,
        );
      },
    );
  }
}
