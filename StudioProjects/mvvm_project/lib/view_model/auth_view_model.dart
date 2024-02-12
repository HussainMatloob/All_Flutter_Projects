import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_project/repository/auth_repository.dart';
import 'package:mvvm_project/utils/routes/routes_name.dart';
import 'package:mvvm_project/utils/utils.dart';

class AuthViewMode with ChangeNotifier{
  final _myRepo=AuthRepository();

  bool _loading=false;
  bool get loading=>_loading;

  bool _SignUploading=false;
  bool get SignUploading=>_SignUploading;

  setLoading(bool value){
    _loading=value;
    notifyListeners();
  }

  setSignUpLoading(bool value){
     _SignUploading=value;
    notifyListeners();
  }

  Future<void> loginApii(dynamic data,BuildContext context) async{

    setLoading(true);

     _myRepo.loginApi(data).then((value){
       if(kDebugMode){

         print(value.toString());
         Utils.flushBarErrorMessages('Login Successfully', context);
         setLoading(false);
         Navigator.pushNamed(context, RoutesName.home);
       }
     }).onError((error, stackTrace){
       if(kDebugMode){
         Utils.flushBarErrorMessages(error.toString(), context);
         print(error.toString());
         setLoading(false);
       }
     });
  }

  Future<void> SignUpApi(dynamic data,BuildContext context) async{

    setSignUpLoading(true);

    _myRepo.signUpApi(data).then((value){
      if(kDebugMode){

        print(value.toString());
        Utils.flushBarErrorMessages('SignUp Successfully', context);
        setSignUpLoading(false);
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace){
      if(kDebugMode){
        Utils.flushBarErrorMessages(error.toString(), context);
        print(error.toString());
        setSignUpLoading(false);
      }
    });
  }
}