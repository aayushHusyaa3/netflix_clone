import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/utils/routes/app_routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void initState() {
    splashScreenInitilized(context);
    super.initState();
  }

  void splashScreenInitilized(context) async {
    final token = await storage.read(key: "token");
    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, AppRoutes.navigationScreen);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(image: AssetImage("assets/images/movieshunt.png")),
      ),
    );
  }
}
