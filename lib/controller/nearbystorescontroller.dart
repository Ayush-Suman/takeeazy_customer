import 'package:flutter/cupertino.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/caching/runtimecaching.dart';
import 'package:takeeazy_customer/model/navigator/navigatorservice.dart';
import 'package:takeeazy_customer/model/takeeazyapis/containers/containersModel.dart';
import 'package:takeeazy_customer/model/takeeazyapis/stores/storesModel.dart';
import 'package:takeeazy_customer/model/takeeazyapis/stores/storesServices.dart';
import 'package:takeeazy_customer/screens/bottomnav/bottonnav.dart';


class StoresListController with ChangeNotifier{
  final ValueNotifier<bool> updatedController = ValueNotifier(false);
  List<ShopModel> _shops;
  List<ShopModel> get shops =>_shops;

  set shops(List<ShopModel> l){
    if(l!=_shops){
      _shops = l;
      notifyListeners();
    }
  }
}

class NearbyStoresController{
  final TextEditingController search = TextEditingController();
  final FocusNode searchFocus = FocusNode();
  final StoresListController storesListController = StoresListController();
  String lat;
  String lng;
  ContainerModel container;
  bool needUpdate;

  void openShop(ShopModel s){
    NavigatorService.homeArgument.addAll({HomeNavigator.shop: s});
    NavigatorService.homeNavigator.pushNamed(HomeNavigator.shop);
  }

  void updateValues() {
    HomeNavigator.currentPageIndex=2;
    storesListController.updatedController.value = false;
    if(container!=NavigatorService.homeArgument[HomeNavigator.stores]){
      container = NavigatorService.homeArgument[HomeNavigator.stores];
      needUpdate = true;
    }else{
      needUpdate=false;
    }
    lat = RuntimeCaching.lat;
    lng = RuntimeCaching.lng;

  }

  void getStoresNearby() async{
    if(needUpdate){
      TEResponse response = await StoresServices.getStoresByDistanceInAContainer(dist:50, container: container.id, latitude: lat, longitude: lng);
      storesListController.shops = await response.response;
    }
    storesListController.updatedController.value = true;
  }


}