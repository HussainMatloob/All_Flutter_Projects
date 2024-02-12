import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_states_manage/provider/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController passcon=TextEditingController();
  final TextEditingController emailcon=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authprovider=Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,title: Text('Login',style: TextStyle(color: Colors.white),),centerTitle: true,),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailcon,
            decoration: InputDecoration(
              hintText: "Email",
            ),
          ),
          SizedBox(height: 10,),
          TextFormField(
            obscureText: true,
            controller: passcon,
            decoration: InputDecoration(
              hintText: "Password",
            ),
          ),
          SizedBox(height: 15,),

          InkWell(
            onTap: (){
              authprovider.login(emailcon.text.toString(), passcon.text.toString());
            },
            child: Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(child: Text("Login")),
            ),
          )
        ],
      ),
    ),
    );
  }
}
