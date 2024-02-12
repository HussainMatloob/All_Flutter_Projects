import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGoogleMapScreen extends StatefulWidget {
  const StyleGoogleMapScreen({super.key});

  @override
  State<StyleGoogleMapScreen> createState() => _StyleGoogleMapScreenState();
}

class _StyleGoogleMapScreenState extends State<StyleGoogleMapScreen> {
  @override

// String mapTheme='';

  final Completer<GoogleMapController> _controller=Completer();

  static const CameraPosition _kGooglePlex=CameraPosition(
      target: LatLng(33.733129, 73.247193),
    zoom: 15
  );

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   DefaultAssetBundle.of(context).loadString('assets/map_theme/night.json').then((value) {
  //     mapTheme=value;
  //   });
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,title: Text("Style Google Map"),centerTitle: true,
        actions: [
       PopupMenuButton(itemBuilder:
       (context)=>
       [
         PopupMenuItem(
           onTap: ()
           {
             _controller.future.then((value){
               DefaultAssetBundle.of(context).loadString('assets/map_theme/standard.json').then((string) {
                 value.setMapStyle(string);
               });
             });
           },
           child: Text("Standard"),
         ),
         PopupMenuItem(
           onTap: ()
           {
             _controller.future.then((value){
               DefaultAssetBundle.of(context).loadString('assets/map_theme/silver_theme.json').then((string) {
                 value.setMapStyle(string);
               });
             });
           },
           child: Text("Silver"),
         ),
         PopupMenuItem(
             onTap: ()
             {
               _controller.future.then((value){
                 DefaultAssetBundle.of(context).loadString('assets/map_theme/retro.json').then((string) {
                   value.setMapStyle(string);
                 });
               });
             },
           child: Text("Retro"),
         ),
         PopupMenuItem(

           onTap: ()
           {
             _controller.future.then((value){
               DefaultAssetBundle.of(context).loadString('assets/map_theme/night.json').then((string) {
                 value.setMapStyle(string);
               });
             });
           },
           child: Text("Night"),
         )
       ]
       ),
          SizedBox(width: 10,),
      ],
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          //mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          compassEnabled: true,
          //markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller) {
           // controller.setMapStyle(mapTheme);
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
