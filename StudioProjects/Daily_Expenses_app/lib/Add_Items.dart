import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Add_Items.dart';
import 'Update_And_Delete_Item.dart';
import 'main.dart';

class FormPage extends StatefulWidget
{

  State<FormPage> createState()=>ChildFormPage();
}
class ChildFormPage extends State<FormPage>
{


  TextEditingController addItemCon=TextEditingController();
  final GlobalKey<FormState> addItemKey= GlobalKey<FormState>();
  final databaseAddItem=FirebaseDatabase.instance.ref('ItemsTable');
  //TextEditingController addDate=TextEditingController();

  /**final DateTime currentDate = DateTime.now();
      final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      late String date;
      // Constructor for ChildFormPage
      ChildFormPage()
      {
      date = dateFormat.format(currentDate);
      addDate.text=date;
      }**/


  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        title: Text("Add Items",style: TextStyle(fontSize: 20,fontFamily: 'Rubik Medium',)),
        centerTitle: true,),

      body: Container(
        child:Form(
          key:addItemKey,
          child: ListView(
            children: [
              SizedBox(height: 70,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 21,),
                          Text(
                            "Daily",textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Rubik Medium',
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Text(
                        "Expenses",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Rubik Medium',
                            color: Colors.blue),
                      ),
                    ],
                  )
                ],
              ),

              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
                    child: Card(
                      color: Colors.white,
                      elevation: 80,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(33.0), // Adjust the border radius as needed
                        side: BorderSide(
                          color: Colors.white70, // Adjust the border color as needed
                          width: 8.0,           // Adjust the border width as needed
                        ),
                      ),
                      child:Column(
                        children: [
                          SizedBox(height: 80,),
                    TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: addItemCon,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2.0),
                          ),
                          hintText: 'Enter Item Name',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                              style: TextStyle(fontWeight: FontWeight.bold,),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty)
                                {
                                  return 'Please must fill field';
                                }
                              }
                          ),

                    SizedBox(height: 50,),

                    InkWell(
                      onTap: (){
                        if(addItemKey.currentState!.validate())
                        {
                          {
                            String id=DateTime.now().millisecondsSinceEpoch.toString();
                            databaseAddItem.child(id).set({
                              'ExpenseName':addItemCon.text.toString(),
                              'id':id
                            }).then((value){
                              ScaffoldMessenger.of(context).removeCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Center(child: Text("Add Item Successfully",style: TextStyle(color: Colors.black))),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.white,
                                  elevation: 5,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            }).onError((error, stackTrace){
                              ScaffoldMessenger.of(addItemKey.currentContext!).showSnackBar(
                                const SnackBar(
                                  content: Text('Network Error'),
                                ),
                              );
                            });
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: Container(
                          height: 70,
                          width: 300,
                          decoration:BoxDecoration(
                              color:Colors.indigo,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: const Center(
                            child: Text(
                              'Add',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'Rubik Regular'),
                            ),
                          ),
                        ),
                      ),
                    ),
                          SizedBox(height: 50,),
                              ],
                              ),
                          ),
                  ),
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('images/ExpenseImage.png'),
                      ),
                    )
                ],
                ),
              ),
             ]
          ),
        ),
      ),
    );
  }
}
