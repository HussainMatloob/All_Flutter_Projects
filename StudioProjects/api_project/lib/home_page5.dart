import 'dart:convert';

import 'package:api_project/Models/product_model.dart';
import 'package:api_project/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage5 extends StatefulWidget {
  const HomePage5({super.key});

  @override
  State<HomePage5> createState() => _HomePage5State();
}

class _HomePage5State extends State<HomePage5> {
  @override
 // var data;
  Future<ProductsModel> getComplexData()
  async{
    final response=await http.get(Uri.parse('https://webhook.site/d24f9761-dfba-4759-bcda-f42f3dd539b7'));

    var data=jsonDecode(response.body.toString());
    if(response==200)
      {
        return ProductsModel.fromJson(data);
      }
    else
      {
        return ProductsModel.fromJson(data);
      }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("complex Json start with object"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ProductsModel>(
                  future:getComplexData(),
                  builder:(context,snapshot){
                if(!snapshot.hasData)
                  {
                    return Text("Loading");
                  }
                else
                  {
                    return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        //itemCount: data.length,
                        itemBuilder: (context,index){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(snapshot.data!.data![index].shop!.name.toString()),
                            subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                            ),
                          ),
                             Container(
                               height:MediaQuery.of(context).size.height*.3,
                               width:MediaQuery.of(context).size.width*.3,
                               child: ListView.builder(
                                 scrollDirection: Axis.horizontal,
                                   itemCount:snapshot.data!.data![index].images!.length,
                                   itemBuilder:(context,postion)
                               {
                                 return Padding(
                                   padding: const EdgeInsets.only(right: 10),
                                   child: Container(
                                     height:MediaQuery.of(context).size.height*.25,
                                     width:MediaQuery.of(context).size.width*.5,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(10),
                                       image: DecorationImage(
                                         fit: BoxFit.cover,
                                         image: NetworkImage(snapshot.data!.data![index].images![postion].url.toString())

                                       )
                                     ),
                                   ),
                                 );
                               }),
                             ),
                          Icon(snapshot.data!.data![index].inWishlist==false ? Icons.favorite: Icons.favorite_outlined)
                        ],
                      );
                      });

                  }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
