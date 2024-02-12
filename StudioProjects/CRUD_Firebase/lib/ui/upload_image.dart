import 'dart:ffi';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import'package:flutter/material.dart';
import 'package:home_expense_app/utils/utils.dart';
import 'package:home_expense_app/widgets/round_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {

  bool loading=false;
  firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef=FirebaseDatabase.instance.ref('Post');

  File? _image;
  final picker=ImagePicker();
  Future getImageGallery() async{
final pickedFile=await picker.pickImage(source: ImageSource.gallery,imageQuality: 100);
setState(() {
  if(pickedFile!=null)
  {
    _image= File(pickedFile.path);
  }
  else{
    print("No Image Picked");
  }
});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Image Page"),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Center(
            child: InkWell(
              onTap:() {
                getImageGallery();
              },
              child: Container(
                child:_image !=null ? Image.file(_image!.absolute)
                    : Center(child: Icon(Icons.image)),
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color:Colors.black),

                ),
              ),
            ),
          ),
            SizedBox(height: 30,),
            RoundButton(title: 'Upload',loading:loading, onTap:() async{

              setState(() {
                loading=true;
              });

              firebase_storage.Reference ref=firebase_storage.FirebaseStorage.instance.ref('/foldername/'+DateTime.now().millisecondsSinceEpoch.toString());
              firebase_storage.UploadTask uploadTask= ref.putFile(_image!.absolute);

               Future.value(uploadTask).then((value)async{
                var newurl=await ref.getDownloadURL();

                databaseRef.child('1').set({
                  'id':'1212',
                  'title':newurl.toString(),
                }).then((value) {
                  setState(() {
                    loading=false;
                  });
                  Utils().toastMessage("Uploaded");
                }).onError((error, stackTrace) {
                  setState(() {
                    loading=false;
                    Utils().toastMessage(error.toString());
                  });
                });
              });
            })
          ],
        ),
      ),
    );
  }
}
