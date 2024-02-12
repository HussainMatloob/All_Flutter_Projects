import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomePage4 extends StatefulWidget {
  const HomePage4({super.key});

  @override
  State<HomePage4> createState() => _HomePage4State();
}

class _HomePage4State extends State<HomePage4> {
  @override
  var data;
  Future<void> getUserApi()
  async {
    final response=await http.get(Uri.parse('http://jsonplaceholder.typicode.com/users'));

     if(response.statusCode==200) {
       data = jsonDecode(response.body.toString());
     }
     else
       {

       }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("complex Json not solve with Plugin"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(future: getUserApi(),
                builder:(context,snapshot)
            {
              if(snapshot.connectionState==ConnectionState.waiting)
                {
                  return Text("Loading");
                }
              else
                {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder:(context,index)
                  {
                    return Card(
                      child: Column(
                        children: [
                         ReuseableRow(title:'Name', value: data[index]['name']),
                          ReuseableRow(title:'Email', value: data[index]['email']),
                          ReuseableRow(title:'address', value: data[index]['address']['geo']['lat']),
                        ],
                      ),
                    );
                  });
                }
            }),
          ),
        ],
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title,value;
  ReuseableRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}