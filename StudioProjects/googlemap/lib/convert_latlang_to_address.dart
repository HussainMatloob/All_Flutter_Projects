import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:googlemap/home_screen.dart';

class ConvertLatLangToAddress extends StatefulWidget {
  const ConvertLatLangToAddress({super.key});

  @override
  State<ConvertLatLangToAddress> createState() => _ConvertLatLangToAddressState();


}

class _ConvertLatLangToAddressState extends State<ConvertLatLangToAddress> {
  @override


  String stAddress='',Address='';
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,title: Text("Google Map"),centerTitle: true,),
      body: Column(
mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: 10,),
          Text(stAddress),
          SizedBox(height: 10,),
          Text(Address),

              GestureDetector(
                onTap: () async{

                  List<Location> locations = await locationFromAddress("Jamia Masjid Haji Abdul RehmanVillage Maira Begwal, near Jamia Masjid Haji Abdul Rehman, Maira Begwal, Islamabad, Islamabad Capital Territory, Pakistan");
                      //final query = "Jamia Masjid Haji Abdul RehmanVillage Maira Begwal, near Jamia Masjid Haji Abdul Rehman, Maira Begwal, Islamabad, Islamabad Capital Territory, Pakistan";
                      //final coordinates=new Coordinates(33.6992,72.9744);

                  List<Placemark> placemarks = await placemarkFromCoordinates(33.733129,73.247193);
                      setState(() {
                        stAddress=locations.last.latitude.toString()+" , "+locations.last.longitude.toString();
                        Address=placemarks.reversed.last.country.toString()+" "+placemarks.reversed.last.locality.toString()+" "+placemarks.reversed.last.street.toString();
                      });


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
                        'Convert'
                      ),
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
