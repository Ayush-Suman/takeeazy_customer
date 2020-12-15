import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocation with ChangeNotifier{
  Position _position;

  get position=>_position;

  set position(p){
    if(_position != p){
      _position = p;
      notifyListeners();
    }
  }
}
