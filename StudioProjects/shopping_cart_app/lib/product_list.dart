import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/cart_model.dart';
import 'package:shopping_cart_app/cart_provider.dart';
import 'package:shopping_cart_app/cart_screen.dart';
import 'package:shopping_cart_app/databases.dart';
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
   Databases? Dbase=Databases();
  List<String> productName=['Clock','Calculator','Game Console','Earbuds','Mouse','HeadPhones','Digital Camera','Wrist Watch'];
  List<String> productColors=['Grey/White','Slate/White','Black','Black','Gray','Orange/Black','Silver','Grey/Black'];
  List<String> productBrand=['All-Clad','LOGGERHEAD','Klein Tools','Bucket Boss','Klein Tools','LOGGERHEAD','Bucket Boss','Rulex'];
  List<String> productWeight=['0.66 Pounds','0.77 Pounds','0.88 Pounds','0.99 Pounds','0.86 Pounds','0.69 Pounds','0.77 Pounds','0.99 Pounds'];
  //List<String> productUnit=['KG','Dozen','KG','Dozen','KG','Kg','KG'];
  List<int> productPrice=[50,40,80,45,60,130,200,300];
  List<String> productImage=[
    'https://thumbs.dreamstime.com/b/alarm-clock-ringing-white-background-47546457.jpghttps://thumbs.dreamstime.com/b/alarm-clock-ringing-white-background-47546457.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAiA50kMqgPZMCW7MDjPEXt267l9P7OntP5HPJDcuuSQ&s',
    'https://images.unsplash.com/photo-1592840496694-26d035b52b48?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Z2FtZSUyMGNvbnNvbGV8ZW58MHx8MHx8fDA%3D',
    'https://images.unsplash.com/photo-1632200004922-bc18602c79fc?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8ZWFyYnVkc3xlbnwwfHwwfHx8MA%3D%3D',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0e9RtTVlv7VVNGdpAVU9P6MmKxfsvtaWIKDUUYcQiBA&s',
    'https://t4.ftcdn.net/jpg/03/28/37/93/360_F_328379347_xEKgEB2wkjAJmcqSTmrg4uKxfWrlL7D9.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsk0KJa-8Q1FomvDL9oxeh8g4eLMoDltyknhFK2Rllfw&s',
    'https://media.istockphoto.com/id/1180244659/photo/luxury-watch-isolated-on-white-background-with-clipping-path-for-artwork-or-design-black.jpg?s=612x612&w=0&k=20&c=yeFNfkQmcVV9BTUlZO8vY_oLOQgDAt23LfCbF1e3fbI='
  ];

  Widget build(BuildContext context) {
    final cart=Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(backgroundColor:Colors.cyan,title: Text("Product List"),centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
            },
            child: Center(
              child: badges.Badge(
                position: badges.BadgePosition.topEnd(top: -10, end: -12),
                badgeContent: Consumer<CartProvider>(
                  builder:(context,value,child){
                    return Text(value.getCounterValue().toString(),style: TextStyle(color: Colors.white));
                  },
                ),
                badgeAnimation:const badges.BadgeAnimation.rotation(
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
                child: Icon(Icons.shopping_cart,color: Colors.black,),
              ),
            ),
          ),
          SizedBox(width: 20,),
        ],),
      body: Column(
        children: [
          Expanded(child:
          ListView.builder(
              itemCount: productName.length,
              itemBuilder: (context,index)
              {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment:CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                               GestureDetector(
                                 onTap: (){
                                    showDialog(
                                       context: context, builder: (BuildContext context) {
                                     return AlertDialog(
                                       title: Text("Details",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                       content: IntrinsicHeight(
                                         child: Container(
                                           child:  Column(
                                             children: [
                                               Row(
                                                 children: [
                                                   Text("Color",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                   SizedBox(width: 30,),
                                                   Text(productColors[index].toString(),style: TextStyle(fontSize: 16),),
                                                 ],
                                               ),
                                               SizedBox(height: 10,),
                                               Row(
                                                 children: [
                                                   Text("Brand",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                   SizedBox(width: 30,),
                                                   Text(productBrand[index].toString(),style: TextStyle(fontSize: 16),),
                                                 ],
                                               ),
                                               SizedBox(height: 10,),
                                               Row(
                                                 children: [
                                                   Text("Material",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                   SizedBox(width: 30,),
                                                   Text("Plastic",style: TextStyle(fontSize: 16),),
                                                 ],
                                               ),
                                               SizedBox(height: 10,),
                                               Row(
                                                 children: [
                                                   Text("Item Weight",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                   SizedBox(width: 30,),
                                                   Text(productWeight[index].toString(),style: TextStyle(fontSize: 16),),
                                                 ],
                                               ),
                                               SizedBox(height: 10,),
                                               Row(
                                                 children: [
                                                   Text("Item Package \nQuantity",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                   SizedBox(width: 30,),
                                                   Text("1",style: TextStyle(fontSize: 16),),
                                                 ],
                                               ),
                                               SizedBox(height: 10,),
                                             ],
                                           ),
                                         ),
                                       ),
                                       actions: [
                                         TextButton(onPressed: (){
                                           Navigator.pop(context);
                                         },
                                             child: Text("Cancel")),

                                       ],
                                     );
                                   }
                                   );
                                 },
                                 child: Image(
                                  height: 100,
                                  width: 100,
                                  image: NetworkImage(productImage[index].toString()),
                                                               ),
                               ),

                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(productName[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                  SizedBox(height: 5,),
                                  Text(r"$"+productPrice[index].toString(),
                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 5,),

                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: (){
                                        Dbase!.insert(
                                          Cart(id: index,
                                              productId: index.toString(),
                                              productName: productName[index].toString(),
                                              initialPrice: productPrice[index],
                                              productPrice: productPrice[index],
                                              quantity:  1,
                                              image: productImage[index].toString()
                                          )
                                        ).then((value){
                                          print("data added Successfully");
                                          cart.addTotalPrice(double.parse( productPrice[index].toString()));
                                          cart.addCounter();

                                        }).onError((error, stackTrace){
                                          print("Error");
                                        });
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Center(
                                          child: Text('Add to cart',style: TextStyle(color: Colors.white),),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
          )
          ),

        ],
      ),
    );
  }

  Future<void> showMyDialog( )async{


  }

}



