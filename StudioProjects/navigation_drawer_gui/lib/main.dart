import 'package:flutter/material.dart';
import 'package:navigation_drawer_gui/home_screen.dart';
import 'package:navigation_drawer_gui/pageTwo.dart';

void main() {
  runApp(const DrawerWidgets());
}
class DrawerWidgets extends StatelessWidget {
  const DrawerWidgets({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.id,
     routes:
     {
       HomeScreen.id :(context)=>HomeScreen(),
       SecondPage.id : (context ) => SecondPage(),
     },
     // home: HomeScreen(),
    );
  }
}

