import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocationScreen extends StatefulWidget {
  const GetUserCurrentLocationScreen({super.key});

  @override
  State<GetUserCurrentLocationScreen> createState() => _GetUserCurrentLocationScreenState();
}

class _GetUserCurrentLocationScreenState extends State<GetUserCurrentLocationScreen> {
  @override
  final Completer<GoogleMapController> _controller=Completer();
  static const CameraPosition _keyGooglePlex=CameraPosition(target:
  LatLng(33.733129,73.247193),
  zoom: 14);

  List<Marker> _marker= [
    Marker(markerId: MarkerId('1'),
      position:LatLng(33.733129,73.247193),
      infoWindow:InfoWindow(
        title: 'My current Location',
      ),
    ),
  ];

  Future<Position> getUserCurrentLocation()
  async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace) {
      print("error"+error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition:_keyGooglePlex,
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
        onPressed: ()async{
          getUserCurrentLocation().then((value) async{
            print("My current location");
            print(value.latitude.toString()+" "+value.longitude.toString());
            _marker.add(
              Marker(
                markerId:MarkerId('2'),
                position:  LatLng(value.latitude,value.longitude),
                infoWindow: InfoWindow(
                  title: 'My current location',
                ),
              )
            );
            CameraPosition cameraPosition=CameraPosition(
              zoom: 14,
              target: LatLng(value.latitude,value.longitude),);

            final GoogleMapController controller=await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {

            });

          });
        },
        child: Icon(Icons.location_disabled_outlined),
      ),
    );
  }
}
