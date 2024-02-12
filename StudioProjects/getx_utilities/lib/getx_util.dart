import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:getx_utilities/home_page.dart';
class GetxUtilities extends StatefulWidget {
  const GetxUtilities({super.key});

  @override
  State<GetxUtilities> createState() => _GetxUtilitiesState();
}

class _GetxUtilitiesState extends State<GetxUtilities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,title: Text("Getx Utilities"),centerTitle: true,),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: Text('GetX Dialog'),
              subtitle: Text('GetX dialog alart with getx'),
              onTap: (){
             Get.defaultDialog(
               titlePadding: EdgeInsets.only(top: 20),
               title: 'Delete Chat',
               contentPadding: EdgeInsets.all(20),
               //middleText: "Are you sure you want to delete this chat?",
               confirm: TextButton(onPressed: (){
                 //Navigator.pop(context);
                 Get.back();
               }, child:Text('Yes')),
               cancel: TextButton(onPressed: (){
                // Navigator.pop(context);
                 Get.back();
               }, child:Text('No')),
               content: Column(
                 children: [
                   Text("Are you sure delete this chat?"),
                   Text("Are you sure delete this chat?"),
                   Text("Are you sure delete this chat?"),
                 ],
               ),
             );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('GetX Bottom Sheet'),
              subtitle: Text('GetX dialog alart with getx'),
              onTap: (){
                Get.bottomSheet(
                  Container(

                    decoration: BoxDecoration(
                        color: Colors.teal,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      )
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.light_mode),
                          title: Text('Light'),
                          onTap: (){
                         Get.changeTheme(ThemeData.light());
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.dark_mode),
                          title: Text('Dark'),
                          onTap: (){
                            Get.changeTheme(ThemeData.dark());
                          },
                        ),
                        ListTile(
                          title: Text("Move to next Page"),
                          onTap: (){
                            Get.to(HomePage());
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.snackbar('Hussain Use Getx','Subscribe my channel',
          colorText: Colors.black,
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP,
            icon: Icon(Icons.account_balance),
            onTap: (SnackBar){

            },
            mainButton: TextButton(onPressed:(){
            }, child: Text("Main")),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
