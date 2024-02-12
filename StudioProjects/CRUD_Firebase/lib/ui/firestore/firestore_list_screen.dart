import 'package:cloud_firestore/cloud_firestore.dart';
import'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_expense_app/ui/firestore/add_firestore_data.dart';
import 'package:home_expense_app/utils/utils.dart';
import '../auth/login_Screen.dart';
class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth=FirebaseAuth.instance;

  final TextEditingController EditCon=TextEditingController();
  final fireStore=FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference ref=FirebaseFirestore.instance.collection('users');
  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('This is FireStore Screen'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value)
            {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            }).onError((error, stackTrace){
              Utils().toastMessage(error.toString());
            });
          }, icon: Icon(Icons.logout_outlined),),
          SizedBox(width: 10,)
        ],),

      body: Column(
        children: [
          SizedBox(height: 10,),
      StreamBuilder<QuerySnapshot>(
        stream: fireStore,
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
        {
          if(snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          if(snapshot.hasError)
            {
              return Text("Some Error");
            }
          return  Expanded(
            child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index)
                {
                  return ListTile(
                    onTap:() {
                      //ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                       // 'title':"Update it",
                     // }).then((value){






















































                    //    Utils().toastMessage("Updated");
                    //  }).onError((error, stackTrace){
                      //  Utils().toastMessage(error.toString());
                    //  });
                      ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                    },
                    title: Text(snapshot.data!.docs[index]['title'].toString()),
                  );
                }),
          );
        }
      ),

        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>
              AddFirestoreDataScreen()));
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

          },
              child: Text("Update")),
        ],
      );
    }
    );
  }
  }