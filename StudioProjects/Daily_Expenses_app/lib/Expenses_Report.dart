import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:home_expenses/Add_Expenses.dart';
import 'package:intl/intl.dart';
class ExpenseReport extends StatefulWidget {
  const ExpenseReport({super.key});

  @override
  State<ExpenseReport> createState() => _ExpenseReportState();
}

class _ExpenseReportState extends State<ExpenseReport> {
  double totalAmount = 0.0;
  double? finalAmount=0.0;
  final TextEditingController SearchBYDateCon=TextEditingController();
  final TextEditingController SearchByDateExpense=TextEditingController();
  final ExpenseRef=FirebaseDatabase.instance.ref('ExpensesTable');
  final GlobalKey<FormState> SDFormkey=GlobalKey<FormState>();
  @override
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(backgroundColor: Colors.teal,title: Text('Expenses Report'),centerTitle: true,),
      body: Form(
        key:SDFormkey,
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
         // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15,),
             Center(
               child: Container(
                 height: 150,
                 width: 150,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(100),
                   color: Colors.green,
                   image: DecorationImage(
                   image: AssetImage("images/Calculation.jpg"),
                     fit: BoxFit.cover,
                   ),
                   border: Border.all(
                     color: Colors.black,
                     width: 15,
                   ),
                 ),
               ),
             ),
           SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:TextFormField(
                controller: SearchBYDateCon,
                readOnly: true,
                onTap: () => selectDate(context),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),

                  suffixIcon: IconButton(
                    onPressed: () => selectDate(context),
                    icon: Icon(Icons.event),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  
                  hintText: 'Select Date',
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value){
                  if(value==null||value.trim().isEmpty)
                  {
                    return"Please must select Date";
                  }
                },
              ),

            ),
            SizedBox(height: 15,),

            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 60,
                width: 180,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(onPressed: ()
                  {
                    if(SDFormkey.currentState!.validate())
                    {
                      searchAndSum();
                    }

                  },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: Colors.blueGrey.withOpacity(1),
                    ),

                    child: Text('Search',style: TextStyle(
                        fontSize: 18,fontWeight: FontWeight.bold,
                        color: Colors.black),),),
                ),
              ),
            ),

            SizedBox(height: 5,),

            Column(
              children: [
                Container(
                  height: 50,
                  width: 300,
                  child: Center(child: Text(finalAmount.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.green),)),
                ),
              ],
            ),


            SizedBox(height: 20,),

            Stack(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            InkWell(
                              onTap:(){
                                generateDailyReport();
                                      },
                              child: Container(
                                height: 50,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(child: Text("Daily",style: TextStyle(
                                               fontSize: 18,fontWeight: FontWeight.bold,
                                              color: Colors.black),)),
                              ),
                            ),


                          ],
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              InkWell(
                                onTap:(){
                                  generateWeeklyReport();
                                },
                                child: Container(
                                  height: 50,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(child: Text("Weekly",style: TextStyle(
                                      fontSize: 18,fontWeight: FontWeight.bold,
                                      color: Colors.black),)),
                                ),
                              ),



                              InkWell(
                                onTap:(){
                                  generateMonthlyReport();
                                },
                                child: Container(
                                  height: 50,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(child: Text("Monthly",style: TextStyle(
                                      fontSize: 18,fontWeight: FontWeight.bold,
                                      color: Colors.black),)),
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 20,),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              InkWell(
                                onTap:(){
                                  generateYearlyReport();
                                },
                                child: Container(
                                  height: 50,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(child: Text("Yearly",style: TextStyle(
                                      fontSize: 18,fontWeight: FontWeight.bold,
                                      color: Colors.black),)),
                                ),
                              ),

                              InkWell(
                                onTap:(){
                                  generateFullReport();
                                },
                                child: Container(
                                  height: 50,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(child: Text("Full",style: TextStyle(
                                      fontSize: 18,fontWeight: FontWeight.bold,
                                      color: Colors.black),)),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  width: 410,
                  height: 370,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(170),
                      topRight: Radius.circular(170),
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> searchAndSum() async {
    totalAmount = 0.0;
    DatabaseEvent snapshotEvent = await ExpenseRef.once();
    DataSnapshot snapshot = snapshotEvent.snapshot;
    Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?;

    if (values != null) {
      values.forEach((key, expense) {
        final exAmount = expense['ExpenseAmount'].toString();
        final exDate = expense['Date'].toString();

        if (exDate.contains(SearchBYDateCon.text)) {
          totalAmount += double.parse(exAmount);
        }
      });

      // After iterating through the data, you can use the totalAmount variable
    }

    // SearchByDateExpense.text = totalAmount.toString();
    finalAmount=totalAmount;
    setState(() {

    });
  }

  Future<void> generateDailyReport() async {
    totalAmount = 0.0;
    DatabaseEvent snapshotEvent = await ExpenseRef.once();
    DataSnapshot snapshot = snapshotEvent.snapshot;
    Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?;

    if (values != null) {
      values.forEach((key, expense) {
        final exAmount = expense['ExpenseAmount'].toString();
        final exDate = expense['Date'].toString();

        // Check if the date is today
        if (isToday(exDate)) {
          totalAmount += double.parse(exAmount);
        }
      });

      // After iterating through the data, you can use the totalAmount variable
      //print('Total Expense Amount for Daily Report: $totalAmount');
    }
    // SearchByDateExpense.text = totalAmount.toString();
    finalAmount=totalAmount;
    setState(() {

    });
  }

  Future<void> generateWeeklyReport() async {
    totalAmount = 0.0;
    DatabaseEvent snapshotEvent = await ExpenseRef.once();
    DataSnapshot snapshot = snapshotEvent.snapshot;
    Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?;

    if (values != null) {
      values.forEach((key, expense) {
        final exAmount = expense['ExpenseAmount'].toString();
        final exDate = expense['Date'].toString();

        // Check if the date is within the last 7 days
        if (isWithinLastNDays(exDate, 7)) {
          totalAmount += double.parse(exAmount);
        }
      });

      // After iterating through the data, you can use the totalAmount variable
      //print('Total Expense Amount for Weekly Report: $totalAmount');
    }
    //SearchByDateExpense.text = totalAmount.toString();
    finalAmount=totalAmount;
    setState(() {

    });
  }

  Future<void> generateMonthlyReport() async {
    totalAmount = 0.0;
    DatabaseEvent snapshotEvent = await ExpenseRef.once();
    DataSnapshot snapshot = snapshotEvent.snapshot;
    Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?;

    if (values != null) {
      values.forEach((key, expense) {
        final exAmount = expense['ExpenseAmount'].toString();
        final exDate = expense['Date'].toString();

        // Check if the date is within the last 30 days
        if (isWithinLastNDays(exDate, 30)) {
          totalAmount += double.parse(exAmount);
        }
      });

      // After iterating through the data, you can use the totalAmount variable
      // print('Total Expense Amount for Monthly Report: $totalAmount');
    }
    //SearchByDateExpense.text = totalAmount.toString();
    finalAmount=totalAmount;
    setState(() {

    });
  }

  Future<void> generateYearlyReport() async {
    totalAmount = 0.0;
    DatabaseEvent snapshotEvent = await ExpenseRef.once();
    DataSnapshot snapshot = snapshotEvent.snapshot;
    Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?;

    if (values != null) {
      values.forEach((key, expense) {
        final exAmount = expense['ExpenseAmount'].toString();
        final exDate = expense['Date'].toString();

        // Check if the date is within the last 365 days
        if (isWithinLastNDays(exDate, 365)) {
          totalAmount += double.parse(exAmount);
        }
      });

      // After iterating through the data, you can use the totalAmount variable
      // print('Total Expense Amount for Yearly Report: $totalAmount');
    }
    // SearchByDateExpense.text = totalAmount.toString();
    finalAmount=totalAmount;
    setState(() {

    });
  }

  Future<void> generateFullReport() async {
    totalAmount = 0.0;
    DatabaseEvent snapshotEvent = await ExpenseRef.once();
    DataSnapshot snapshot = snapshotEvent.snapshot;
    Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?;

    if (values != null) {
      values.forEach((key, expense) {
        final exAmount = expense['ExpenseAmount'].toString();
        totalAmount += double.parse(exAmount);
      });

      // After iterating through the data, you can use the totalAmount variable
      // print('Total Expense Amount for Full Report: $totalAmount');
    }
    // SearchByDateExpense.text = totalAmount.toString();
    finalAmount=totalAmount;
    setState(() {

    });
  }

  bool isToday(String date) {
    DateTime currentDate = DateTime.now();
    DateTime expenseDate = DateFormat('yyyy-MM-dd').parse(date);
    return expenseDate.year == currentDate.year &&
        expenseDate.month == currentDate.month &&
        expenseDate.day == currentDate.day;
  }

  bool isWithinLastNDays(String date, int days) {
    DateTime currentDate = DateTime.now();
    DateTime expenseDate = DateFormat('yyyy-MM-dd').parse(date);
    DateTime startDate = currentDate.subtract(Duration(days: days));
    return expenseDate.isAfter(startDate) && expenseDate.isBefore(currentDate);
  }
}
