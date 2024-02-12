import 'package:flutter/material.dart';

void main() {
  runApp(GuiClass());
}

class GuiClass extends StatefulWidget {
  const GuiClass({super.key});

  @override
  State<GuiClass> createState() => _GuiClassState();
}

class _GuiClassState extends State<GuiClass> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple.shade100,
          title: Text(
            "This is GUI Page",
            style: TextStyle(
                fontSize: 30,
                decoration: TextDecoration.underline,
                fontFamily: 'Pacifico',
                color: Colors.teal,
                fontWeight: FontWeight.w100),
          ),
          centerTitle: true,
        ),
        body: Center(
          //child: Image(image: NetworkImage('https://images.pexels.com/photos/792381/pexels-photo-792381.jpeg?auto=compress&cs=tinysrgb&w=400'),),
          child: Image(
            image: AssetImage('assets/Person2.jpg'),
          ),
        ),
      ),
    );
  }
}
