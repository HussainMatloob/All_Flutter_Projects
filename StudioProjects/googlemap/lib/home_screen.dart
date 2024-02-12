import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Completer<GoogleMapController> _controller=Completer();
   final CameraPosition _kgooglePlex=const CameraPosition(
      target: LatLng(33.733129,73.247193),
       zoom: 14.4746);

  List<Marker> _marker=[];
  List<Marker> _list= const[
    Marker(markerId: MarkerId('1'),
    position:LatLng(33.733129,73.247193),
      infoWindow:InfoWindow(
        title: 'My current Location',
      ),
    ),
    Marker(markerId: MarkerId('2'),
      position:LatLng(33.731444,73.243927),
      infoWindow:InfoWindow(
        title: 'Jama Masjid Haji Abdul Rehman',
      ),
    ),
    Marker(markerId: MarkerId('3'),
      position:LatLng(35.6762,139.6503),
      infoWindow:InfoWindow(
        title: 'Japan Country',
      ),
    )
  ];

  void initState(){
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition:_kgooglePlex,
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          markers:Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_disabled_outlined),
        onPressed: ()async{
          GoogleMapController controller=await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target:  LatLng(33.731444,73.243927),
            zoom:14 ),
          ));

        },
      ),
    );
  }
}
//AIzaSyDAmUHmAnmkjKmXLDg5lYGm6dfkVaHsbUM