import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApiScreen extends StatefulWidget {
  const GooglePlacesApiScreen({super.key});

  @override
  State<GooglePlacesApiScreen> createState() => _GooglePlacesApiScreenState();
}

class _GooglePlacesApiScreenState extends State<GooglePlacesApiScreen> {
  TextEditingController _controller=TextEditingController();
  var uuid=Uuid();
  String _sessionToken='123456';
  List<dynamic> _placesList=[];


  @override
  void initState() {
     // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange(){
    if(_sessionToken==null)
      {
        setState(() {
          _sessionToken=uuid.v4();
        });
      }
    else{
      getSuggestion(_controller.text);
    }
  }

  void getSuggestion(String input) async{
 String KPLACES_API_KEY="AIzaSyDQ2c_pOSOFYSjxGMwkFvCVWKjYOM9siow";
 String baseURL='https://maps.googleapis.com/maps/api/place/autocomplete/json';
 String request='$baseURL?input=$input&key=$KPLACES_API_KEY&sessiontoken=$_sessionToken';

 var response=await http.get(Uri.parse(request));
 var data=response.body.toString();

 print('data');
 print(data);

 if(response.statusCode==200)
   {
 setState(() {
   _placesList=jsonDecode(response.body.toString())['predictions'];
 });
   }else{
   throw Exception("Failed to load data");
 }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,
      backgroundColor: Colors.teal,
      title: Text("Google Search Places Api"),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
      TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: "Search places with name",
        ),
      ),
            Expanded(
              child: ListView.builder(
                  itemCount: _placesList.length,
                  itemBuilder:(context,index){
                  return ListTile(
                    onTap: ()async{
                      List<Location> locations = await locationFromAddress(_placesList[index]['description']);
                      print(locations.last.latitude);
                      print(locations.last.longitude);
                      },
                    title: Text(_placesList[index]['description']),
                  );
              }),
            )
          ],
        ),
      ),
    );
  }
}
