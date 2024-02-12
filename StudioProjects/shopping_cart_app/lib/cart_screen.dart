import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shopping_cart_app/cart_model.dart';
import 'package:shopping_cart_app/cart_provider.dart';
import 'package:shopping_cart_app/databases.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Databases? Dbase=Databases();
  @override
  Widget build(BuildContext context) {
    final cart=Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(backgroundColor:Colors.cyan,title: Text("My Product"),centerTitle: true,
        actions: [
          Center(
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
          SizedBox(width: 20,),
        ],),
      body: Column(
        children: [
          FutureBuilder(
              future: cart.getData(),
              builder:(context,AsyncSnapshot<List<Cart>> snapshot){
            if(snapshot.hasData)
              {
                if(snapshot.data!.isEmpty)
                  {
                       return const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 50,),
                          Center(child: Image(image: AssetImage('Images/BoxEmpty.jpg'))),
                          Text("Box is Empty",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                          Text("Please add any Item",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ],
                      );
                      //child: Center(child: Image.network('https://st4.depositphotos.com/18290558/29891/i/380/depositphotos_298919884-stock-illustration-3d-cartoon-prehistoric-caveman-character.jpg')),

                  }
                else{
                  return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
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
                                        Image(
                                          height: 100,
                                          width: 100,
                                          image: NetworkImage(snapshot.data![index].image.toString()),
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(snapshot.data![index].productName.toString(),
                                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                                  InkWell(
                                                      onTap: (){
                                                        Dbase!.delete(snapshot.data![index].id!);
                                                        cart.removeCounter();
                                                        cart.removeTotalPrice(double.parse(snapshot.data![index].productPrice.toString()));
                                                      },
                                                      child: Icon(Icons.delete)),
                                                ],
                                              ),
                                              SizedBox(height: 5,),
                                              Text(r"$"+snapshot.data![index].productPrice.toString(),
                                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                                              ),
                                              SizedBox(height: 5,),

                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: InkWell(
                                                  onTap: (){

                                                  },
                                                  child: Container(
                                                    height: 35,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius: BorderRadius.circular(5)
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children:[
                                                            InkWell(
                                                                onTap: (){
                                                                  int quantity=snapshot.data![index].quantity!;
                                                                  int price=snapshot.data![index].initialPrice!;
                                                                  quantity++;
                                                                  int? newPrice=price*quantity;
                                                                  Dbase!.updateQuantity(
                                                                      Cart(
                                                                          id: snapshot.data![index].id,
                                                                          productId:snapshot.data![index].productId.toString(),
                                                                          productName: snapshot.data![index].productName.toString(),
                                                                          initialPrice: snapshot.data![index].initialPrice,
                                                                          productPrice: newPrice,
                                                                          quantity: quantity,
                                                                          image: snapshot.data![index].image.toString())).then((value){
                                                                    newPrice=0;
                                                                    quantity=0;
                                                                    cart.addTotalPrice(double.parse(snapshot.data![index].initialPrice!.toString()));
                                                                  }).onError((error, stackTrace){
                                                                    print(error.toString());
                                                                  });
                                                                },
                                                                child: Icon(Icons.add,color: Colors.white,)),
                                                            Text(snapshot.data![index].quantity.toString(),
                                                              style: TextStyle(fontSize: 20,color: Colors.white),),
                                                            InkWell(
                                                                onTap: ()
                                                                {
                                                                  int quantity=snapshot.data![index].quantity!;
                                                                  if(quantity>1)
                                                                  {
                                                                    int price=snapshot.data![index].initialPrice!;
                                                                    quantity--;
                                                                    int? newPrice=price*quantity;
                                                                    Dbase!.updateQuantity(
                                                                        Cart(
                                                                            id: snapshot.data![index].id,
                                                                            productId:snapshot.data![index].productId.toString(),
                                                                            productName: snapshot.data![index].productName.toString(),
                                                                            initialPrice: snapshot.data![index].initialPrice,
                                                                            productPrice: newPrice,
                                                                            quantity: quantity,
                                                                            //unitTag: snapshot.data![index].unitTag.toString(),
                                                                            image: snapshot.data![index].image.toString())).then((value){
                                                                      newPrice=0;
                                                                      quantity=0;
                                                                      cart.removeTotalPrice(double.parse(snapshot.data![index].initialPrice!.toString()));
                                                                    }).onError((error, stackTrace){
                                                                      print(error.toString());
                                                                    });
                                                                  }
                                                                },
                                                                child: Icon(Icons.remove,color: Colors.white,))
                                                          ]
                                                      ),
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
                  );
                }

              }
            return Text("data");




          }),
          Consumer<CartProvider>(builder: (context,value,child){
            return Visibility(
              visible: value.getTotalPrice().toStringAsFixed(2)=='0.00' ? false : true,
              child: Column(
                children: [
                  ReuseableWidget(title: 'Total', value:r'$'+value.getTotalPrice().toStringAsFixed(2)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class ReuseableWidget extends StatelessWidget {
  String title;
  String value;
  ReuseableWidget({required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green)),
          SizedBox(width: 5,),
          Text(value.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green)),
        ],
      ),
    );
  }
}