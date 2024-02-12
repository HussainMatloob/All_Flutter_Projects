import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygoneScreen extends StatefulWidget {
  const PolygoneScreen({super.key});

  @override
  State<PolygoneScreen> createState() => _PolygoneScreenState();
}

class _PolygoneScreenState extends State<PolygoneScreen> {
  @override

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _keyGooglePlex = CameraPosition(
    target: LatLng(33.733129, 73.247193),
    zoom: 15,
  );

  final List<Marker> _markers = <Marker>[];

  Set<Polygon> _polygon=HashSet<Polygon>();

  List<LatLng> points=[
    LatLng(33.733129, 73.247193),
    LatLng(33.693369,73.155214),
    LatLng(33.659290,73.219549),
    LatLng(33.693090,73.285064),
    LatLng(33.733129, 73.247193)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygon.add(
      Polygon(polygonId: PolygonId('1'),points: points,
      fillColor: Colors.red.withOpacity(0.3),
        geodesic: true,
        strokeWidth: 4,
        strokeColor: Colors.deepOrange,
      )
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,title: Text("Polygon"),centerTitle: true,),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _keyGooglePlex,
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          compassEnabled: true,
          polygons: _polygon,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
