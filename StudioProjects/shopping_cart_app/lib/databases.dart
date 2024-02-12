import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:shopping_cart_app/cart_model.dart';
class Databases
{
  static Database? _db;

  Future<Database?> get db async{
    if(_db!=null)
      {
        return _db!;
      }
    else
      {
        _db =await initDatabase();
      }
  }
  initDatabase()
  async{
    io.Directory documentDirectory=await  getApplicationCacheDirectory();
    String path=join(documentDirectory.path,'cart.db');
    var db =await openDatabase(path,version: 1,onCreate: _onCreate,);
    return db;
  }
  _onCreate (Database db,int version)
  async{
    await db.execute('Create Table cart (id Int Primary Key,productId VARCHAR UNIQUE,productName VARCHAR,initialPrice int,productPrice int ,quantity int,image VARCHAR)');

  }
  Future<Cart> insert(Cart cart)
  async{
    var dbClient=await db;
    await dbClient!.insert('cart', cart.toMap());
    return cart;
  }

  Future<List<Cart>> getCartList()
  async{
    var dbClient=await db;
    final List<Map<String,Object?>> queryResult=await dbClient!.query('cart');
    return queryResult.map((e) => Cart.fromMap(e)).toList();
     }

     Future<int> delete(int id)
     async{
       var dbClient=await db;
       return await dbClient!.delete(
         'cart',
         where: 'id=?',
         whereArgs: [id]
       );
     }

  Future<int> updateQuantity(Cart cart)
  async{
    var dbClient=await db;
    return await dbClient!.update(
        'cart ',
        cart.toMap(),
        where: 'id=?',
        whereArgs: [cart.id]
    );
  }

}