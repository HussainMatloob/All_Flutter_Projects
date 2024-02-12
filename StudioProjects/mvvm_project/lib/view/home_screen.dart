import 'package:flutter/material.dart';
import 'package:mvvm_project/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

import '../view_model/user_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userModel=Provider.of<UserViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           SearchBarAnimation(
            textEditingController: TextEditingController(),
            isOriginalAnimation: true,
            enableKeyboardFocus: true,
            onExpansionComplete: () {
              debugPrint(
                  'do something just after searchbox is opened.');
            },
            onCollapseComplete: () {
              debugPrint(
                  'do something just after searchbox is closed.');
            },
            onPressButton: (isSearchBarOpens) {
              debugPrint(
                  'do something before animation started. It\'s the ${isSearchBarOpens ? 'opening' : 'closing'} animation');
            },
            trailingWidget: const Icon(
              Icons.search,
              size: 20,
              color: Colors.black,
            ),
            secondaryButtonWidget: const Icon(
              Icons.close,
              size: 20,
              color: Colors.black,
            ),
            buttonWidget: const Icon(
              Icons.search,
              size: 20,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10,),
        InkWell(
            onTap: (){
              userModel.remove().then((value) {
                Navigator.pushNamed(context, RoutesName.login);
              }).onError((error, stackTrace){

              });
            },
            child: Text("LouOut"))
        ],
      ),
    );
  }
}
