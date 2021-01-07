import 'package:flutter/cupertino.dart';

class ServiceableArea with ChangeNotifier{
  bool _serviceAvailable = false;
  bool get serviceAvailable =>_serviceAvailable;
  set serviceAvailable(bool s){
    if(s!=_serviceAvailable){
      _serviceAvailable = s;
      notifyListeners();
    }
  }
}