import 'package:flutter/cupertino.dart';

class TextController with ChangeNotifier{
  String _text;

  get text => _text;

  set text(String t){
    if(t != text){
      _text = t;
      notifyListeners();
    }
  }
}



