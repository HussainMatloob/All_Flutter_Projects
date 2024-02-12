import'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Random random=Random();
  int x = 0;
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            x=random.nextInt(10);
            print("Number is:$x");
            setState(() {

            });
          },
          child:const Icon(Icons.refresh),
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal,
          title: const Text(
            "Lottery App",
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text("Lottery wining number is:4")),
            SizedBox(height: 20,),
            Container(
              height:x==4 ?600:250,
              width: 250,
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:x==4?Colors.teal.withOpacity(0.3):Colors.grey.withOpacity(0.3),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child:x==4 ?Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     Icon(Icons.done_all,color: Colors.green,size: 35,),
                    SizedBox(height: 15,),
                    Text("Congratulation you have won the lottery,Your number is $x",
                    textAlign: TextAlign.center,),
                  ],
                ):Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.error,color: Colors.red,size: 35,),
                    SizedBox(height: 15,),
                    Text("Better Luck Next Time your number is $x \ntry again",
                      textAlign: TextAlign.center,),
                  ],
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
