import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(debugShowCheckedModeBanner:false,home:RegustrationForm()));
}
class RegustrationForm extends StatefulWidget {
  const RegustrationForm({super.key});

  @override
  State<RegustrationForm> createState() => _RegustrationFormState();
}

class _RegustrationFormState extends State<RegustrationForm> {
  final Ref=FirebaseDatabase.instance.ref('FormTable');
  TextEditingController addDateOfBirth=TextEditingController();
  GlobalKey<FormState> FormKey=GlobalKey<FormState>();
  TextEditingController NameCon=TextEditingController();

  DateTime selectedDate = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1960),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        // Use the date property to keep only the date part without the time component
        selectedDate = DateTime(picked.year, picked.month, picked.day);
        // Format the date using DateFormat
        addDateOfBirth.text= DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  @override
  bool englishSelected = false;
  bool mathsSelected = false;
  bool urduSelected = false;
  String selectedGender = '';
  String selectedSubject = 'Pakistan';
  List<String> subjects = ['Pakistan', 'India', 'China'];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,title: Text("Registrationform"),centerTitle:true,),
   body: Container(
     margin: EdgeInsets.all(5),
     padding: EdgeInsets.all(5),
     child: Form(
       key:FormKey,
       child: ListView(
         children: [
             TextFormField(
               autovalidateMode: AutovalidateMode.onUserInteraction,
               controller: NameCon,
               decoration: InputDecoration(
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(5),
                 ),
                 labelStyle: TextStyle(color: Colors.black),
                 hintText: "Enter Name",
               ),
               validator: (value)
               {
                 if(value==null||value.trim().isEmpty)
                 {
                   return "Please must Enter name";
                 }
               },
             ),

       SizedBox(height: 20,),
           Container(
             height: 50, // Set a fixed height for the container
             child: DropdownButton<String>(
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
             ),
           ),
        Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
           buildGenderOption('Male'),
           buildGenderOption('Female'),
        if (selectedGender == null || selectedGender.trim().isEmpty)
          Text(
            'Please select a gender',
            style: TextStyle(color: Colors.red), // You can customize the style
          ),
           ],
           ),
           SizedBox(height: 12),
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
           children: [
           buildCheckboxItem('English', englishSelected, (value) {
           setState(() {
           englishSelected = value;
           });
           }),
           buildCheckboxItem('Maths', mathsSelected, (value) {
           setState(() {
           mathsSelected = value;
           });
           }),
           buildCheckboxItem('Urdu', urduSelected, (value) {
           setState(() {
           urduSelected = value;
           });
           }),
             if (englishSelected  == false && mathsSelected==false && urduSelected==false)
               Text(
                 'Please select any one option',
                 style: TextStyle(color: Colors.red), // You can customize the style
               ),
           ],
           ),
           SizedBox(height: 15),
            // key: FormKey1,
              TextFormField(
                 autovalidateMode: AutovalidateMode.onUserInteraction,
                 readOnly: true,
                 controller: addDateOfBirth,
                 decoration: InputDecoration(
                   hintText: 'yyyy-MM-D',
                   suffixIcon: IconButton(
                     onPressed: () => selectDate(context),
                     icon: Icon(Icons.event),
                   ),

                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(5),
                   ),
                   labelStyle: TextStyle(color: Colors.black,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                 validator: (value)
                 {
                   if (value == null || value.trim().isEmpty)
                   {
                     return 'Please Select Date of Birth';
                   }
                 }
             ),


           SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed:(){
                if(FormKey.currentState!.validate()&&selectedGender!=null&&!(selectedGender.trim().isEmpty)&&(englishSelected != false || mathsSelected!=false || urduSelected!=false))
                  {
                  String id=DateTime.now().millisecondsSinceEpoch.toString();
                  Ref.child(id).set({
                    'Name': NameCon.text.toString(),
                    'Gender':selectedGender,
                    'Subjects':getSelectedSubjects(),
                    'Date': addDateOfBirth.text.toString(),
                    'id': id
                  }).then((value) {
                    ScaffoldMessenger.of(FormKey.currentContext!).showSnackBar(
                      const SnackBar(
                        content: Text('Successfully Submitted'),
                      ),
                    );
                  }).onError((error, stackTrace) {
                    ScaffoldMessenger.of(FormKey.currentContext!).showSnackBar(
                      const SnackBar(
                        content: Text('Network Error'),
                      ),
                    );
                  });

                  }
               }, child: Text("submit")),
            ],
          ),
         ],
       ),
     ),
   ),
    );
  }

  Widget buildGenderOption(String gender) {
    return Row(
      children: [
        Radio(
          value: gender,
          groupValue: selectedGender,
          onChanged: (value) {
            setState(() {
              selectedGender = value.toString();
            });
          },
        ),
        Text(gender),
      ],
    );
  }

  Widget buildCheckboxItem(String label, bool value, void Function(bool) onChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (bool? newValue) {
            onChanged(newValue ?? false);
          },
        ),
        Text(label),
      ],
    );
  }


  String getSelectedSubjects() {
    List<String> selectedSubjects = [];

    if (englishSelected) selectedSubjects.add('English');
    if (mathsSelected) selectedSubjects.add('Maths');
    if (urduSelected) selectedSubjects.add('Urdu');

    return selectedSubjects.join(', ');
  }

}
