import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_project/utils/routes/routes_name.dart';
import 'package:mvvm_project/view/Sign_Up.dart';
import 'package:mvvm_project/view/home_screen.dart';
import 'package:mvvm_project/view/login_view.dart';
import 'package:mvvm_project/view/splash_view.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings)
  {
    switch(settings.name)
        {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context)=>SplashView());
      case RoutesName.home:
       return MaterialPageRoute(builder: (BuildContext context)=>HomeScreen());
      case RoutesName.login:
       return MaterialPageRoute(builder: (BuildContext context)=>LoginView());
      case RoutesName.signUp:
        return MaterialPageRoute(builder: (BuildContext context)=>SignUPView());
      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body:Center(
              child: Text("No Route Defined"),
            )
          );
        });
    }
  }
}