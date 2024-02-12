import 'package:api_project/home_page3.dart';
import 'package:api_project/home_page4.dart';
import 'package:api_project/home_page5.dart';
import 'package:api_project/home_screen.dart';
import 'package:api_project/post_Api.dart';
import 'package:flutter/material.dart';

import 'home_screen2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home:PostClass(),
    );
  }
}
