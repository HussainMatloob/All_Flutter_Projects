import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class PostClass extends StatefulWidget {
  const PostClass({super.key});

  @override
  State<PostClass> createState() => _PostClassState();
}

class _PostClassState extends State<PostClass> {

  final GlobalKey<FormState> fKey = GlobalKey<FormState>();
  TextEditingController eCon = TextEditingController();
  TextEditingController nCon = TextEditingController();
  TextEditingController pCon = TextEditingController();

  @override

  String? validateEmail(value) {
    if (value.trim().isEmpty) {
      return 'Please enter an email';
    }
    bool emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value);
    if (emailRegex == false) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? nameValidate(value) {
    if (value.trim().isEmpty) {
      return 'Please enter a name';
    }
    bool nameReg = RegExp(r'^[a-zA-Z_-]+(?: [a-zA-Z_-]+)*$').hasMatch(value);
    if (nameReg == false) {
      return 'Please enter a valid name';
    }
    return null;
  }

  String? PasswordValidate(value) {
    if (value.trim().isEmpty) {
      return 'Please enter a password';
    }
    bool passRegx = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}|:<>?~,-.]).{7,}$')
        .hasMatch(value);
    if (passRegx == false) {
      return 'Password must contain at least one lowercase letter, \none uppercase letter, one digit, and one special character.';
    }
    return null;
  }

  void statusOfSubmit()
  {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("login Successfully"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> insertData(String email, String password) async {
    //final Uri uri = Uri.parse('https://reqres.in/api/register');
    final Uri uri = Uri.parse('https://reqres.in/api/login');

    try {
      Response response = await http.post(
        uri,
        body:
        {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        var data=jsonDecode(response.body.toString());
        print(data['token']);
        statusOfSubmit();

      } else {
        // Handle errors based on the response status code or content
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("fail to login"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Handle general exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("An error occurred during the request. Check logs."),
          duration: Duration(seconds: 2),
        ),
      );
    }
    //An error occurred during the request. Check logs.'
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Post Signup Page"),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10.0),
        child: Form(
          key:fKey,
          child:Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: eCon,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
               // validator: validateEmail,
              ),

              SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: pCon,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
               // validator: PasswordValidate,
              ),
              SizedBox(height: 16),
           InkWell(
             onTap: (){
    if (fKey.currentState!.validate())
    {
      insertData(eCon.text,pCon.text);
    }
             },
             child: Container(
               width: 200,
               height: 50,
               decoration: BoxDecoration(
                 color: Colors.purple,
                 borderRadius: BorderRadius.circular(10),
               ),
               child: Center(child: Text('Login')),
             ),
           ),
              SizedBox(height: 10),
              SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {

                    //eCon.text = "";
                    //nCon.text = "";
                    //pCon.text = "";
                    Navigator.pushNamed(context, '/second');
                  },
                  child: Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//if (fKey.currentState!.validate()) {
//insertData(eCon.text, nCon.text, pCon.text);