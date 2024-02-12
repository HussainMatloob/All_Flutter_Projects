import 'package:flutter/foundation.dart';

class CountProvider with ChangeNotifier{

  int _count=0;
  get count=>_count;

  double _value=1.0;
  get value=>_value;

  getcount()
  {
    _count++;
    notifyListeners();
  }

  getSlideVale(double val)
  {
    _value=val;
  }
}