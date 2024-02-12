import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({super.key});

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {

  CustomInfoWindowController _customInfoWindowController= CustomInfoWindowController();

   final List<Marker> _markers=<Marker>[];
   final List<LatLng> _latlang=<LatLng>[
     LatLng(33.733129,73.247193),LatLng(33.733557,73.071713),LatLng(33.693369,73.155214),
     LatLng(33.659290,73.219549),LatLng(33.693090,73.285064),LatLng(33.764192,73.313741)];

   @override

  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData(){
     for(int i=0;i<_latlang.length;i++)
       {
         _markers.add(Marker(markerId: MarkerId(i.toString()),
         icon: BitmapDescriptor.defaultMarker,
           position: _latlang[i],
           onTap: (){

           _customInfoWindowController.addInfoWindow!(
              Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('https://media.istockphoto.com/id/1442417585/photo/person-getting-a-piece-of-cheesy-pepperoni-pizza.webp?s=612x612&w=is&k=20&c=34cybUQKjUr2-gsYOdzxlnez3VRBusIhozf5eKp11HI='),
                          fit: BoxFit.fitWidth,
                          filterQuality: FilterQuality.high
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.red,
                      ),
                    ),

                    const Padding(padding: EdgeInsets.only(top:10,left: 10,right: 10),
                    child: Row(
                      children: [
                        SizedBox(width: 100,
                        child: Text("Beef Tacos",
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,),
                        ),
                        Spacer(),
                        Text(
                          '.3 mi.'


                        ),

                      ],
                    ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("Help me finish tacos! I got a platter from costco and it's to much"),
                    )

                  ],
                ),
              ),
             _latlang[i],
           );
           }
         ),
         );
         setState(() {

         });
       }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,title: Text("Custom info window Example"),centerTitle: true,),
      body: Stack(
        children: [
        GoogleMap(initialCameraPosition: CameraPosition(
          target: LatLng(33.733129,73.247193),
          zoom: 15,
        ),
          markers:Set<Marker>.of(_markers),
          onTap: (position){
         _customInfoWindowController.hideInfoWindow!();
          },
          onCameraMove: (position){
          _customInfoWindowController.onCameraMove!();
          },
          onMapCreated: (GoogleMapController controller){
          _customInfoWindowController.googleMapController=controller;
          },
        ),

       CustomInfoWindow(controller:  _customInfoWindowController,
       height: 200,
         width: 300,
         offset: 35,
       )

        ],
      ),

    );
  }
}
