import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_states_manage/favourite/my_favourite.dart';
import 'package:provider_states_manage/provider/favourite_provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {

    //final favouriteProvider = Provider.of<FavouriteProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Farite Screen"),
        centerTitle: true,
        actions: [
          InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyFavouriteItemScreen()));
              },
              child: Icon(Icons.favorite)),
          SizedBox(width: 20,)
        ],
      ),
      body: Column(
        children: [
      Expanded(
      child: ListView.builder(
          itemCount: 70,
          itemBuilder: (context, index) {
             return Consumer<FavouriteProvider>(builder:(context,value,child){
               return ListTile(
                 onTap: () {
                   if(value.selectedItem.contains(index))
                     {
                       value.removeIndex(index);
                     }
                   else
                   {
                     value.getIndex(index);
                   }
                 },

                 title: Text("Item" + index.toString()),
                 trailing: Icon(
                   value.selectedItem.contains(index) ? Icons.favorite : Icons.favorite_border_outlined,
                 ),
               );
             });
          }),
    ),
        ],
      ),
    );
  }
}
