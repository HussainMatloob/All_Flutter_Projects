import 'package:flutter/material.dart';
import 'package:navigation_drawer_gui/home_screen.dart';
class SecondPage extends StatefulWidget {
  static String id='second_page';
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,title: Text("Second page"),),
         body: ListView.builder(
           itemCount: 50,
             itemBuilder: (context,index){
             //return Text("I how are you");
              return ListTile(
                 title:Text("Hussain Matloob"),
                 leading:CircleAvatar(
                   backgroundImage: NetworkImage("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=400"),
                 ),
                 // trailing: Text("6:30"),
               );
             }
         ),
    );
  }
}
