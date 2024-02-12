import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_expenses/Add_Expenses.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class SpleshScreen extends StatefulWidget {
  const SpleshScreen({super.key});
  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> with TickerProviderStateMixin{
  @override

  late final AnimationController _controller =
  AnimationController(duration: const Duration(seconds:1), vsync: this)
    ..repeat();

  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),(){
     Navigator.push(context, MaterialPageRoute(builder: (context)=>AddExpenses()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
     body:Expanded(
    flex: 1,
    child: Center(
    child: SpinKitCubeGrid(
    color: Colors.deepPurpleAccent,
    size: 100,
    controller: _controller,
    ),
    )),
    );
  }
}
