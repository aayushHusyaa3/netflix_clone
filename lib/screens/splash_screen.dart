import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/utils/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  late AnimationController animationController;
  late Animation<double> tweenController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    tweenController = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.bounceIn),
    );
    animationController.repeat();
    splashScreenInitilized(context);
  }

  void splashScreenInitilized(context) async {
    final token = await storage.read(key: "token");

    Timer(Duration(seconds: 3), () {
      if (token != null && token.isNotEmpty) {
        Navigator.pushReplacementNamed(context, AppRoutes.navigationScreen);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: tweenController,
          builder: (context, child) {
            return Transform.scale(
              scale: tweenController.value,
              child: SizedBox(
                width: 200.w,
                child: Image(image: AssetImage("assets/images/movieshunt.png")),
              ),
            );
          },
        ),
      ),
    );
  }
}
