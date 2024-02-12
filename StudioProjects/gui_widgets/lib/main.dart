import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: RichText(text: TextSpan(
                text: "Dont have an account?",
                style: Theme.of(context).textTheme.bodyText1,
                children: [
                  TextSpan(text: 'Login',style: TextStyle(fontSize:20,
                      fontWeight:FontWeight.bold,color: Colors.red,
                  decoration: TextDecoration.underline)),
                  //TextSpan(text: ' world1',style: TextStyle(fontWeight:FontWeight.normal,
                    //  color: Colors.green,fontSize: 30))
                ]
              )),
            ),
          ],
        ),
      ),
    );
  }
}


/**class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  color: Colors.red,
                ),
                Positioned(
                  top: 1,
                  child: Container(
                    width: 130,
                    height: 130,
                    color: Colors.purple,
                  ),
                ),
                 Positioned(
                   top: 0,
                   child: Text("This is wrap widget"),
                 ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}**/

/**class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Center(
                    child: Container(
                      height: 250,
                      // transform: Matrix4.rotationZ(0.1),
                      decoration: BoxDecoration(

                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10
                          //topRight: Radius.circular(50),
                          //bottomLeft: Radius.circular(50),
                          //bottomRight: Radius.circular(20),
                          //topLeft: Radius.circular(20),
                        ),
                        //border:Border.all(
                        //color: Colors.red,
                        // width: 3
                        //),
                        boxShadow:[
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 100,
                          ),
                        ],
                      ),
                      child:Center(
                          child:Text("Log In",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Center(
                    child: Container(

                      height: 250,
                      // transform: Matrix4.rotationZ(0.1),
                      decoration: BoxDecoration(

                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10
                          //topRight: Radius.circular(50),
                          //bottomLeft: Radius.circular(50),
                          //bottomRight: Radius.circular(20),
                          //topLeft: Radius.circular(20),
                        ),
                        //border:Border.all(
                        //color: Colors.red,
                        // width: 3
                        //),
                        boxShadow:[
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 100,
                          ),
                        ],
                      ),
                      child:Center(
                          child:Text("Log In",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),)),
                    ),

                  ),
                ),
                Center(
                  child: Container(

                    height: 250,
                    // transform: Matrix4.rotationZ(0.1),
                    decoration: BoxDecoration(

                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10
                        //topRight: Radius.circular(50),
                        //bottomLeft: Radius.circular(50),
                        //bottomRight: Radius.circular(20),
                        //topLeft: Radius.circular(20),
                      ),
                      //border:Border.all(
                      //color: Colors.red,
                      // width: 3
                      //),
                      boxShadow:[
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 100,
                        ),
                      ],
                    ),
                    child:Center(
                        child:Text("Log In",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),)),
                  ),

                ),
              ],
            ),
            Center(
              child: Container(
                width: 200,
                height: 250,
               // transform: Matrix4.rotationZ(0.1),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage('https://images.pexels.com/photos/863963/pexels-photo-863963.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                  ),
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10
                    //topRight: Radius.circular(50),
                    //bottomLeft: Radius.circular(50),
                    //bottomRight: Radius.circular(20),
                    //topLeft: Radius.circular(20),
                  ),
                  //border:Border.all(
                    //color: Colors.red,
                   // width: 3
                  //),
                  boxShadow:[
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 100,
                    ),
                  ],
                ),
                child:Center(
                    child:Text("Log In",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
**/
