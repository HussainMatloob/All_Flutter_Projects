import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multirolebase_app/admin_screen.dart';
import 'package:multirolebase_app/teacher_screen.dart';
import 'package:multirolebase_app/login_screen.dart';
import 'package:multirolebase_app/student_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
     void isLogin()
    async{
      SharedPreferences sp=await SharedPreferences.getInstance();
      bool? isLogin =sp.getBool('isLogin');
      String? userType=sp.getString('userType');

      if(isLogin==true && userType=='Student')
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
              StudentScreen()));
        }
      else if(isLogin==true && userType=='Teacher')
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
              TeacherScreen()));
        }
      else if(isLogin==true && userType=='Admin')
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
              AdminScreen()));
        }
      else
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
              LoginScreen()));
        }
     }
    Timer(Duration(seconds: 3),(){
      isLogin ();
    });
  }

  Widget build(BuildContext context) {
    return  Scaffold(
   body: Image(
     height: double.infinity,
     fit: BoxFit.fitHeight,
     image:NetworkImage('https://images.pexels.com/photos/8040961/pexels-photo-8040961.jpeg?auto=compress&cs=tinysrgb&w=400&lazy=load'),)
    );
  }

}
