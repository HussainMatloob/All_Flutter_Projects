import 'package:flutter/foundation.dart';

class  ExampleOneProvider with ChangeNotifier{


  double _value=1.0;
  get value=>_value;

 void setSlideVale(double val)
  {
    _value=val;
    notifyListeners();
  }
}