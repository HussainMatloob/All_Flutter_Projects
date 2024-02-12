import 'package:flutter/foundation.dart';

class FavouriteProvider with ChangeNotifier {

  List<int> _selectedItem=[];
  get selectedItem=>_selectedItem;

  void getIndex(int IndexItem)
  {
    _selectedItem.add(IndexItem);
    notifyListeners();
  }

  void removeIndex(int IndexItem)
  {
    _selectedItem.remove(IndexItem);
    notifyListeners();
  }
}