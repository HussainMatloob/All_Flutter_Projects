import'package:flutter/material.dart';
import 'package:multirolebase_app/admin_screen.dart';
import 'package:multirolebase_app/student_screen.dart';
import 'package:multirolebase_app/teacher_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> fkey=GlobalKey<FormState>();
  final  TextEditingController Emailcon=TextEditingController();
  final TextEditingController PassCon=TextEditingController();
  final TextEditingController AgeCon=TextEditingController();

  String selectedSubject = 'Admin';
  List<String> subjects = ['Admin', 'Teacher', 'Student'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,title: Text('Sign Up'),
        centerTitle: true,automaticallyImplyLeading: false,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: fkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey,
                ),// Set a fixed height for the container
                child: DropdownButton<String>(
                  value: selectedSubject,
                  items: subjects.map((String subject) {
                    return DropdownMenuItem<String>(
                      value: subject,
                      child: Text(subject),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSubject = newValue!;
                    });
                  },
                  isExpanded: true,
                ),
              ),
           SizedBox(height: 10,),

              TextFormField
                (
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: Emailcon,
                 decoration: InputDecoration(
                   prefixIcon: Icon(Icons.email_outlined),
                   hintText: "Email",
                   filled: true,
                   fillColor: Colors.grey,
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10),
                   )
                 ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty)
                  {
                    return "Please must fill field";
                  }
                }
                ),
              SizedBox(height: 10,),
              TextFormField
                (
                autovalidateMode:AutovalidateMode.onUserInteraction,
                controller: PassCon,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: "Password",
                    filled: true,
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )

                ),
                validator:(value)
                {
                  if (value == null || value
                      .trim()
                      .isEmpty) {
                    return "Please must fill field";
                  }
                }
              ),
              SizedBox(height: 10,),
              TextFormField
                (
                  autovalidateMode:AutovalidateMode.onUserInteraction,
                  controller: AgeCon,
                  decoration: InputDecoration(
                      //prefixIcon: Icon(Icons.person),
                      hintText: "Age",
                      filled: true,
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )

                  ),
                  validator:(value)
                  {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return "Please must fill field";
                    }
                  }
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: ()
                async{
                  if(fkey.currentState!.validate())
                    {

                      SharedPreferences sp=await SharedPreferences.getInstance();
                      sp.setString('Email', Emailcon.text);
                      sp.setString('Password', PassCon.text);
                      sp.setString('Age', AgeCon.text);
                      sp.setString('userType', selectedSubject);
                      sp.setBool('isLogin', true);

                      String? User=sp.getString('userType');


                      if(User=='Student')
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            StudentScreen()));
                      }
                      else if(User=='Teacher')
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            TeacherScreen()));
                      }
                      else
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            AdminScreen()));
                      }
                    }
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.green,
                  child:Center(
                    child: Text("Sign Up"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
  Widget buildCheckboxItem(String label, bool value, void Function(bool) onChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (bool? newValue) {
            onChanged(newValue ?? false);
          },
        ),
        Text(label),
      ],
    );
  }
}


//Preference Function


// SharedPreferences sp=await SharedPreferences.getInstance();
// sp.setString('name', 'hussain');
// sp.setInt('age', 123);
// sp.setBool('isLogin', false);
//
// String? Name=sp.getString('name');
// int? Age=sp.getInt('age');
// bool? Bol=sp.getBool('isLogin');
// print(Name);
// print(Age);
// print(Bol);
//
// sp.remove('name');
// print(sp.getString('name'));