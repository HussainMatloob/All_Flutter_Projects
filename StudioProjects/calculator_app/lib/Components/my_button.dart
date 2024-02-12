import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onPressed;
  const MyButton({super.key,
    required this.title,
    this.color=const Color(0xffa5a5a5),
    required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(100),
              shape: BoxShape.circle,
              color:color,
            ),
            child: Center(
              child: Text(title,style: TextStyle(fontSize: 20,color: Colors.white),),
            ),
          ),
        ),
      ),
    );
  }
}