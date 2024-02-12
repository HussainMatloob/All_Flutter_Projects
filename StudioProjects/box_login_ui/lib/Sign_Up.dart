import 'package:flutter/material.dart';

import 'main.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailCon = TextEditingController();
  final TextEditingController passCon = TextEditingController();
  final GlobalKey<FormState> logKey = GlobalKey<FormState>();
  final TextEditingController contactCon=TextEditingController();
  final TextEditingController NameCon=TextEditingController();
  @override

  String? nameValidate(value)
  {
    if(value==null||value.trim().isEmpty)
      {
        return "Please enter name";
      }

    bool nameRegx=RegExp(r'^[a-zA-z]+$').hasMatch(value);
    if(nameRegx==false)
      {
        return "Please enter valid name";
      }
    return null;
  }
  String? contactValidate(value)
  {
    if(value==null||value.trim().isEmpty)
      {
        return "Please enter Contact number";
      }
    bool contactRegex=RegExp(r'^[0-9]+$').hasMatch(value);
    if(contactRegex==false)
      {
        return"Please enter number with digits";
      }
    return null;
  }
  String? EmailValidate(value)
  {
    if(value==null||value.trim().isEmpty)
      {
        return "Please enter an email";
      }
    bool emailreg=RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value);
    if(emailreg==false)
      {
        return"Please enter valid email";
      }
    return null;
  }
  String? PasswordValidate(value)
  {
   if(value==null||value.trim().isEmpty)
     {
       return"Please enter password";
     }
   bool passRegex=RegExp( r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}|:<>?~,-.]).{7,}$').hasMatch(value);
    if(passRegex==false)
    {
      return "Password must contain at least one lowercase, \none uppercase, one digit, and one special character";
    }
    return null;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('images/logo.png'),
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
                      "Maintenance",
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Rubik Medium',
                          color: Colors.black),
                    ),
                    Text(
                      "Box",
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
              height: 30,
            ),
            const Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Rubik Medium',
                      color: Colors.black),
                )),
            const SizedBox(
              height: 15,
            ),
            const Center(
              child: Text(
                'Learn ipsum sit amet, \nconsectetur adipiscing elit',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Rubik Regular',
                    color: Color(0xff4C5980)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(height: 20,),
            Align(
              child: SizedBox(
                width: 340,
                child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: NameCon,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person,color:Color(0xffF323F4B),),
                      focusedBorder:const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffEE7EB)),
                      ),
                      enabledBorder:const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffEE7EB)),
                      ),
                      hintText: 'Name',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: nameValidate,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Align(
              child: SizedBox(
                width: 340,
                child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: contactCon,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone,color:Color(0xffF323F4B),),
                      focusedBorder:const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffEE7EB)),
                      ),
                      enabledBorder:const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffEE7EB)),
                      ),
                      hintText: 'contact',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator:contactValidate,
                ),
              ),
            ),
           const SizedBox(height: 20,),
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
                   validator:  EmailValidate,
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
                    validator: PasswordValidate,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              child: GestureDetector(
                onTap:(){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("SignUp Successfully"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration:BoxDecoration(
                      color: const Color(0xffF97038),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Center(
                    child: Text(
                      'SIGN Up',
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
                const Text("Already have an account?"),
                const SizedBox(
                  width: 1,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Rubik Regular'),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
