import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_expense_app/ui/auth/login_with_phone_number.dart';
import 'package:home_expense_app/ui/auth/posts/post_screen.dart';
import 'package:home_expense_app/ui/signup_screen.dart';
import 'package:home_expense_app/utils/utils.dart';

import '../../widgets/round_button.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
    if (value.trim().isEmpty)
    {
      return 'Please enter a password';
    }
    bool passRegx = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}|:<>?~,-.]).{7,}$')
        .hasMatch(value);
    if (!passRegx)
    {
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

  void login()
  {
    setState(() {
      loading=true;
    });
    auth.signInWithEmailAndPassword(email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value){
      Utils().toastMessage(value.user!.email.toString());

      setState(() {
        loading=false;
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=>PostScreen()));
    }).onError((error, stackTrace){

      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading=false;
      });
    });
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Login'),
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
              RoundButton(title: 'Login',
                loading: loading,
                onTap: (){
                if(fKey.currentState!.validate())
                  {
                    login();
                  }
                },),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(onPressed:()
                  {
                 Navigator.push(context,
                     MaterialPageRoute(builder: (context)=>SignUpScreen()));
                  },
                      child: Text('Sign Up'))
                ],
              ),
              SizedBox(height: 30,),
              InkWell(
                onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder:
                       (context)=>LoginWithPhoneNumber()));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child:Center(
                    child: Text('Login with phone'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
