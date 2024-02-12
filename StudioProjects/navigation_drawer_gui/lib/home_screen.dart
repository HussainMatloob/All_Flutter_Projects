import 'package:flutter/material.dart';
import 'package:navigation_drawer_gui/pageTwo.dart';
class HomeScreen extends StatefulWidget {
  static String id="home_page";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.purple,
        title: Text("First Page",),centerTitle: true,),
      drawer: Drawer(
         child: ListView(
           padding: EdgeInsets.zero,
           children: [
             //DrawerHeader(child: Text("Hussain")),
             UserAccountsDrawerHeader(
               decoration: BoxDecoration(
                 color: Color(0xff744abc)
               ),
               currentAccountPicture: CircleAvatar(
                 backgroundColor: Colors.green,
                 backgroundImage:NetworkImage("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=400"),
               ),
                 accountName: Text("hussain"),
                 accountEmail: Text("hussain@gmail.com")),
             ListTile(
               title:Text("Page1"),
               leading: Icon(Icons.home),
              // trailing: Text("6:30"),
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondPage()));
               },
             ),
             //Divider(height: 1,),
             ListTile(
               title:Text("Page2"),
               leading: Icon(Icons.calendar_month),
              // trailing: Text("6:30"),
             ),
             ListTile(
               title:Text("Logout"),
               leading: Icon(Icons.logout),
               // trailing: Text("6:30"),
             ),
            // Divider(height: 1,)
           ],
         ),
        ),
      body: Center(
        child: TextButton(
          onPressed: (){
              Navigator.pushNamed(context, SecondPage.id);
          },
          child: Text('FirstPage'),
        ),
      ),
    );
  }
}
