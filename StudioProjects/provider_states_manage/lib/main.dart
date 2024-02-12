import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_states_manage/count_example.dart';
import 'package:provider_states_manage/login_Screen.dart';
import 'package:provider_states_manage/provider/auth_provider.dart';
import 'package:provider_states_manage/provider/counter_provider.dart';
import 'package:provider_states_manage/provider/example_one_provider.dart';
import 'package:provider_states_manage/provider/favourite_provider.dart';
import 'package:provider_states_manage/provider/theme_changer.dart';
import 'package:provider_states_manage/screen/Dart_Theme.dart';
import 'package:provider_states_manage/slider_example.dart';

import 'favourite/favourite_screen.dart';
import 'notifyLisnerScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

   // final themechanger=Provider.of<ThemeChanger>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>CountProvider(),),
        ChangeNotifierProvider(create: (_) =>ExampleOneProvider(),),
        ChangeNotifierProvider(create: (_)=>FavouriteProvider()),
        ChangeNotifierProvider(create: (_)=>ThemeChanger()),
        ChangeNotifierProvider(create: (_)=>AuthProvider()),
      ],
      child: Builder(builder: (BuildContext context){
        final themechanger=Provider.of<ThemeChanger>(context);
        return MaterialApp(
          title: 'Flutter',
          themeMode:themechanger.themeMode,
          theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.green,
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.red
            ),
            iconTheme: IconThemeData(
                color: Colors.blue
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.purple,
            primaryColor: Colors.purple,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.red
            ),
            iconTheme: IconThemeData(
              color: Colors.pink
            ),
          ),
          home:FavouriteScreen(),);
      })
    );


  }
}