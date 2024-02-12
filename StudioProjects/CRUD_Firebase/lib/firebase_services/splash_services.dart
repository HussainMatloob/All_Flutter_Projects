import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_expense_app/ui/auth/posts/post_screen.dart';

import '../ui/auth/login_Screen.dart';
import '../ui/firestore/firestore_list_screen.dart';
import '../ui/upload_image.dart';
class SplashServices
{
  void isLogin(BuildContext context)
  {
 final auth=FirebaseAuth.instance;
 final user=auth.currentUser;
 if(user!=null)
   {
     //Timer(const Duration(seconds: 3),
           //  ()=> Navigator.push(context,MaterialPageRoute(builder: (context,)=>PostScreen()))
   //  );
     Timer(const Duration(seconds: 3),
             ()=> Navigator.push(context,MaterialPageRoute(builder: (context,)=>UploadImageScreen()))
     );
   }
 else {
   Timer(const Duration(seconds: 3), () => Navigator.push(
               context, MaterialPageRoute(builder: (context,) => LoginScreen()))
   );
 }
  }
}