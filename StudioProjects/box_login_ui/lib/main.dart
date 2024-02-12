import 'package:flutter/material.dart';

import 'ForgetPass.dart';
import 'Sign_Up.dart';

void main() {
  runApp(
      const MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage()));
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailCon = TextEditingController();
  final TextEditingController passCon = TextEditingController();
  final GlobalKey<FormState> logKey = GlobalKey<FormState>();
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
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Login Successfully"),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpPage()));
                    },
                    child: const Text(
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
    );
  }
}
