import 'package:flutter/cupertino.dart';
import 'package:takeeazy_customer/caching/caching.dart';
import 'package:takeeazy_customer/controller/serviceablearea.dart';
import 'package:takeeazy_customer/controller/textcontroller.dart';
import 'package:takeeazy_customer/model/base/caching.dart';


class HomeController{

  final TextController city = TextController();
  final ServiceableArea serviceableAreaController = ServiceableArea();
  final UpdatedController updatedController = UpdatedController();

  void updateValues() async{
    Map data = await readData("City");
    city.text = data['city'];
    serviceableAreaController.serviceAvailable = data['ser'];
    updatedController.isUpdated = true;
  }


}

class UpdatedController with ChangeNotifier{
  bool _updated = false;
  bool get isUpdated=>_updated;
  set isUpdated(bool u){
    if(u!=_updated){
      _updated = u;
      notifyListeners();
    }
  }

}



