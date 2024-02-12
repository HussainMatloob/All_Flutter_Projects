import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_states_manage/provider/counter_provider.dart';


class CountExample extends StatefulWidget {
  const CountExample({super.key});
  @override
  State<CountExample> createState() => _CountExampleState();
}

class _CountExampleState extends State<CountExample> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final countProvider=Provider.of<CountProvider>(context,listen: false);
    Timer.periodic(Duration(seconds: 1), (timer) {
     // countProvider.getcount();
    });
  }

  @override
  Widget build(BuildContext context) {
  final countProvider=Provider.of<CountProvider>(context,listen: false);
  print("Build");
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.cyan,title: Text('Subscribe'),centerTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child:Consumer<CountProvider>(builder: (context,value,child){
            print("Only change");
           return Text(value.count.toString(),style: TextStyle(fontSize: 30),);
          },)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          countProvider.getcount();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
