import 'package:flutter/material.dart';
import 'package:multirolebase_app/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  String? Email;
  String? Name;
  String? Age;
  String? userType;

  @override
  void initState() {
    super.initState();
    loadData();
  }
  @override

  void loadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    Email = sp.getString('Email');
    Name = sp.getString('Password');
    Age = sp.getString('Age');
    userType = sp.getString('userType');
    setState(() {
    });
  }

  void Logout()
  async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    sp.clear();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>
        LoginScreen()));
  }
  Widget build(BuildContext context) {


    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.cyan,title: Text("StudentScreen"),
        centerTitle: true,
        actions: [
          InkWell(
              onTap: ()
              {
                Logout();
              },
              child: Container(child:Icon(Icons.logout,),)),

          SizedBox(width: 20,),
        ],
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Email: $Email'),
          ),
          ListTile(
            title: Text('Password: $Name'),
          ),
          ListTile(
            title: Text('Age: $Age'),
          ),
          ListTile(
            title: Text('UserType: $userType'),
          ),
        ],
      ),
    );
  }
}
