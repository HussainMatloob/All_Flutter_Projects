import 'package:flutter/material.dart';
import 'package:mvvm_project/res/colours.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  RoundButton({super.key,required this.title,
    this.loading=false,
    required this.onPress});

  @override
  Widget build(BuildContext context) {
     return InkWell(
       onTap:onPress,
       child: Container(
         height: 50,
         width: 300,
         decoration: BoxDecoration(
           color:  AppColors.buttonColor,
           borderRadius: BorderRadius.circular(10),
         ),
         child: Center(
           child:loading ? CircularProgressIndicator():Text(title,style: TextStyle(color: AppColors.WhiteColor),),
         ),
       ),
     );
  }
}
