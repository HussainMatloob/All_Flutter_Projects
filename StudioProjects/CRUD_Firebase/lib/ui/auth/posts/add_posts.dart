import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:home_expense_app/widgets/round_button.dart';

import '../../../utils/utils.dart';
class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool loading=false;
  final GlobalKey<FormState> fkey=GlobalKey<FormState>();
  final TextEditingController formCon=TextEditingController();
  final databaseRef=FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Post"),),
      body:Form(
        key: fkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextFormField(
              controller: formCon,
              maxLines: 4,
            decoration: InputDecoration(
              hintText: ("Item Name"),
              border: OutlineInputBorder(),
            ),
              validator: (value)
              {
                if(value==null||value.trim().isEmpty)
                {
                  return "Must fill Field";
                }
              }
            ),
            SizedBox(height: 30,),
            RoundButton(title: 'Add',loading: loading
                , onTap:(){
              setState(() {
                loading=true;
              });
              String id=DateTime.now().millisecondsSinceEpoch.toString();
            databaseRef.child(id).set({
              'title':formCon.text.toString(),
              'id':id
            }).then((value){
              Utils().toastMessage('Post Add');
              setState(() {
                loading=false;
              });
            }).onError((error, stackTrace){
              setState(() {
                loading=false;
              });
              Utils().toastMessage(error.toString());
            });
            })
          ],
        ),
      ),
    ),
    );
  }
}
