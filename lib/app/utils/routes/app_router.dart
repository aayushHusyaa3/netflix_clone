import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/utils/routes/app_routes.dart';
import 'package:flutter_application_2/screens/homePage.dart';
import 'package:flutter_application_2/screens/login.dart';
import 'package:flutter_application_2/screens/navigation.dart';
import 'package:flutter_application_2/screens/playScreen.dart';
import 'package:flutter_application_2/screens/register.dart';
import 'package:flutter_application_2/screens/splash_screen.dart';

class AppRouter {
  AppRouter();

  PageRouteBuilder _transitionTo(Widget child) {
    return PageRouteBuilder(
      barrierColor: Colors.white,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      maintainState: false,
      pageBuilder: (context, animation, secondaryAnimation) {
        return child;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
            Tween(
              begin: const Offset(1, 0),
              end: const Offset(0, 0),
            ).chain(CurveTween(curve: Curves.easeOutSine)),
          ),
          child: child,
        );
      },
    );
  }

  Route generateRoute(RouteSettings settings) {
    if (settings.name == AppRoutes.splashScreen) {
      return _transitionTo(SplashScreen());
    } else if (settings.name == AppRoutes.home) {
      return _transitionTo(HomePage());
    }
    // else if (settings.name == AppRoutes.forgetScreen) {
    //   return _transitionTo(ForgetPassword());
    // } else if (settings.name == AppRoutes.forgetScreen) {
    //   return _transitionTo(ForgetPassword());
    // }

    else if (settings.name == AppRoutes.navigationScreen) {
      return _transitionTo(NavigationPage());
    } else if (settings.name == AppRoutes.login) {
      return _transitionTo(LoginPage());
    } else if (settings.name == AppRoutes.playScreen) {
      final args = settings.arguments as Map;
      return _transitionTo(
        PlayScreen(
          title: args['title'],
          desc: args["desc"],
          imagePath: args['imagePath'],
          videolink: args['video_url'],
          ratings: args['rating'],
          date: args['release_date'],
        ),
      );
    } else if (settings.name == AppRoutes.register) {
      return _transitionTo(RegisterPage());
    } else {
      return _transitionTo(LoginPage());
    }
  }
}
