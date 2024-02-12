import 'package:flutter/material.dart';
import 'package:routing_practice/utils/routes_name.dart';

class SecondPage extends StatefulWidget {
  dynamic data;
  SecondPage({super.key,required this.data});
  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,title: Text(widget.data['Flutter']),centerTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(onPressed:(){
              Navigator.pushNamed(context, RouteName.thirdScreen);
            }, child:Text("Second Page"),
            ),
          )
        ],
      ),
    );
  }
}
