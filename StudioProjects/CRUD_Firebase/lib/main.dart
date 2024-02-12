import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_expense_app/ui/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context)
  {
   return MaterialApp(
     theme: ThemeData(primarySwatch: Colors.deepPurple),
     home: SplashScreen(),
   );
  }
}
