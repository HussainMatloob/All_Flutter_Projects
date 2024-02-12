import 'package:flutter/material.dart';
import 'package:routing_practice/utils/routes_name.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,title: Text("Third Page"),centerTitle: true,),
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Center(
             child: ElevatedButton(onPressed:(){

             }, child:Text("Third Page"),
             ),
           )
         ],
       ),
    );
  }
}
