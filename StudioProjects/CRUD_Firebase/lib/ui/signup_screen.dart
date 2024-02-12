import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_expense_app/ui/auth/login_Screen.dart';

import '../../widgets/round_button.dart';
import '../utils/utils.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool loading=false;
  final GlobalKey<FormState> fKey = GlobalKey<FormState>();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();

  FirebaseAuth auth=FirebaseAuth.instance;

  String? validateEmail(value) {
    if (value.trim().isEmpty) {
      return 'Please enter an email';
    }
    bool emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value);
    if (!emailRegex) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? passwordValidate(value) {
    if (value.trim().isEmpty) {
      return 'Please enter a password';
    }
    bool passRegx = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}|:<>?~,-.]).{7,}$')
        .hasMatch(value);
    if (!passRegx) {
      return 'Password must contain at least one lowercase letter, one uppercase letter, one digit, and one special character.';
    }
    return null;
  }

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: Text('SignUp'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key:fKey,
              child:Column(
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      helperText: 'enter email.jon@gmail.com',
                      prefixIcon: Icon(Icons.alternate_email),
                    ),
                    validator: validateEmail,
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator:  passwordValidate,
                  ),
                ],
              ),
            ),
            SizedBox(height: 50,),
            RoundButton(title: 'Sign Up',
              loading:loading,
              onTap: (){
                if(fKey.currentState!.validate())
                {
                  setState(() {
                    loading=true;
                  });
                  auth.createUserWithEmailAndPassword(email: emailController.text.toString(),
                      password: passwordController.text.toString()).then((value){
                    setState(() {
                      loading=false;
                    });
                  }).onError((error, stackTrace){
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading=false;
                    });
                  });
                }
              },),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Alredy have an account?"),
                TextButton(onPressed:()
                {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>LoginScreen()));
                },
                    child: Text('Login'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
