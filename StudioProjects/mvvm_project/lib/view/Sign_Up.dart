import 'package:flutter/material.dart';
import 'package:mvvm_project/res/components/round_buton.dart';
import 'package:mvvm_project/utils/routes/routes_name.dart';
import 'package:mvvm_project/utils/utils.dart';
import 'package:provider/provider.dart';

import '../view_model/auth_view_model.dart';

class SignUPView extends StatefulWidget {
  const SignUPView({super.key});

  @override
  State<SignUPView> createState() => _SignUPViewState();
}

class _SignUPViewState extends State<SignUPView> {
  ValueNotifier<bool> _obsecurePassword=ValueNotifier<bool>(true);

  final TextEditingController email=TextEditingController();
  final TextEditingController passwored=TextEditingController();

  FocusNode emailFocus=FocusNode();
  FocusNode passwordFocus=FocusNode();

  @override

  void dispose(){
    super.dispose();
    email.dispose();
    passwored.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    _obsecurePassword.dispose();
  }

  Widget build(BuildContext context) {
    final authViewMode=Provider.of<AuthViewMode>(context);
    final height=MediaQuery.of(context).size.height*1;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.cyan,title: Text('SignUp Screen'),centerTitle: true,),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocus,
                controller: email,
                decoration: InputDecoration(
                  // hintText: 'Email',
                  labelText: 'Email',
                  prefix: Icon(Icons.email),
                ),
                onFieldSubmitted: (value){
                  //FocusScope.of(context).requestFocus(passwordFocus);
                  Utils.fieldFocusChange(context, emailFocus,passwordFocus);
                },
              ),
            ),
            SizedBox(height: 10,),
            ValueListenableBuilder(valueListenable: _obsecurePassword,
                builder: (context,value,child){
                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      focusNode: passwordFocus,
                      obscureText: _obsecurePassword.value,
                      obscuringCharacter: '*',
                      controller: passwored,
                      decoration: InputDecoration(
                        //hintText: 'Password',
                        labelText: 'Password',
                        prefix: Icon(Icons.lock),
                        suffixIcon: InkWell(
                            onTap: (){
                              _obsecurePassword.value=!_obsecurePassword.value;
                            },
                            child:_obsecurePassword.value? Icon(Icons.visibility_off_outlined):Icon(Icons.remove_red_eye)),
                      ),
                    ),
                  );
                }),

            SizedBox(height: height*.03,),
            RoundButton(title: 'SignUp',
              loading: authViewMode.SignUploading,
              onPress: (){
                if(email.text.isEmpty)
                {
                  Utils.flushBarErrorMessages("Please Enter an email", context);
                }
                else if(passwored.text.isEmpty){
                  Utils.flushBarErrorMessages('Please enter an password', context);
                }
                else if(passwored.text.length<6){
                  Utils.flushBarErrorMessages('Password must have at least 6 digits', context);
                }
                else{
                  Map data={
                    'email':email.text.toString(),
                    'password':passwored.text.toString(),
                  };
                  authViewMode.SignUpApi(data,context);

                  print("Api Hit");
                }
              },),
            SizedBox(height: height*.02,),
            InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.login);
                },
                child: Text("Already have an account? Login")),
          ],
        ),
      ),
    );
  }
}
