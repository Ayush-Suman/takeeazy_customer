import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:takeeazy_customer/screens/controller/optioncontroller.dart';
import 'package:takeeazy_customer/screens/controller/textcontroller.dart';

import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/caching/runtimecaching.dart';
import 'package:takeeazy_customer/model/navigator/navigatorservice.dart';
import 'package:takeeazy_customer/model/takeeazyapis/containers/containerServices.dart';
import 'package:takeeazy_customer/model/takeeazyapis/containers/containersModel.dart';
import 'package:takeeazy_customer/screens/bottomnav/bottonnav.dart';


class HomeController{

  final TextController city = TextController();
  final TextEditingController search = TextEditingController();
  final FocusNode searchFocus = FocusNode();
  final ValueNotifier<bool> serviceableAreaController = ValueNotifier<bool>(false);
  final ValueNotifier<bool> updatedController = ValueNotifier<bool>(false);
  final OptionController containerListController = OptionController();

  void openContainer(ContainerModel c){
    NavigatorService.homeArgument.addAll({HomeNavigator.stores:c});
    NavigatorService.homeNavigator.pushNamed(HomeNavigator.stores);
  }

  void getContainers({bool forced=false}) async{
    if(!containerListController.updatedController.value || forced){
      TEResponse response = await ContainerServices.getContainers();
      try{
        containerListController.list = await response.response;
        containerListController.updatedController.value = true;
      }catch(e){
        if(e is SocketException){
          print('No Internet');
        }
      }
    }
  }


  void updateValues() async{
    HomeNavigator.currentPageIndex=1;
      city.text = RuntimeCaching.city;
      serviceableAreaController.value = RuntimeCaching.serviceableArea;
      updatedController.value = true;
  }


}








