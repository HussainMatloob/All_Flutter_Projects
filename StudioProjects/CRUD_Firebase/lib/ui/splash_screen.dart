import 'package:flutter/material.dart';
import 'package:home_expense_app/firebase_services/splash_services.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen=SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    splashScreen.isLogin(context);
  }
  Widget build(BuildContext context) {
     return Scaffold(
    body: Center(
      child: Text('Loading.....',style:
        TextStyle(fontSize: 30),),
    ),
    );
  }
}
