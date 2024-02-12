import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:readmore/readmore.dart';

void main() {
  runApp(const Pubdev());
}

class Pubdev extends StatefulWidget {
  const Pubdev({Key? key}) : super(key: key);

  @override
  State<Pubdev> createState() => _PubdevState();
}

class _PubdevState extends State<Pubdev> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.blue,
        actions: [
          Center(
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -10, end: -12),
              badgeContent: Text("1"),
              badgeAnimation: badges.BadgeAnimation.rotation(
                animationDuration: Duration(seconds: 2),
                colorChangeAnimationDuration: Duration(seconds: 3),
                loopAnimation: false,
                curve: Curves.fastOutSlowIn,
                colorChangeAnimationCurve: Curves.easeInCubic,
              ),
              badgeStyle: badges.BadgeStyle(
                badgeColor: Colors.red,
                //shape: badges.BadgeShape.square,
                borderRadius: BorderRadius.circular(8),
                //borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              child: Icon(Icons.shopping_cart,color: Colors.white,),
            ),
          ),
          SizedBox(width: 17,)
        ],),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            PinCodeTextField(appContext: context,
                length: 4,
            cursorColor: Colors.teal,
            keyboardType: TextInputType.number,
            obscureText: true,
            obscuringCharacter: '*',
            enabled: true,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10),
              fieldHeight: 50,
              fieldWidth: 40,
              activeColor: Colors.grey,
              activeFillColor: Colors.teal,
              inactiveFillColor: Colors.grey,
              selectedFillColor: Colors.red,
              inactiveColor: Colors.red,
              selectedColor: Colors.blue,
            ),
            onChanged: (value){

            }
            )
            ],
          ),
        ),
      ),
    );
  }
}

//Icon(Icons.home),
//Icon(CupertinoIcons.home),
// Icon(FontAwesomeIcons.searchengin),
// SizedBox(height: 3,),
// Icon(FontAwesomeIcons.home),
// SizedBox(height: 7,),
// Icon(FontAwesomeIcons.addressBook),

//  ReadMoreText(
//     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
//     trimLines: 2,
//    trimMode: TrimMode.Line,
//    trimCollapsedText: "Show All",
//    moreStyle: TextStyle(color:Colors.blue,fontSize: 16),
//     lessStyle: TextStyle(color: Colors.blue,fontSize: 16),
//   )

// child: badges.Badge(
// position: badges.BadgePosition.topEnd(top: -10, end: -12),
// badgeContent: Text("1"),
// badgeAnimation: badges.BadgeAnimation.rotation(
// animationDuration: Duration(seconds: 3),
// colorChangeAnimationDuration: Duration(seconds: 3),
// loopAnimation: false,
// curve: Curves.fastOutSlowIn,
// colorChangeAnimationCurve: Curves.easeInCubic,
// ),
// badgeStyle: badges.BadgeStyle(
// badgeColor: Colors.green,
// //shape: badges.BadgeShape.square,
// borderRadius: BorderRadius.circular(8),
// //borderSide: BorderSide(color: Colors.white, width: 1),
// ),
// child: Icon(Icons.shopping_cart),
// ),

// SizedBox(
// width: 250.0,
// child: DefaultTextStyle(
// style: const TextStyle(
// color: Colors.blue,
// fontSize: 14.0,
// fontFamily: 'Bobbers',
// ),
// child: AnimatedTextKit(
// animatedTexts: [
// TyperAnimatedText('It is not enough to do your best,'),
// TyperAnimatedText('you must know what to do,'),
// TyperAnimatedText('and then do your best'),
// TyperAnimatedText('- W.Edwards Deming'),
// ],
// onTap: () {
// print("Tap Event");
// },
// ),
// ),
// ),
