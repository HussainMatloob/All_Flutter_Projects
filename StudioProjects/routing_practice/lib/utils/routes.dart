
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routing_practice/first_screen.dart';
import 'package:routing_practice/second_page.dart';
import 'package:routing_practice/third_page.dart';
import 'package:routing_practice/utils/routes_name.dart';

class Routes
{
  static Route<dynamic> generateRoute(RouteSettings settings)
  {
    switch(settings.name)
        {
      case RouteName.firstScreen:
        return MaterialPageRoute(builder: (context)=>FirstPage());
      case RouteName.secondScreen:
        return MaterialPageRoute(builder: (context)=>SecondPage(data:settings.arguments as Map,));
      case RouteName.thirdScreen:
        return MaterialPageRoute(builder: (context)=>ThirdPage());
      default:
        return MaterialPageRoute(builder: (context){
          return Scaffold(
            body: Center(child: Text("No route Defined")),
          );
        });
        }
  }
}