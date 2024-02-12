import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class UpdateAndDeleteItem extends StatefulWidget {
  const UpdateAndDeleteItem({super.key});

  @override
  State<UpdateAndDeleteItem> createState() => _UpdateAndDeleteItemState();
}

class _UpdateAndDeleteItemState extends State<UpdateAndDeleteItem> {
  @override
  final GlobalKey<FormState> UpdateItemKey= GlobalKey<FormState>();
  final TextEditingController SearchCon=TextEditingController();
  final TextEditingController DialogField=TextEditingController();
  final FirebaseRef=FirebaseDatabase.instance.ref('ItemsTable');
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(backgroundColor:Colors.teal,title: Text("Items List"),),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:Form(
              key: UpdateItemKey,
            child: TextFormField(
              controller: SearchCon,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                hintText: "Search Item",
                filled: true,
                fillColor: Colors.white70,
              ),
              onChanged: (String value){
                setState(() {

                });
              },
            ),
    ),
          ),
          SizedBox(height: 15,),
          Expanded(child: FirebaseAnimatedList(
            query: FirebaseRef,
              defaultChild: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          children: [
                            ListTile(
                              title: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ));
                  }),

            itemBuilder: (context,snapshot,animation,index)
            {
              final ItemsName=snapshot.child('ExpenseName').value.toString();
              if(SearchCon.text.isEmpty)
              {
                return Column(
                  children: [
                    Card(
                      child: ListTile(
                        title: Text(snapshot.child('ExpenseName').value.toString(),style: TextStyle(fontSize: 16,fontFamily: 'Rubik Medium',)),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert,color: Colors.blue,),
                        itemBuilder: (context)=>[
                          PopupMenuItem(
                            value:1,
                            child: ListTile(
                            onTap: (){
                              Navigator.pop(context);
                              showMyDialog(ItemsName,snapshot.child('id').value.toString());
                            },

                              leading: Icon(Icons.edit,color: Colors.black,),
                              title: Text('Edit'),
                          ),),
                          PopupMenuItem(
                            value:1,
                            child: ListTile(
                              onTap: (){
                                FirebaseRef.child(snapshot.child('id').value.toString()).remove();
                                Navigator.pop(context);
                              },
                              leading: Icon(Icons.delete_outline,color: Colors.red),
                              title: Text('Delete'),
                            ),),
                        ],
                      ),
                      ),
                    ),
                   // Divider(height: 1,color: Colors.black,),
                  ],
                );
              }
              else if(ItemsName.toLowerCase().contains(SearchCon.text.toLowerCase().toLowerCase()))
                {
                  return Column(
                    children: [
                      Card(
                        child: ListTile(
                          title: Text(snapshot.child('ExpenseName').value.toString(),style: TextStyle(fontSize: 16,fontFamily: 'Rubik Medium',)),
                          trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert,color: Colors.blue,),
                            itemBuilder: (context)=>[
                              PopupMenuItem(
                                value:1,
                                child: ListTile(
                                  onTap: (){
                                    Navigator.pop(context);
                                    showMyDialog(ItemsName,snapshot.child('id').value.toString());
                                  },
                                  leading: Icon(Icons.edit,color: Colors.blue,),
                                  title: Text('Edit'),
                                ),),
                              PopupMenuItem(
                                value:1,
                                child: ListTile(
                                  onTap: (){
                                    FirebaseRef.child(snapshot.child('id').value.toString()).remove();
                                    Navigator.pop(context);
                                  },
                                  leading: Icon(Icons.delete_outline,color: Colors.red),
                                  title: Text('Delete'),
                                ),),
                            ],
                          ),
                        ),
                      ),
                     // Divider(height: 1,color: Colors.black,),
                    ],
                  );
                }
              else
                {
                  return Container();
                }
            }
          ),
          ),
        ],
      ),
    );
  }
  Future<void> showMyDialog(String ItemsName,String id)async{
    DialogField.text=ItemsName;
    return showDialog(
        context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update'),
        content: Container(
          child: TextFormField(
            controller: DialogField,
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
            FirebaseRef.child(id).update({
              'ExpenseName':DialogField.text.toString()
            }).then((value){
              ScaffoldMessenger.of( UpdateItemKey.currentContext!).showSnackBar(
                const SnackBar(
                  content: Text('Updated Item Successfully'),
                ),
              );
            }).onError((error, stackTrace){
              ScaffoldMessenger.of( UpdateItemKey.currentContext!).showSnackBar(
                const SnackBar(
                  content: Text('Error'),
                ),
              );
            });
          },
              child: Text("Update")),
        ],
      );
    }
    );
  }
}
