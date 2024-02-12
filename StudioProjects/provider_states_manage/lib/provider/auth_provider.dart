import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
class AuthProvider with ChangeNotifier{


void login(String email,String password)
async{
  try{
    Response response=await post(Uri.parse('https://reqres.in/api/login'),
    body:{
    'email':email,
    'password':password,
    }
    );
    if(response.statusCode==200)
      {
        print("Successfull");
      }
    else{
      print("Failed");
    }
  }catch(e){
    print(e.toString());
  }
}
}