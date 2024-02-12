//import 'dart:js';
/**void main() {

   runApp(MaterialApp(
      //home :MyApp(),
    initialRoute:'/',
    routes: {
      '/':(context) => MyApp(),
      //'/second':(context) =>  NextPageClass(),
      '/Third':(context) => NextClass(),

    },
  ),
  );
}**/

/**
class MyApp extends StatelessWidget
{
  Widget build(BuildContext context)
  {
      return MaterialApp(
        home: MyHomePage(),
      );
  }
}

    //For ListView
class MyHomePage extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar:AppBar(backgroundColor:Colors.green,
        title:Text("this is my first flutter app"
           ),
      ),

        body:ListView(
        children: [
          ListTile(
          leading:Icon(Icons.star,
              color:Colors.red),
         title:Text("First Tile"),
        subtitle:Text("this is subtitle"),
      ),
          ListTile(
            leading:Icon(Icons.star, color:Colors.green),
            title:Text("Second Title"),
            subtitle:Text("Second subtitle"),
          ),
          ListTile(
            leading:Icon(Icons.star, color:Colors.blue),
            title:Text("Third Title"),
            subtitle:Text("Third Subtitle"),
          ),
          ListTile(
            leading:Icon(Icons.star,
                color:Colors.red),
            title:Text("Fourth Tile"),
            subtitle:Text("this is subtitle"),
          ),
          ListTile(
            leading:Icon(Icons.star, color:Colors.green),
            title:Text("Five Title"),
            subtitle:Text("Five subtitle"),
          ),
          ListTile(
            leading:Icon(Icons.star, color:Colors.blue),
            title:Text("Six Title"),
            subtitle:Text("Six Subtitle"),
          ),
          ListTile(
            leading:Icon(Icons.star,
                color:Colors.red),
            title:Text("Eight Tile"),
            subtitle:Text("this is subtitle"),
          ),
          ListTile(
            leading:Icon(Icons.star, color:Colors.green),
            title:Text("Nine Title"),
            subtitle:Text("this is subtitle"),
          ),
          ListTile(
            leading:Icon(Icons.star, color:Colors.blue),
            title:Text("Ten Title"),
            subtitle:Text("this is subtitle"),
          ),
          ListTile(
            leading:Icon(Icons.star,
                color:Colors.red),
            title:Text("Eleven Tile"),
            subtitle:Text("this is subtitle"),
          ),
          ListTile(
            leading:Icon(Icons.star, color:Colors.green),
            title:Text("Tewel Title"),
            subtitle:Text("this is subtitle"),
          ),
          ListTile(
            leading:Icon(Icons.star, color:Colors.blue),
            title:Text("Thirteen Title"),
            subtitle:Text("this is subtitle"),
          )
      ],
    ),
    );
  }
}
**/

/**
class MyApp extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

//For Column and Row

class MyHomePage extends StatelessWidget {
  Widget build(BuildContext context) {

    return Scaffold
    (
     appBar:AppBar(backgroundColor:Colors.red,title:Text("This is app bar for row"),),
    body:Container(
      child:Center(
     child:Row(
     //child:Column(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       crossAxisAlignment: CrossAxisAlignment.center,
       children:[
          Container(
            width:115,
            height:100,
            color:Colors.red,
          ),
         /**Expanded(
         child:Container(
           width:115,
           height:100,
           color:Colors.blue,
         ),
         ),**/
         Container(
           width:115,
           height:100,
           color:Colors.blue,
         ),
         Container(
           width:115,
           height:100,
           color:Colors.green,
         ),
       ],
     ),
    ),
    ),
    );
  }
}
**/

 //For Elevated Button

/**
class MyApp extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home:Scaffold(
      appBar: AppBar(backgroundColor:Colors.green,title:Text("This code for responsive button")),
        body:Container(
          child:Center(
          child:ElevatedButton(
            onPressed: ()
            {

            },
            child: Text('Click me'),
          ),
        ),
        ),
    ),
    );
  }
}
 **/

//For CircileAvatar

/**
class MyApp extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(backgroundColor: Colors.blue,title: Text('this is CircularAvatar')),
        body:Container(
          child:CircleAvatar(
            radius: 50,
            backgroundColor: Colors.green,
            child:Icon(
                Icons.person,
                size: 80
            ),

          ),
        ),
      ),
    );
  }
}
**/

//For Drawer
/**
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return MaterialApp(
    home:Scaffold(
      appBar:AppBar(backgroundColor:Colors.red,title:Text("This is drawer"),),
    drawer: Drawer(
    child:ListView(
      children: [
       UserAccountsDrawerHeader(
         currentAccountPicture:CircleAvatar(
           radius:50,
           //child: Icon(Icons.person,size:60),
           backgroundImage:AssetImage("assets/Person2.jpg"),
         ),
         accountName: Text("Hussain Matloob"),
         accountEmail:Text("hussainatloob98012@gmail.com"),
       ),
        ListTile(

          leading: Icon(Icons.person,size:50,color:Colors.green),
          title: Text("Nabeel"),
          onTap:(){
           // Navigator.pushNamed(context,'/Third');
          },
        ),
        Divider(  // This is the separator widget
          height: 1,
          color: Colors.black,
        ),
        ListTile(
          leading:Icon(Icons.person,size:50,color:Colors.green),
          title:Text("Hussain"),
          onTap:(){},
        ),
        Divider(  // This is the separator widget
          height: 1,
          color: Colors.black,
        ),
      ],
    ),
    ),
    ),
    );
  }
}
**/

//For route or navigations

/**
class MyApp extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return Scaffold(
    appBar: AppBar(backgroundColor:Colors.pink,title:Text("This is Navigation app")),
          body:Container(
            child: Center(
            child: ElevatedButton(
              onPressed: ()
              {
                Navigator.pushNamed(context, '/second');
              },
              child: Text("click me"),
            ),
            ),
          ),
        );
  }
}
class NextPageClass extends StatelessWidget
{
  Widget build(BuildContext context)
  {
      return Scaffold(
      appBar:AppBar(backgroundColor: Colors.green,title: Text("This is a second page"),),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          ElevatedButton(
          onPressed: ()
          {
          Navigator.pop(context);
          },
          child: Text("Click to back"),
          ),
          ElevatedButton(
            onPressed: ()
            {
              Navigator.pushNamed(context,'/Third');
            },
            child: Text("Click to next"),
          ),
        ],
      ),
    );

  }
}


class NextClass extends StatelessWidget
{
Widget build(BuildContext context)
{
  return Scaffold(
    appBar:AppBar(backgroundColor: Colors.green,title: Text("This is a third Page"),),
    body: Container(
      child: Center(
        child: ElevatedButton(
          onPressed: ()
          {
            Navigator.pop(context);
          },
          child: Text("Third Back"),
        ),
      ),
    ),

  );

}
}**/

//For GridView>builder

/**
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Gridcass(),
    );
  }
}

 class Gridcass extends StatelessWidget
 {
   Widget build(BuildContext context)
   {
     return MaterialApp(
       home:Scaffold(
       appBar: AppBar(backgroundColor: Colors.yellow,title: Text("This is grid view calss"),),
       body: GridView.builder(
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
           ),
         itemCount: 10,
         itemBuilder: (BuildContext context,int index){
         return Card(
           color: Colors.red,
          child: Center(
            child: Text('Item $index'),
          ),
        );
         },
       ),
       ),
     );
   }
 }**/

//For GridView.count
/**
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(backgroundColor: Colors.green,title: Text("This is grid view calss"),),
        body: GridView.count(
          crossAxisCount: 3,
          children: List.generate(9, (index){
            return Card(
              color:Colors.blue,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
                child: ClipRRect(borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset('assets/Person1.jpg',
              fit: BoxFit.cover,),
            ),
            );

          } ),
        ),
      ),
    );
  }
}
**/

//Make Grids Manaully

/**
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(backgroundColor: Colors.green,title: Text("This is grid view calss"),
        ),
        body: GridView.count(
          crossAxisCount: 3,
          children: [
            Card(
              color: Colors.green,

            ),
            Card(
              color: Colors.blue,
              child: Image.asset('assets/Person1.jpg',fit: BoxFit.cover,),
            ),
            Card(
              color: Colors.yellow,
            ),
            Card(
              color: Colors.green,
            ),
            Card(
              color: Colors.blue,
            ),
            Card(
              color: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}
 **/

//ListView.builder
/**
void main() {
  runApp(ListBuilderclass ());
}
class ListBuilderclass extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.cyan,
          title:Text("This is a ListViewBuilder"),),
        body: ListView.builder(
            itemCount: 7,
              itemBuilder:(context, index){
              return Column(
                children: [
                 ListTile(
                title: Text("Hussain"),
                   leading: Icon(Icons.person,size: 30,color: Colors.green,),
                ),
                  Divider(
                   height: 1,
                    color: Colors.black,
                  ),
                ],
                );
              },
        ),
      ),
    );
  }
}
**/

//Floating Button Pius Drawer

/**
void main(){
  runApp(FloatButton());

}
class FloatButton extends StatefulWidget
{
  FloatingButton createState() => FloatingButton();
}
class FloatingButton extends State<FloatButton>
{
  int a=0;
  Widget build(BuildContext context)
  {
return MaterialApp(
  home: Scaffold(
    appBar: AppBar(backgroundColor: Colors.green,title: Text("This is floating button"),),
    drawer: Drawer(
      child:ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture:CircleAvatar(
              radius:50,
              //child: Icon(Icons.person,size:60),
              backgroundImage:AssetImage("assets/Person1.jpg"),
            ),
            accountName: Text("Hussain Matloob"),
            accountEmail:Text("hussainatloob98012@gmail.com"),
          ),
          ListTile(

            leading: Icon(Icons.person,size:50,color:Colors.green),
            title: Text("Nabeel"),
            onTap:(){
              // Navigator.pushNamed(context,'/Third');
            },
          ),
          Divider(  // This is the separator widget
            height: 1,
            color: Colors.black,
          ),
          ListTile(
            leading:Icon(Icons.person,size:50,color:Colors.green),
            title:Text("Hussain"),
            onTap:(){},
          ),
          Divider(  // This is the separator widget
            height: 1,
            color: Colors.black,
          ),
        ],
      ),
    ),
    body: Center(
      child: Text("This is Center Text:$a"),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        setState(() {
          a=a+1;
        });
      },
      child: Icon(Icons.add),
    ),
  ),
);
  }
}
**/

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_expenses/Splesh_screen.dart';
import 'package:home_expenses/provider_state.dart';
import 'package:provider/provider.dart';

void main()  async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> ProviderState(),
      child: Builder(builder: (BuildContext context){
        return MaterialApp(
          title: 'Flutter',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SpleshScreen(),
        );
      }),
    );
    return SpleshScreen();
  }
}
