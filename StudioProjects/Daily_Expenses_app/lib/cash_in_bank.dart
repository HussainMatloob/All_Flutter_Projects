import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_expenses/provider_state.dart';
import 'package:provider/provider.dart';

class CashInBank extends StatefulWidget {
  const CashInBank({super.key});

  @override
  State<CashInBank> createState() => _CashInBankState();
}

class _CashInBankState extends State<CashInBank> {
  TextEditingController bankCashCon = TextEditingController();
  TextEditingController DialogField= TextEditingController();
  GlobalKey<FormState> Keyform = GlobalKey<FormState>();
  GlobalKey<FormState> DialogKeyForm = GlobalKey<FormState>();


  @override
  String? BankValidate(value) {
    if (value.trim().isEmpty) {
      return 'Please must fill field';
    }
    bool nameReg = RegExp(r'^[0-9]*$').hasMatch(value);
    if (nameReg == false) {
      return 'Only accepted digits';
    }
    return null;
  }

  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderState>(context);
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Cash in Bank",
        ),
        centerTitle: true,
      ),
      body: Form(
        key: Keyform,
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height: 50,),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: bankCashCon,
                          decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 2.0),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 2.0),
                            ),
                            hintText: 'Enter bank cash',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          validator: BankValidate,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 100),
                              child: Container(
                                height: 70,
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.circular(10)),

                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                     // SizedBox(width: 15,),
                                      InkWell(
                                          onTap:(){
                                            if (Keyform.currentState!.validate()) {
                                              provider.addInBank(int.parse(bankCashCon.text.toString()));
                                            }
                                          },
                                          child: Icon(Icons.add,color: Colors.white,)),
                                     Text('|',style: TextStyle(fontSize: 50,color: Colors.white),),
                                     // SizedBox(width: 100,),
                                      InkWell(
                                          onTap: (){
                                            if (Keyform.currentState!.validate()) {
                                              provider.subtractInBank(int.parse(bankCashCon.text.toString()));
                                            }
                                          },
                                          child: Icon(Icons.remove,color: Colors.white,)),
                                    ],
                                  ),
                                ),
                              ),
                          ),

                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: InkWell(
                            onTap: (){
                              showDialog(
                                  context: context, builder: (BuildContext context) {
                                return Form(
                                  key: DialogKeyForm,
                                  child: AlertDialog(
                                    title: Text('Cash Move to Wallet'),
                                    content: IntrinsicHeight(
                                      child: Container(
                                        child: Column(
                                          children: [
                                             TextFormField(
                                               autovalidateMode: AutovalidateMode.onUserInteraction,
                                              controller: DialogField,
                                              decoration: InputDecoration(
                                                  hintText: 'Enter Amount'
                                              ),
                                               validator: BankValidate
                                            ),
                                            SizedBox(height: 20,),
                                            GestureDetector(
                                              onTap:(){
                                                if (DialogKeyForm.currentState!.validate()){
                                                  provider.addInWallet(int.parse(DialogField.text.toString()));
                                                  provider.subtractInBank(int.parse(DialogField.text.toString()));

                                                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Center(child: Text("Transaction Successfully",style: TextStyle(color: Colors.black))),
                                                      duration: Duration(seconds: 2),
                                                      backgroundColor: Colors.white,
                                                      elevation: 5,
                                                      behavior: SnackBarBehavior.floating,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                    ),
                                                  );

                                                }
                                              },
                                              child: Container(
                                                height: 60,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.blueGrey,
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Icon(Icons.account_balance_outlined,color: Colors.indigo,),
                                                      Icon(Icons.arrow_forward_rounded,color: Colors.black,),
                                                      Icon(Icons.account_balance_wallet,color: Colors.brown,),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                      ),
                                    ),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      },
                                          child: Text("Cancel")),
                                    ],
                                  ),
                                );
                              }
                              );
                            },
                            child: Container(
                              child: Consumer<ProviderState>(
                                builder: (context, value, child) {
                                  return Center(
                                      child: Text(value.getTotalInBank().toString(),
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontFamily: 'Rubik Medium',
                                        color: Colors.yellow),
                                  ));
                                },
                              ),

                              height: 250,
                              width: 200,
                              //transform: Matrix4.rotationZ(0.1),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                  topLeft: Radius.circular(50),
                                ),
                                border: Border.all(color: Colors.white70, width: 5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                      ],
                    ),
                  ),
                ),

                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('images/bankImage.jpg'),
                    ),
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
