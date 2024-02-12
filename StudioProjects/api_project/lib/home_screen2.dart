import 'dart:convert';

import'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  
  List<Photos> photosList=[];
  @override
  
  Future<List<Photos>> getPhotos() async{
    final response=await http.get(Uri.parse('http://jsonplaceholder.typicode.com/photos'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200)
      {
        for(Map i in data)
          {
            Photos photos=Photos(title: i['title'], url: i['url'],id:i['id']);
            photosList.add(photos);
          }
        return photosList;
      }
    else
      {
         return photosList;
      }
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,title: Text("API2 Manual Model"),),
      
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context,AsyncSnapshot<List<Photos>> snapshot){
              return ListView.builder(
                itemCount: photosList.length,
                  itemBuilder: (context,index){
                  return ListTile(
                    leading: CircleAvatar(backgroundImage:
                    NetworkImage(snapshot.data![index].url.toString())),
                    title: Text('ID: '+snapshot.data![index].id.toString()),
                    subtitle: Text(photosList[index].title.toString()),
                  );
                  }
              );
            }),
          )
        ],
      ),

    );
  }
}

class Photos{
  String title,url;
  int id;
  Photos({
    required this.title,required this.url,required this.id,
  });
}