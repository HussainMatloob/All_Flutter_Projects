import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderState with ChangeNotifier{

  double _finalAmount=0.0;

  double get finalAmount=>_finalAmount;

  int _WalletCash=0;
  int get WalletCash => _WalletCash;

  int _BankCash=0;
  int get bankCash => _BankCash;

  void _setPrefItems()
  async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setInt('wallet_cash',_WalletCash);
    prefs.setInt('bank_cash',_BankCash);
    notifyListeners();
  }

  void _getPrefItems()
  async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    _WalletCash=prefs.getInt('wallet_cash') ?? 0;
    _BankCash=prefs.getInt('bank_cash')?? 0;
    notifyListeners();
  }

  void subtractInWallet(int productPrice)
  {
    _WalletCash-=productPrice;
    _setPrefItems();
    notifyListeners();
  }
  void subtractInBank(int productPrice)
  {
    _BankCash-=productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void addInWallet(int walletAmount)
  {
    _WalletCash+=walletAmount;
    _setPrefItems();
    notifyListeners();
  }
  void addInBank(int productPrice)
  {
    _BankCash+=productPrice;
    _setPrefItems();
    notifyListeners();
  }

  int getTotalInWallet()
  {
    _getPrefItems();
    return _WalletCash;
  }

  int getTotalInBank()
  {
    _getPrefItems();
    return _BankCash;
  }

  void setTotalExpense(double total)
  {
    _finalAmount=total;
    notifyListeners();
  }

  void setTotalIfNotMatch(double total)
  {
    _finalAmount=total;
    notifyListeners();
  }

}
