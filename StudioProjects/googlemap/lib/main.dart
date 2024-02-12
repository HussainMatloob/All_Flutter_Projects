import 'package:flutter/material.dart';
import 'package:googlemap/custom_marker_info_window.dart';
import 'package:googlemap/custom_marker_screen.dart';
import 'package:googlemap/gooogle_places_api.dart';
import 'package:googlemap/home_screen.dart';
import 'package:googlemap/polygone_screen.dart';
import 'package:googlemap/polyline.dart';
import 'package:googlemap/style_googlemap_screen.dart';
import 'package:googlemap/user_current_location.dart';

import 'Horizontal_scrool.dart';
import 'convert_latlang_to_address.dart';
import 'network_Image_marker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       home: HorizontalScroll(),
     );
  }
}
