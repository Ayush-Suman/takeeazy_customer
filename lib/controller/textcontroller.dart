import 'package:flutter/cupertino.dart';

class TextController with ChangeNotifier{
  String _text;

  int i=0;
  get text => _text;

  set text(String t){
    if(t != text){
      i++;
      print("Updating Text with $t $i");
      _text = t;
      notifyListeners();
    }
  }
}



