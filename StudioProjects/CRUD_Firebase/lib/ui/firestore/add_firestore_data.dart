import 'package:flutter/material.dart';
import 'package:home_expense_app/utils/utils.dart';
import '../../widgets/round_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AddFirestoreDataScreen extends StatefulWidget {
  const AddFirestoreDataScreen({super.key});

  @override
  State<AddFirestoreDataScreen> createState() => _AddFirestoreDataScreenState();
}

class _AddFirestoreDataScreenState extends State<AddFirestoreDataScreen> {
  bool loading=false;
  final GlobalKey<FormState> fkey=GlobalKey<FormState>();
  final TextEditingController formCon=TextEditingController();
  final fireStore=FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Fire Store Data"),),
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
                    fireStore.doc(id).set({
                      'title': formCon.text.toString(),
                      'id':id,
                    }).then((value){
                      Utils().toastMessage("Data Added");
                      setState(() {
                        loading=false;
                      });
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                      setState(() {
                        loading=false;
                      });
                    });

                  })
            ],
          ),
        ),
      ),
    );
  }
}
