import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modelview/utils/routes/routes_name.dart';
import 'package:modelview/view/home_screen.dart';
import 'package:modelview/view/login_view.dart';
import 'package:modelview/view/signup_view.dart';
import 'package:modelview/view/splash_view.dart';

class Routes{
  static Route<dynamic>generateRoute(RouteSettings settings){
    final argue=settings.arguments;
    switch (settings.name){



      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context)=>HomeScreen());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context)=>LoginView());
      case RoutesName.signup:
        return MaterialPageRoute(builder: (BuildContext context)=>SignUpView());

      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context)=>SplashView());

      default:return MaterialPageRoute(builder: (_){
        return const Scaffold(
          body: Center(
            child: Text("")
          ),
        );
      });
    }
  }
}