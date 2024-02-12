import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPAge extends StatefulWidget {
  const ForgetPAge({super.key});

  @override
  State<ForgetPAge> createState() => _ForgetPAgeState();
}

class _ForgetPAgeState extends State<ForgetPAge> {

  bool loading=false;

  final TextEditingController emailCon = TextEditingController();
  final TextEditingController passCon = TextEditingController();
  final GlobalKey<FormState> logKey = GlobalKey<FormState>();
  final auth=FirebaseAuth.instance;
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
                    "Forgot Password",
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

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Resend Email",
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

                        auth.sendPasswordResetEmail(email: emailCon.text.toString()).then((value){

                          setState(() {
                            loading=false;
                          });
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(child: Text("We have send you email to recover password please check email".toString(),style: TextStyle(color: Colors.black))),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.white,
                              elevation: 5,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );

                        }).onError((error, stackTrace){
                          setState(() {
                            loading=false;
                          });
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(child: Text(error.toString().toString(),style: TextStyle(color: Colors.black))),
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
                    child: Center(
                      child:loading ? CircularProgressIndicator(strokeWidth: 3,color: Colors.white,): Text(
                        'Send Code',
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
            ],
          ),
        ),
      ),
    );
  }
}
