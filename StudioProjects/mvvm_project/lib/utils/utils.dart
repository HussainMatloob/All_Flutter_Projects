import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Utils{
  static toastMessage(String message){
    Fluttertoast.showToast(msg: message,
    backgroundColor: Colors.red,
      textColor: Colors.black
    );
  }

  static void flushBarErrorMessages(String message,BuildContext context){
    showFlushbar(context: context,
        flushbar: Flushbar(message: message,
        forwardAnimationCurve: Curves.decelerate,
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        padding: EdgeInsets.all(15),
        borderRadius: BorderRadius.circular(5),
        backgroundColor: Colors.white,
        messageColor: Colors.black,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: Icon(Icons.error,size: 28,color: Colors.red,),
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
        )..show(context));
  }

  static void fieldFocusChange(BuildContext context,
      FocusNode current,FocusNode nextFocus){
         current.unfocus();
         FocusScope.of(context).requestFocus((nextFocus));
  }
}