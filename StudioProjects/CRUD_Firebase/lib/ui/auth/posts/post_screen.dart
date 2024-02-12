import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:home_expense_app/ui/auth/posts/add_posts.dart';
import 'package:home_expense_app/utils/utils.dart';

import '../login_Screen.dart';
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth=FirebaseAuth.instance;
  final ref=FirebaseDatabase.instance.ref('Post');
  final TextEditingController searchCon=TextEditingController();
  final TextEditingController EditCon=TextEditingController();

  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('This is Post Screen'),
      centerTitle: true,
      actions: [
        IconButton(onPressed: (){
          auth.signOut().then((value)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
          }).onError((error, stackTrace){
            Utils().toastMessage(error.toString());
          });
        }, icon: Icon(Icons.insert_drive_file),color: Colors.green,),
        SizedBox(width: 10,)
      ],),

      body: Column(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: searchCon,
              decoration: InputDecoration(
                hintText: 'search',
                    border: OutlineInputBorder(),
              ),
              onChanged: (String value){
                setState(() {

                });
              },
            ),
          ),

         Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: Text('Loading'),
                itemBuilder:(context,snapshot,animation,index){
                  final Title=snapshot.child('title').value.toString();
                  if(searchCon.text.isEmpty){
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context)=>[
                          PopupMenuItem(
                            value: 1,
                          child:ListTile(
                            onTap: (){
                              Navigator.pop(context);
                              showMyDialog(Title,snapshot.child('id').value.toString());
                            },
                            leading: Icon(Icons.edit,color: Colors.blue),
                            title: Text('Edit'),

                          )),
                          PopupMenuItem(
                              value: 1,
                              child:ListTile(
                                onTap: (){
                                  Navigator.pop(context);
                                  ref.child(snapshot.child('id').value.toString()).remove();
                                },
                                leading: Icon(Icons.delete_outline,color: Colors.red),
                                title: Text('Delete'),

                              ))
                        ],
                      ),
                    );
                  }
                  else if(Title.toLowerCase().contains(searchCon.text.toLowerCase().toLowerCase())){
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                    );
                  }
                  else{
                    return Container();
                  }

            }
            ),
          ),


        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>
          AddPostScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Future<void> showMyDialog(String Title,String id)async{
    EditCon.text=Title;
    return showDialog(
        context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update'),
        content: Container(
          child: TextField(
            controller: EditCon,
            decoration: InputDecoration(
              hintText: 'Edit'
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          },
              child: Text("Cancel")),
          TextButton(onPressed: (){
            Navigator.pop(context);
            ref.child(id).update({
              'title':EditCon.text.toString()
            }).then((value){
              Utils().toastMessage("Updated Successfully");
            }).onError((error, stackTrace){
              Utils().toastMessage(error.toString());
            });
          },
              child: Text("Update")),
        ],
      );
    }
    );
  }
}


/**  Expanded(
    child: StreamBuilder(
    stream:ref.onValue,
    builder: (context,AsyncSnapshot<DatabaseEvent>snapshot){

    if(!snapshot.hasData){
    return CircularProgressIndicator();
    }
    else
    {
    Map<dynamic,dynamic> map =snapshot.data!.snapshot.value as dynamic;
    List<dynamic> list=[];
    list.clear();
    list=map.values.toList();
    return ListView.builder(
    itemCount: snapshot.data!.snapshot.children.length,
    itemBuilder:(context,index){
    return ListTile(
    //tileColor: Colors.green,
    title: Text(list[index]['title']),
    );
    });
    }
    },
    )),**/