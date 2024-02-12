
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_expenses/Add_Expenses.dart';
import 'package:home_expenses/Forget_Page.dart';
import 'package:home_expenses/SignUp_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailCon = TextEditingController();
  final TextEditingController passCon = TextEditingController();
  final GlobalKey<FormState> logKey = GlobalKey<FormState>();

  final _auth=FirebaseAuth.instance;

  bool loading=false;

  @override
  String? EmaileValidate(value)
  {
    if(value==null||value.toString().isEmpty)
    {
      return "Please enter an email";
    }
    bool emailreg=RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value);
    if(emailreg==false)
    {
      return"Please enter valid email";
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: Form(
          key: logKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 70,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('images/ExpenseImage.png'),
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Home",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Rubik Medium',
                            color: Colors.black),
                      ),
                      Text(
                        "Expenses",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Rubik Medium',
                            color: Color(0xffF97038)),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Rubik Medium',
                        color: Colors.black),
                  )),
              const SizedBox(
                height: 15,
              ),

              const SizedBox(
                height: 20,
              ),
              Align(
                child: SizedBox(
                  width: 340,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailCon,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email,color:Color(0xffF323F4B),),
                      focusedBorder:const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffEE7EB)),
                      ),
                      enabledBorder:const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffEE7EB)),
                      ),
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: EmaileValidate,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                child: SizedBox(
                  width: 340,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passCon,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock,color:Color(0xffF323F4B)),
                      suffixIcon: Icon(Icons.visibility_off_outlined),
                      focusedBorder:const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffEE7EB)),
                      ),
                      enabledBorder:const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffEE7EB)),
                      ),
                      hintText: 'Password',
                      filled: true,
                      fillColor: Color(0xffFBF9FA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value)
                    {
                      if(value==null||value.isEmpty)
                        {
                          return "Pleas enter an password";
                        }
                    }
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPAge()));
                      },
                      child: const Text(
                        "Forget Password",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: 'Rubik Regular',
                            color: Colors.black),
                      )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                child: GestureDetector(
                  onTap:(){
                    if(logKey.currentState!.validate())
                      {
                        setState(() {
                          loading=true;
                        });
                        _auth.signInWithEmailAndPassword(email:emailCon.text.toString(),
                            password: passCon.text.toString()).then((value) async{
                          SharedPreferences sp=await SharedPreferences.getInstance();
                          sp.setString('Email', emailCon.text);
                          sp.setString('password', passCon.text);
                          sp.setBool('isLogin', true);

                          setState(() {
                            loading=false;
                          });

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddExpenses()));

                        }).onError((error, stackTrace){

                          setState(() {
                            loading=false;
                          });

                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(child: Text(error.toString(),style: TextStyle(color: Colors.black))),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.white,
                              elevation: 5,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        });
                      }
                  },
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration:BoxDecoration(
                        color: const Color(0xffF97038),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:Center(
                      child:loading ? CircularProgressIndicator(strokeWidth: 3,color: Colors.white,) : Text(
                        'LOG IN',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'Rubik Regular'),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(
                    width: 1,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPage()));
                      },
                      child:Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'Rubik Regular'),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
