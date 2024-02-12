import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_changer.dart';
class DartThemeScreen extends StatefulWidget {
  const DartThemeScreen({super.key});

  @override
  State<DartThemeScreen> createState() => _DartThemeScreenState();
}

class _DartThemeScreenState extends State<DartThemeScreen> {
  @override
  Widget build(BuildContext context) {
    final themechanger=Provider.of<ThemeChanger>(context);
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.cyan,title: Text("Theme Changer"),centerTitle: true,),
      body: Column(
        children: [
          RadioListTile<ThemeMode>(
              title: Text('Light Mode'),
              value: ThemeMode.light,
              groupValue: themechanger.themeMode,
              onChanged: themechanger.setTheme),
          RadioListTile<ThemeMode>(
              title: Text('Dark Mode'),
              value: ThemeMode.dark,
              groupValue: themechanger.themeMode,
              onChanged: themechanger.setTheme),
          RadioListTile<ThemeMode>(
              title: Text('System Mode'),
              value: ThemeMode.system,
              groupValue: themechanger.themeMode,
              onChanged: themechanger.setTheme),
          Icon(Icons.favorite),

        ],
      ),
    );
  }
}
