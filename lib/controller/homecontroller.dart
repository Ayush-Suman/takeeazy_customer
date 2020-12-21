import 'package:flutter/cupertino.dart';
import 'package:takeeazy_customer/caching/caching.dart';
import 'package:takeeazy_customer/controller/textcontroller.dart';


class HomeController with ChangeNotifier{

  final TextController city = TextController();
  final ServiceableArea serviceableAreaController = ServiceableArea();
  void updateValues(){
    city.text = Caching.city;
    serviceableAreaController.serviceableArea = Caching.serviceableArea;
  }

}

class ServiceableArea with ChangeNotifier{
  bool _isServiceable;
  get serviceableArea => _isServiceable;
  set serviceableArea(bool s){
    if(s!=_isServiceable){
      _isServiceable = s;
      notifyListeners();
    }

  }
}



