import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:home_expenses/provider_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';


class UpdateAndDeleteExpenses extends StatefulWidget {
  const UpdateAndDeleteExpenses({super.key});

  @override
  State<UpdateAndDeleteExpenses> createState() => _UpdateAndDeleteExpensesState();
}

class _UpdateAndDeleteExpensesState extends State<UpdateAndDeleteExpenses> {
  double byNametotalAmount = 0.0;
  final GlobalKey<FormState> UpdateExpenseKey=GlobalKey<FormState>();
  final TextEditingController SearchBYDateCon=TextEditingController();
  final FirebaseExpenseRef=FirebaseDatabase.instance.ref('ExpensesTable');
  final TextEditingController DialogField=TextEditingController();
  final TextEditingController searchByNameTotal=TextEditingController();

  DateTime selectedDate = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        // Use the date property to keep only the date part without the time component
        selectedDate = DateTime(picked.year, picked.month, picked.day);
        // Format the date using DateFormat
        SearchBYDateCon.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ProviderState providerState=Provider.of<ProviderState>(context,listen: true);
    byNametotalAmount = 0.0;
  //  providerState.setTotalIfNotMatch(0.0);
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(backgroundColor:Colors.teal,title: Text("Expensis List"),
       ),

      body: Column(
        children: [
          SizedBox(height: 10,),
                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: SearchBYDateCon,
                      onChanged: (String value) {
                        // Add your logic here if needed
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => selectDate(context),
                          icon: Icon(Icons.event),
                        ),
                        filled: true,
                        fillColor: Colors.white70,
                      ),
                    ),
                  ),

          SizedBox(height: 10,),
          Column(
            children: [
              Consumer<ProviderState>(builder: (context,value,child){
                return   Container(
                  height: 50,
                  width: 200,
                  child: Center(child: Text(value.finalAmount.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.black),)),
                );
              }),
            ],
          ), // Increased the width for better spacing

          SizedBox(height: 10,),
          Expanded(child: FirebaseAnimatedList(
              query: FirebaseExpenseRef,
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
                final method=snapshot.child('Method').value.toString();
                final ExAmount=snapshot.child('ExpenseAmount').value.toString();
                final ExDate=snapshot.child('Date').value.toString();
                final ExName=snapshot.child('EName').value.toString();
                if(SearchBYDateCon.text.isEmpty||SearchBYDateCon.text==null)
                {
                 //providerState.setTotalIfNotMatch(0.0);
                    //searchByNameTotal.text= '0.0';
                  return Column(
                    children: [
                      Card(
                        child: ListTile(
                          title: Text(snapshot.child('EName').value.toString(),style: TextStyle(fontSize: 16,fontFamily: 'Rubik Medium',)),
                          subtitle: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Method: '+snapshot.child('Method').value.toString(),style: TextStyle(fontSize: 16,fontFamily: 'Rubik Medium',)),
                              Text('Amount: '+snapshot.child('ExpenseAmount').value.toString(),style: TextStyle(fontSize: 16,fontFamily: 'Rubik Medium',)),
                              Text('Date: '+snapshot.child('Date').value.toString(),style: TextStyle(fontSize: 16,fontFamily: 'Rubik Medium',)),
                              // Add additional Text widgets for more subtitles if needed
                            ],
                          ),
                          trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert,color: Colors.blue,),
                            itemBuilder: (context)=>[
                              PopupMenuItem(
                                value:1,
                                child: ListTile(
                                  onTap: (){
                                    Navigator.pop(context);
                                    showMyDialog(providerState,method,ExAmount,snapshot.child('id').value.toString());
                                  },
                                  leading: Icon(Icons.edit,color: Colors.blue,),
                                  title: Text('Edit'),
                                ),),
                              PopupMenuItem(
                                value:1,
                                child: ListTile(
                                  onTap: (){
                                    if(method=='Cash in Wallet'){
                                      providerState.addInWallet(int.parse(snapshot.child('ExpenseAmount').value.toString()));
                                    }
                                    else
                                    {
                                      providerState.addInBank(int.parse(snapshot.child('ExpenseAmount').value.toString()));
                                    }
                                    FirebaseExpenseRef.child(snapshot.child('id').value.toString()).remove();
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
                else if(ExDate.contains(SearchBYDateCon.text))
                {
                    //byNametotalAmount += double.parse(ExAmount);
                  //providerState.setTotalIfNotMatch(0.0);
                  //searchByNameTotal.text=  "0.0";//byNametotalAmount.toString();
                  return Column(
                    children: [
                      Card(
                        child: ListTile(
                          title: Text(snapshot.child('EName').value.toString(),style: TextStyle(fontSize: 16,fontFamily: 'Rubik Medium',)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Method: '+snapshot.child('Method').value.toString(),style: TextStyle(fontSize: 16,fontFamily: 'Rubik Medium',)),
                              Text('Amount: '+snapshot.child('ExpenseAmount').value.toString(),style: TextStyle(fontSize: 16,fontFamily: 'Rubik Medium',)),
                              Text('Date: '+snapshot.child('Date').value.toString(),style: TextStyle(fontSize: 16,fontFamily: 'Rubik Medium',)),
                              // Add additional Text widgets for more subtitles if needed
                            ],
                          ),
                          trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert,color: Colors.blue,),
                            itemBuilder: (context)=>[
                              PopupMenuItem(
                                value:1,
                                child: ListTile(
                                  onTap: (){
                                    Navigator.pop(context);
                                    showMyDialog(providerState,method,ExAmount,snapshot.child('id').value.toString());
                                  },
                                  leading: Icon(Icons.edit,color: Colors.blue,),
                                  title: Text('Edit'),
                                ),),
                              PopupMenuItem(
                                value:1,
                                child: ListTile(
                                  onTap: (){
                                    if(method=='Cash in Wallet'){
                                      providerState.addInWallet(int.parse(snapshot.child('ExpenseAmount').value.toString()));
                                    }
                                    else
                                    {
                                      providerState.addInBank(int.parse(snapshot.child('ExpenseAmount').value.toString()));
                                    }
                                    FirebaseExpenseRef.child(snapshot.child('id').value.toString()).remove();
                                    Navigator.pop(context);
                                  },
                                  leading: Icon(Icons.delete_outline,color: Colors.red),
                                  title: Text('Delete'),
                                ),),
                            ],
                          ),
                        ),
                      ),
                      //Divider(height: 1,color: Colors.black,),
                    ],
                  );
                }
                else if(ExName?.toLowerCase()?.contains(SearchBYDateCon.text?.toLowerCase() ?? '') ?? false)
                {
                  byNametotalAmount+=double.parse(snapshot.child('ExpenseAmount').value.toString());
                  //print('The Value is $byNametotalAmount');
                  providerState.setTotalExpense(byNametotalAmount);
                  return Column(
                    children: [
                      Card(
                        child: ListTile(
                          title: Text(snapshot.child('EName').value.toString(),style: TextStyle(fontSize: 16,fontFamily: 'Rubik Medium',)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Method: '+snapshot.child('Method').value.toString(),style: TextStyle(fontSize: 16,fontFamily: 'Rubik Medium',)),
                              Text('Amount: '+snapshot.child('ExpenseAmount').value.toString(),style: TextStyle(fontSize: 16,fontFamily: 'Rubik Medium',)),
                              Text('Date: '+snapshot.child('Date').value.toString(),style: TextStyle(fontSize: 16,fontFamily: 'Rubik Medium',)),
                              // Add additional Text widgets for more subtitles if needed
                            ],
                          ),
                          trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert,color: Colors.blue,),
                            itemBuilder: (context)=>[
                              PopupMenuItem(
                                value:1,
                                child: ListTile(
                                  onTap: (){
                                    Navigator.pop(context);
                                    showMyDialog(providerState,method,ExAmount,snapshot.child('id').value.toString());
                                  },
                                  leading: Icon(Icons.edit,color: Colors.blue,),
                                  title: Text('Edit'),
                                ),),
                              PopupMenuItem(
                                value:1,
                                child: ListTile(
                                  onTap: (){
                                    if(method=='Cash in Wallet'){
                                      providerState.addInWallet(int.parse(snapshot.child('ExpenseAmount').value.toString()));
                                    }
                                    else
                                      {
                                        providerState.addInBank(int.parse(snapshot.child('ExpenseAmount').value.toString()));
                                      }
                                    FirebaseExpenseRef.child(snapshot.child('id').value.toString()).remove();
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
                  //providerState.setTotalIfNotMatch(0.0);
                  return Container();
                }
              }
          ),
          ),
        ],
      ),

    );
  }
  Future<void> showMyDialog(ProviderState providerState,method,String ExAmount,String id)async{

    DialogField.text=ExAmount;
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
            FirebaseExpenseRef.child(id).update({
              'ExpenseAmount':DialogField.text.toString()
            }).then((value){

              print('Successfully updated Data');

              if(method=='Cash in Wallet'){
                providerState.addInWallet(int.parse(ExAmount));
                print("The Expense Amount is:"+ExAmount);
                providerState.subtractInWallet(int.parse(DialogField.text.toString()));
                print(int.parse(DialogField.text.toString()));

              }
              else{
                providerState.addInBank(int.parse(ExAmount));
                print("The Expense Amount is:"+ExAmount);
                providerState.subtractInBank(int.parse(DialogField.text.toString()));
                print(int.parse(DialogField.text.toString()));
              }

            }).onError((error, stackTrace){
              print('There is a Error ');
            });
          },
              child: Text("Update")),
        ],
      );
    }
    );
  }
}
