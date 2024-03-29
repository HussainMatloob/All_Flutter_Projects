import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_expense_app/ui/auth/posts/post_screen.dart';

import '../../utils/utils.dart';
import '../../widgets/round_button.dart';
class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key,required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  @override
  bool loading=false;
  final TextEditingController verifyCodeController=TextEditingController();
  final GlobalKey<FormState> fkey=GlobalKey<FormState>();
  final auth=FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify'),),
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
                    controller:verifyCodeController,
                    decoration: InputDecoration(
                      hintText: ' 6 digit code',
                    ),
                  ),
                  SizedBox(height: 50,),
                  RoundButton(title: 'Verify',loading: loading, onTap:()async{
                    setState(() {
                      loading=true;
                    });
                 final credential=PhoneAuthProvider.credential(
                     verificationId: widget.verificationId,
                     smsCode: verifyCodeController.text.toString()
                 );

                 try{
                   await auth.signInWithCredential(credential);
                   Navigator.push(context,MaterialPageRoute(builder: (context)
                   =>PostScreen()));
                 }
                 catch(e){
                   setState(() {
                     loading=true;
                   });
                   Utils().toastMessage(e.toString());
                 }
                  })
                ],
              ),),
          ],
        ),
      ),
    );
  }
}