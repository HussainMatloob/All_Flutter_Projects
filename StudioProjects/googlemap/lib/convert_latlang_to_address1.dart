import 'package:flutter/material.dart';
import 'package:googlemap/home_screen.dart';

class LatLangToAddress extends StatefulWidget {
  const LatLangToAddress({super.key});

  @override
  State<LatLangToAddress> createState() => _LatLangToAddressState();
}

class _LatLangToAddressState extends State<LatLangToAddress> {
  @override

  String stAddress='';

  TextEditingController latitude=TextEditingController();
  TextEditingController longitude=TextEditingController();
  GlobalKey<FormState> keys=GlobalKey();
  String selectedSubject = 'adminArea';
  List<String> subjects = ['adminArea', 'countryCode', 'addressLine','featureName','subAdminArea'];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,title: Text("Google Map"),centerTitle: true,),
      body: Form(
        key: keys,
        child: ListView(

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: latitude,
                decoration: InputDecoration(
                  hintText: "Enter latitude",
                ),
                validator: (value)
                {
                  if(value==null||value.isEmpty)
                  {
                    return "please Enter coordinates";
                  }
                },
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: longitude,
                decoration: InputDecoration(
                  hintText: "Enter longitude",
                ),
                validator: (value)
                {
                  if(value==null||value.isEmpty)
                  {
                    return "please Enter coordinates";
                  }
                },
              ),
            ),

            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
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

            SizedBox(height: 10,),
            Text(stAddress),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async{
                  if(keys.currentState!.validate())
                  {

                    // final query = "Jamia Masjid Haji Abdul RehmanVillage Maira Begwal, near Jamia Masjid Haji Abdul Rehman, Maira Begwal, Islamabad, Islamabad Capital Territory, Pakistan";
                    // var addresses = await Geocoder.local.findAddressesFromQuery(query);
                    // var second = addresses.first;
                    // print("${second.featureName} : ${second.coordinates}");
                    //
                    // final coordinates=new Coordinates(double.parse(latitude.text.toString()),double.parse(longitude.text.toString()));
                    // var address=await Geocoder.local.findAddressesFromCoordinates(coordinates);
                    // var first=address.first;
                    // print("Address: "+first.featureName.toString()+first.addressLine.toString());
                    //
                    // setState(() {
                    //   switch (selectedSubject) {
                    //     case 'adminArea':
                    //       stAddress = first.adminArea ?? '';
                    //       break;
                    //     case 'countryCode':
                    //       stAddress = first.countryCode ?? '';
                    //       break;
                    //     case 'addressLine':
                    //       stAddress = first.addressLine ?? '';
                    //       break;
                    //     case 'featureName':
                    //       stAddress = first.featureName ?? '';
                    //       break;
                    //     case 'subAdminArea':
                    //       stAddress = first.subAdminArea ?? '';
                    //       break;
                    //     default:
                    //       stAddress = '';
                    //   }
                    // });

                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Center(
                    child: Text(
                        'Convert'
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10,),

            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Center(
                    child: Text(
                        'Google Map'
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
