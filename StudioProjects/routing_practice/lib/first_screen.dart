import 'package:flutter/material.dart';
import 'package:routing_practice/utils/routes_name.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,title: Text("First Page"),centerTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(onPressed:(){

              Navigator.pushNamed(context, RouteName.secondScreen,
              arguments: {
                'Node':'Js module',
                'Flutter':'Good for Apps'
              });

            }, child:Text("First Page"),
            ),
          )
        ],
      ),
    );
  }
}
