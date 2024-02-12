import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:home_expenses/LoginPage.dart';
import 'package:home_expenses/Update_And_Delete_Item.dart';
import 'package:home_expenses/cash_In_wallet.dart';
import 'package:home_expenses/cash_in_bank.dart';
import 'package:home_expenses/provider_state.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Add_Items.dart';
import 'Expenses_Report.dart';
import 'Update_And_Delete_Expenses.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';

class AddExpenses extends StatefulWidget {
  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses>
    with TickerProviderStateMixin {
  @override
  String selectedSubject = 'Cash in Wallet';
  List<String> subjects = ['Cash in Wallet', 'Cash in Bank'];

  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 1), vsync: this)
        ..repeat();

  String? UserEmail;
  String? UserPassword;
  final GlobalKey<FormState> addExpenseKey = GlobalKey<FormState>();
  final TextEditingController addExpenseCon = TextEditingController();
  final TextEditingController addDate = TextEditingController();
  final FirebaseRef = FirebaseDatabase.instance.ref('ItemsTable');
  final ExpenseRef = FirebaseDatabase.instance.ref('ExpensesTable');

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
        addDate.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  final DateTime currentDate = DateTime.now();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  late String date;
  // Constructor for ChildFormPage
  _AddExpensesState() {
    date = dateFormat.format(currentDate);
    addDate.text = date;
  }

  String? ExpenseValidate(value) {
    if (value.trim().isEmpty) {
      return 'Please must fill Expense field';
    }
    bool nameReg = RegExp(r'^[0-9]*$').hasMatch(value);
    if (nameReg == false) {
      return 'Only accepted digits';
    }
    return null;
  }

  void SPdata() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    UserEmail = sp.getString('Email');
    UserPassword = sp.getString('Name');
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SPdata();
  }

  void logout() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('isLogin');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderState>(context);
    return Scaffold(

      backgroundColor: Colors.white70,
      appBar: AppBar(
          // automaticallyImplyLeading: false,
          backgroundColor: Colors.teal,
          title: Text("Add Expenses",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Rubik Medium',
              )),
          centerTitle: true,
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: ListTile(
                    onTap: () {
                      fetchDataAndGenerateExcel();
                      Navigator.pop(context);
                    },
                    title: Row(
                      children: [
                        Image.asset('images/excelImage.png',
                            width: 24.0, height: 24.0),
                        SizedBox(
                            width:
                                8.0), // Add some spacing between icon and text
                        Text('Excel', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
          ]),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child:Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/ExpenseImage.png'),
                      ),

                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                 SizedBox(width: 10,),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text('Daily',style: TextStyle(
                         fontSize: 24,
                         fontFamily: 'RubikBrokenFax Regular',
                         color: Colors.black),),
                     Text('Expenses',style: TextStyle(
                         fontSize: 24,
                         fontFamily: 'RubikBrokenFax Regular',
                         color: Colors.blue),),
                   ],
                 ),
                ],
              ),
                decoration: BoxDecoration(
                  color: Color(0xff744abc), // Set the background color here
                ),
                 ),
            ListTile(
              title: Text("Add Items",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Rubik Medium',
                  )),
              leading: Icon(
                Icons.shopping_cart,
                color: Colors.green,
              ),
              // trailing: Text("6:30"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FormPage()));
              },
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              title: Text("Items Detail",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Rubik Medium',
                  )),
              leading: Icon(
                Icons.list,
              ),
              // trailing: Text("6:30"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateAndDeleteItem()));
              },
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              title: Text("Expenses Detail",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Rubik Medium',
                  )),
              leading: Icon(Icons.receipt),
              // trailing: Text("6:30"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateAndDeleteExpenses()));
              },
            ),
            Divider(
              height: 1,
            ),
            //Divider(height: 1,),
            ListTile(
              title: Text("Cash in Bank",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Rubik Medium',
                  )),
              leading: Icon(
                Icons.account_balance,
                color: Colors.blue,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CashInBank()));
              },
              // trailing: Text("6:30"),
            ),
            Divider(
              height: 1,
            ),

            ListTile(
              title: Text("Cash in Wallet",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Rubik Medium',
                  )),
              leading: Icon(
                Icons.account_balance_wallet,
                color: Colors.brown,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CashInwallet()));
              },
              // trailing: Text("6:30"),
            ),
            Divider(
              height: 1,
            ),

            ListTile(
              title: Text("Expenses Report",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Rubik Medium',
                  )),
              leading: Icon(Icons.calculate),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ExpenseReport()));
              },
              // trailing: Text("6:30"),
            ),
            Divider(
              height: 1,
            ),

            ListTile(
              title: Text("Generate Excel",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Rubik Medium',
                  )),
              leading: Image.asset('images/excelImage.png',
                  width: 24.0, height: 24.0),
              onTap: () {
                fetchDataAndGenerateExcel();
              },
              // trailing: Text("6:30"),
            ),
            Divider(
              height: 1,
            ),


            // Divider(height: 1,)
          ],
        ),
      ),

      body: Container(
        child: ListView(
          children: [
            SizedBox(height: 60,),
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

            SizedBox(
              height: 20,
            ),
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
                    child: Container(
                      child: Form(
                        key: addExpenseKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 70,
                            ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: addExpenseCon,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                                ),
                                hintText: 'Enter Expense Amount',
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              validator: ExpenseValidate,
                            ),


                            SizedBox(
                              height: 20,
                            ),
                            // Set a fixed height for the container

                               DropdownButtonFormField<String>(
                                value: selectedSubject,
                                items: subjects.map((String subject) {
                                  return DropdownMenuItem<String>(
                                    value: subject,
                                    child: Text(subject),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedSubject = newValue!;
                                  });
                                },
                                isExpanded: true,
                                 decoration: InputDecoration(
                                   focusedBorder: UnderlineInputBorder(
                                     borderSide: BorderSide(color: Colors.black, width: 2.0),
                                   ),
                                   enabledBorder: UnderlineInputBorder(
                                     borderSide: BorderSide(color: Colors.black, width: 2.0),
                                   ),
                                   filled: true,
                                   fillColor: Colors.white,
                                 ),
                              ),


                            SizedBox(
                              height: 20,
                            ),

                            TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  readOnly: true,
                                  controller: addDate,

                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () => selectDate(context),
                                    icon: Icon(Icons.event),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please must fill date field';
                                    }
                                  }),

                            SizedBox(
                              height: 40,
                            ),

                            InkWell(
                              onTap: () {
                                if(addExpenseKey.currentState!.validate()) {
                                  showMyDialog(provider,selectedSubject);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 100),
                                child: Container(
                                  height: 70,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: Colors.indigo,
                                      borderRadius: BorderRadius.circular(30)),
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
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
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
          ],
        ),
      ),
    );
  }

  Future<void> fetchDataAndGenerateExcel() async {
    // Fetch data from Firebase
    DatabaseEvent event = await ExpenseRef.once();
    DataSnapshot snapshot = event.snapshot;

    // Create Excel file
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];

    // Add headers
    sheet.cell(CellIndex.indexByString("A1")).value = "Expense Name";
    sheet.cell(CellIndex.indexByString("B1")).value = "Expense Amount";
    sheet.cell(CellIndex.indexByString("C1")).value = "Method";
    sheet.cell(CellIndex.indexByString("D1")).value = "Date";

    // Add data to Excel sheet
    var rowIndex = 2;
    Map<dynamic, dynamic> dataMap =
        (snapshot.value as Map<dynamic, dynamic>?) ?? {};
    dataMap.forEach((key, expenseData) {
      sheet.cell(CellIndex.indexByString("A$rowIndex")).value = expenseData['EName'];
      sheet.cell(CellIndex.indexByString("B$rowIndex")).value = expenseData['ExpenseAmount'];
      sheet.cell(CellIndex.indexByString("C$rowIndex")).value = expenseData['Method'];
      sheet.cell(CellIndex.indexByString("D$rowIndex")).value = expenseData['Date'];
      rowIndex++;
    });

    // Get the document directory using path_provider
    Directory? documentDirectory = await getExternalStorageDirectory();
    if (documentDirectory != null) {
      String path = documentDirectory.path;

      // Save the Excel file in the document directory
      File file = File('$path/expense_data.xlsx');
      // print("Path is: " + path + "/expense_data.xlsx");
      var bytes = await excel.encode();
      // Ensure that bytes is non-nullable before passing it to writeAsBytes
      List<int> nonNullableBytes = bytes ?? Uint8List.fromList([]);
      await file.writeAsBytes(nonNullableBytes);

      // Open the file with the default app
      await OpenFile.open(file.path);
    } else {
      // Handle the case where getExternalStorageDirectory returns null
      print('Error: Unable to determine external storage directory.');
    }
  }

  //var bytes = await excel.encode();
  Future<void> showMyDialog(provider,selectedSubject) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Expense'),
          content: Container(
            width: double.maxFinite, // Ensure the content takes the full width
            child: ListView(
              shrinkWrap:
                  true, // Allow the ListView to scroll inside the AlertDialog
              children: [
                // Use a FutureBuilder to handle asynchronous data fetching
                FutureBuilder(
                  future: FirebaseRef
                      .once(), // Assuming FirebaseRef is a DatabaseReference
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                          flex: 1,
                          child: Center(
                            child: SpinKitFadingCircle(
                              color: Colors.grey,
                              size: 100,
                              controller: _controller,
                            ),
                          ));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data?.snapshot.value == null) {
                      return Text('No data available');
                    } else {
                      // Extract data and create ListTiles
                      List<Widget> listTiles = [];
                      Map<dynamic, dynamic>? data = snapshot
                          .data!.snapshot.value as Map<dynamic, dynamic>?;

                      if (data != null) {
                        data.forEach((key, value) {
                          listTiles.add(
                            ListTile(
                              title: Text(value['ExpenseName'].toString()),
                              onTap: () {
                                if (selectedSubject.toString() ==
                                    'Cash in Wallet') {
                                  String id = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();
                                  ExpenseRef.child(id).set({
                                    'id': id,
                                    'EName': value['ExpenseName'].toString(),
                                    'ExpenseAmount': addExpenseCon.text.toString(),
                                    'Date': addDate.text.toString(),
                                    'Method':selectedSubject.toString(),
                                  }).then((value) {
                                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Center(child: Text("Add Expense Successfully",style: TextStyle(color: Colors.black))),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.white,
                                        elevation: 5,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    );

                                    Navigator.of(context).pop();
                                    provider.subtractInWallet(int.parse(
                                        addExpenseCon.text.toString()));
                                  }).onError((error, stackTrace) {
                                    ScaffoldMessenger.of(
                                            addExpenseKey.currentContext!)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text('Network Error'),
                                      ),
                                    );
                                  });
                                } else {
                                  String id = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();
                                  ExpenseRef.child(id).set({
                                    'id': id,
                                    'EName': value['ExpenseName'].toString(),
                                    'ExpenseAmount': addExpenseCon.text.toString(),
                                    'Date': addDate.text.toString(),
                                    'Method':selectedSubject.toString(),
                                  }).then((value) {
                                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Center(child: Text("Add Expense Successfully",style: TextStyle(color: Colors.black))),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.white,
                                        elevation: 5,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    );

                                    Navigator.of(context).pop();
                                    provider.subtractInBank(int.parse(
                                        addExpenseCon.text.toString()));
                                  }).onError((error, stackTrace) {
                                    ScaffoldMessenger.of(
                                            addExpenseKey.currentContext!)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text('Network Error'),
                                      ),
                                    );
                                  });
                                }
                              },
                            ),
                          );
                        });
                      } else {
                        return Text(
                            'Data is null or not in the expected format');
                      }

                      return Column(
                        children: listTiles,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [],
        );
      },
    );
  }
}
