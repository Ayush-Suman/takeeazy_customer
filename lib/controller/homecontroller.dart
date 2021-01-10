import 'package:flutter/cupertino.dart';
import 'package:takeeazy_customer/controller/serviceablearea.dart';
import 'package:takeeazy_customer/controller/textcontroller.dart';
import 'package:takeeazy_customer/model/base/caching.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/takeeazyapis/containers/containerServices.dart';
import 'package:takeeazy_customer/model/takeeazyapis/containers/containersModel.dart';


class HomeController{

  final TextController city = TextController();
  final TextEditingController search = TextEditingController();
  final FocusNode searchFocus = FocusNode();
  final ServiceableArea serviceableAreaController = ServiceableArea();
  final UpdatedController updatedController = UpdatedController();
  final ContainerListController containerListController = ContainerListController();


  void getContainers({bool forced=false}) async{
    if(!containerListController.containerUpdatedController.isUpdated || forced){
    TEResponse response = await ContainerServices.getContainers();
    containerListController.containerList = await response.response;
    containerListController.containerUpdatedController.isUpdated = true;
    }
  }


  void updateValues() async{
      Map data = await readData("City");
      city.text = data['city'];
      serviceableAreaController.serviceAvailable = data['ser'];
      updatedController.isUpdated = true;
  }


}



class ContainerListController with ChangeNotifier{
  final UpdatedController containerUpdatedController = UpdatedController();

  List<ContainerModel> _containerList;
  List<ContainerModel> get containerList => _containerList;
  set containerList(List<ContainerModel> list){
    if(list!=_containerList){
      _containerList = list;
      notifyListeners();
    }
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



