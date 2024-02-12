import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_project/model/user_model.dart';
import 'package:mvvm_project/utils/routes/routes_name.dart';
import 'package:mvvm_project/view_model/user_view_model.dart';

class SplashServices{

  Future<UserModel> getUserDate()=>UserViewModel().getUser();

  void checkAuthentication(BuildContext context)async{
   getUserDate().then((value) async{

     print(value.token);

     if(value.token=='null'||value.token=='')
       {
         await Future.delayed(Duration(seconds: 3));
         Navigator.pushNamed(context,RoutesName.login);
       }
     else {
       await Future.delayed(Duration(seconds: 3));
       Navigator.pushNamed(context,RoutesName.home);
     }

   }).onError((error, stackTrace) {
    if(kDebugMode){
      print(error.toString());
    }
   });
  }
}