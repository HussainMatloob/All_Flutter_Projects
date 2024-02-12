import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:home_expenses/Add_Expenses.dart';
import 'package:intl/intl.dart';
class ExpensesReport extends StatefulWidget {
  const ExpensesReport({super.key});

  @override
  State<ExpensesReport> createState() => _ExpensesReportState();
}

class _ExpensesReportState extends State<ExpensesReport> {
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        title: Text("Expenses Report"),
        centerTitle: true,),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle the back button action
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
          AddExpenses()));
        },
        tooltip: 'Back',
        child: Icon(Icons.arrow_back),
      ),
      body:Form(
        key:SDFormkey,
        child:ListView(
        children: [
        SizedBox(height: 10,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
          child:TextFormField(
          controller: SearchBYDateCon,
          readOnly: true,
          onTap: () => selectDate(context),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black),
            hintText: 'Select Date',
            suffixIcon: IconButton(
              onPressed: () => selectDate(context),
              icon: Icon(Icons.event),
            ),
            filled: true,
            fillColor: Colors.blueGrey,
          ),
            validator: (value){
            if(value==null||value.trim().isEmpty)
              {
                return"Please must select Date";
              }
            },
        ),

      ),
          SizedBox(height: 20,),
          Column(
            children: [
              Container(
                height: 50,
                width: 200,
                child: Center(child: Text(finalAmount.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.green),)),
              ),
            ],
          ),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: TextFormField(
          //     enabled: false,
          //     controller: SearchByDateExpense,
          //     decoration: InputDecoration(
          //       filled: true,
          //       fillColor: Colors.grey,
          //       labelStyle: TextStyle(color: Colors.black),
          //     ),
          //   ),
          // ),

          SizedBox(height: 20,),
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
                  primary: Colors.purple.withOpacity(1),
                ),

                child: Text('Search',style: TextStyle(
                    fontSize: 18,fontWeight: FontWeight.bold,
                    color: Colors.black),),),
            ),
                ),
          ),
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 60,
              width: 180,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(onPressed: ()
                {
                  generateDailyReport();
                },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.purple.withOpacity(1),
                  ),

                  child: Text('Daily',style: TextStyle(
                      fontSize: 18,fontWeight: FontWeight.bold,
                      color: Colors.black),),),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 60,
              width: 180,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(onPressed: ()
                {
                  generateWeeklyReport();
                },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.purple.withOpacity(1),
                  ),

                  child: Text('Weekly',style: TextStyle(
                      fontSize: 18,fontWeight: FontWeight.bold,
                      color: Colors.black),),),
              ),
            ),
          ),

          SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 60,
              width: 180,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(onPressed: ()
                {
                  generateMonthlyReport();
                },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.purple.withOpacity(1),
                  ),

                  child: Text('Monthly',style: TextStyle(
                      fontSize: 18,fontWeight: FontWeight.bold,
                      color: Colors.black),),),
              ),
            ),
          ),

          SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 60,
              width: 180,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(onPressed: ()
                {
                  generateYearlyReport();
                },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.purple.withOpacity(1),
                  ),

                  child: Text('Yearly',style: TextStyle(
                      fontSize: 18,fontWeight: FontWeight.bold,
                      color: Colors.black),),),
              ),
            ),
          ),

          SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 60,
              width: 180,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(onPressed: ()
                {
                  generateFullReport();
                },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.purple.withOpacity(1),
                  ),

                  child: Text('Full',style: TextStyle(
                      fontSize: 18,fontWeight: FontWeight.bold,
                      color: Colors.black),),),
              ),
            ),
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
