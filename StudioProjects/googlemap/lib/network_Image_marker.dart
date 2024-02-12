import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'dart:ui';

class NetworkImageMarker extends StatefulWidget {
  const NetworkImageMarker({super.key});

  @override
  State<NetworkImageMarker> createState() => _NetworkImageMarkerState();
}

class _NetworkImageMarkerState extends State<NetworkImageMarker> {
  @override

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _keyGooglePlex = CameraPosition(
    target: LatLng(33.733129, 73.247193),
    zoom: 15,
  );

  final List<Marker> _markers =<Marker>[];

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
    loadData();
  }

  Future<Uint8List?> loadNetworkImage(String path) async{
    final completer=Completer<ImageInfo>();
    var image=NetworkImage(path);
    image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((info,_)=>completer.complete(info))
    );
    final imageInfo=await completer.future;

    final byteData=await imageInfo.image.toByteData(format:ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  loadData() async{
    for(int i=0;i<latlan.length;i++)
      {
        Uint8List? image=await loadNetworkImage('https://img.freepik.com/free-photo/man-smiling-with-hands-hips_1187-3017.jpg?size=626&ext=jpg&ga=GA1.1.1322302817.1699425350&semt=ais');

        final ui.Codec markerImageCodec=await ui.instantiateImageCodec(
          image!.buffer.asUint8List(),
          targetHeight: 100,
          targetWidth: 100,
        );

        final ui.FrameInfo frameInfo=await markerImageCodec.getNextFrame();
        final ByteData? byteData=await frameInfo.image.toByteData(
          format:ui.ImageByteFormat.png
        );

        final Uint8List resizeImageMarker=byteData!.buffer.asUint8List();

        _markers.add(Marker(markerId: MarkerId(i.toString()),
        position: latlan[i],
         icon: BitmapDescriptor.fromBytes(resizeImageMarker),
          infoWindow: InfoWindow(
            title: "This is Title",
            snippet: 'Abc'
          )
        ));
      setState(() {

      });
      }
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
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
