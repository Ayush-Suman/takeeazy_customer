import 'package:flutter/cupertino.dart';
import 'package:takeeazy_customer/caching/caching.dart';
import 'package:takeeazy_customer/controller/serviceablearea.dart';
import 'package:takeeazy_customer/controller/textcontroller.dart';


class HomeController{

  final TextController city = TextController();
  final ServiceableArea serviceableAreaController = ServiceableArea();

  void updateValues(){
    city.text = Caching.city;
    serviceableAreaController.serviceAvailable = Caching.serviceableArea;
  }

}



