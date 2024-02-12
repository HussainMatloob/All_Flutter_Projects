import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Tab(child:Icon(Icons.search,color: Colors.white,),),
            SizedBox(width: 10,),
            PopupMenuButton(
              icon: Icon(Icons.more_vert,color: Colors.white,),
                itemBuilder: (context)=>
                    [
                      PopupMenuItem(
                          child:Text("New Group")
                      ),
                      PopupMenuItem(
                          child:Text("Settings")
                      ),
                      PopupMenuItem(
                          child:Text("Logout")
                      ),
                    ]
            ),
            SizedBox(width: 10,),
          ],
          backgroundColor: Colors.teal,
          title: Text(
            "WhatsApp",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: false,
          bottom:TabBar(tabs:[
            Tab(child: Icon(Icons.camera_alt,color: Colors.white,),),
            Tab(child: Text("Chats",style: TextStyle(color: Colors.white),),),
            Tab(child:Text("Status",style: TextStyle(color: Colors.white),),),
            Tab(child:Text("Calls",style: TextStyle(color: Colors.white),),),

          ],
          ) ,
        ),
        body: TabBarView(children: [
          Text("Camera"),
          ListView.builder(
              itemCount: 50,
              itemBuilder:(context,index){
               return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=400"),
                  ),
                  title: Text("Hussain"),
                 subtitle: Text("Where is my Cat?"),
                 trailing: Text('5:30 PM'),
                );
              }),

          ListView.builder(
              itemCount: 50,
              itemBuilder:(context,index){

                if(index==0)
                  {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            child: Text("New Updates")
                        ),
                        ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green,width:3),
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=400"),
                            ),
                          ),
                          title: Text("Hussain"),
                          subtitle: Text("Today, 1:02 am"),

                        ),
                      ],
                    );
                  }

                else
                  {
                    if(index==1)
                      {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Viewed Updates"),
                            ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                  //border: Border.all(color: Colors.green,width:3),
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=400"),
                                ),
                              ),
                              title: Text("Hussain"),
                              subtitle: Text("Today, 1:02 am"),

                            ),
                          ],
                        );
                      }
                    else
                      {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                  //border: Border.all(color: Colors.green,width:3),
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=400"),
                                ),
                              ),
                              title: Text("Hussain"),
                              subtitle: Text("Today, 1:02 am"),

                            ),
                          ],
                        );
                      }
                  }

              }),

          ListView.builder(
              itemCount: 50,
              itemBuilder:(context,index){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=400"),
                  ),
                  title: Text("Hussain"),
                  subtitle: Text("8 December,6:21"),
                  trailing:index/2==0? Icon(Icons.call,color: Colors.green,):Icon(Icons.video_call,color: Colors.green,),
                );
              }),
        ],),
      ),
    );
  }
}
