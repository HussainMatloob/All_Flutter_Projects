import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLineScreen extends StatefulWidget {
  const PolyLineScreen({super.key});

  @override
  State<PolyLineScreen> createState() => _PolyLineScreenState();
}

class _PolyLineScreenState extends State<PolyLineScreen> {
  @override

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _keyGooglePlex = CameraPosition(
    target: LatLng(33.733129, 73.247193),
    zoom: 15,
  );

  final Set<Marker> _markers ={};
  final Set<Polyline> _polyLine={};

  List<LatLng> latlan=[
    LatLng(33.693369,73.155214),
    LatLng(33.733129, 73.247193),
    LatLng(33.659290,73.219549),
    LatLng(33.693090,73.285064),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0;i<latlan.length;i++)
      {
        _markers.add(Marker(markerId: MarkerId(i.toString()),
        position: latlan[i],
          infoWindow: InfoWindow(
            title: 'Realy  cool place',
            snippet: 'S Star Rating'
          ),
          icon: BitmapDescriptor.defaultMarker
        )
        );
        setState(() {

        });
      }

    _polyLine.add(
      Polyline(polylineId: PolylineId('1'),
      points: latlan,
        color: Colors.red.withOpacity(0.3),
      ),
    );

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,title: Text("PolyLine"),centerTitle: true,),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _keyGooglePlex,
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          compassEnabled: true,
          markers: _markers,
          polylines: _polyLine,
          //markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
