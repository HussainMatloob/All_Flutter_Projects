import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_expense_app/ui/auth/verify_code.dart';
import 'package:home_expense_app/utils/utils.dart';
import 'package:home_expense_app/widgets/round_button.dart';
class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  @override
  bool loading=false;
  final TextEditingController PhoneNumber=TextEditingController();
  final GlobalKey<FormState> fkey=GlobalKey<FormState>();
  final auth=FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login'),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50,),
            Form(
             key: fkey,
              child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller:PhoneNumber,
                  decoration: InputDecoration(
                    hintText: '+1 234 3455 234',
                  ),
                ),
                SizedBox(height: 50,),
                RoundButton(title: 'Login',loading: loading, onTap:(){
                  setState(() {
                    loading=true;
                  });
                 auth.verifyPhoneNumber(
                     phoneNumber: PhoneNumber.text,
                     verificationCompleted:  (_){
                       setState(() {
                         loading=false;
                       });
                     },
                     verificationFailed: (e){
                       Utils().toastMessage(e.toString());
                       setState(() {
                         loading=false;
                       });
                     },
                     codeSent:(String verificationId,int? token){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      VerifyCodeScreen(verificationId:verificationId) ));
                       setState(() {
                         loading=false;
                       });
                       },
                     codeAutoRetrievalTimeout: (e){
                       Utils().toastMessage(e.toString());
                       setState(() {
                         loading=false;
                       });
                     });
                })
              ],
            ),),
          ],
        ),
      ),
    );
  }
}
