import 'package:flutter/cupertino.dart';
import 'package:takeeazy_customer/screens/controller/optioncontroller.dart';
import 'package:takeeazy_customer/screens/controller/textcontroller.dart';
import 'package:takeeazy_customer/model/base/caching.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/navigator/navigatorservice.dart';
import 'package:takeeazy_customer/model/takeeazyapis/categories/categoriesModel.dart';
import 'package:takeeazy_customer/model/takeeazyapis/items/itemsModel.dart';
import 'package:takeeazy_customer/model/takeeazyapis/items/itemsServices.dart';
import 'package:takeeazy_customer/model/takeeazyapis/stores/storesModel.dart';
import 'package:takeeazy_customer/screens/bottomnav/bottonnav.dart';



class ItemsController{
  final OptionController<ItemsModel> itemListController = OptionController();
  final List<TextController> quantities = List();
  final List<ValueNotifier<Variants>> valueControllers = List();

  List<Map> cartData = List();
  ShopModel shopModel;
  CategoriesModel categoriesModel;
  bool needUpdate;

  void updateValues(){
    HomeNavigator.currentPageIndex=3;
    try{
    readData('cart').then((value) {
      cartData = value.cast<Map>();
      print(value);
    });
    }catch(e){
      print(e.toString());
    }
    itemListController.addListener(() {
      valueControllers.removeWhere((e)=>true);
      if(itemListController.list!=null) {
        int diff = itemListController.list.length - quantities.length;
          if (diff > 0) {
            for (int i = 0; i < diff; i++) {

              quantities.add(TextController());
              quantities[quantities.length - 1].text = '0';
            }
          }

        for (int i = 0; i < itemListController.list.length; i++) {
          Map single;
          try{
          single = cartData.singleWhere((element) => element['id']==itemListController.list[i].id);
          }catch(e){

          }
          if(single!=null){
            quantities[i].text = single['quan'];
            itemListController.list[i].selectedVariant = Variants.fromJSON(single['selectedVariants']);
          }else {
            quantities[i].text = '0';
            itemListController.list[i].selectedVariant = itemListController.list[i].variants[0];
          }
          valueControllers.add(ValueNotifier(itemListController.list[i].selectedVariant));
        }
      }});

    if((shopModel != NavigatorService.homeArgument[HomeNavigator.shop]) || (categoriesModel != NavigatorService.homeArgument[HomeNavigator.items]) ){
      shopModel = NavigatorService.homeArgument[HomeNavigator.shop];
      categoriesModel = NavigatorService.homeArgument[HomeNavigator.items];
      needUpdate=true;
    }else{
      needUpdate=false;
    }
  }


  void updateCart(ItemsModel item, String quantity) async{
    if(cartData!=null) {
      cartData.removeWhere((value) => (value['id'] == item.id));
    }else{
      cartData = List<Map>();
    }
    if(quantity!='0') {
      Map data = {
        'id': item.id,
        'name': item.name,
        'quan': quantity,
        'imageURL': item.imageURL,
        'variants': item.variants.map((e) => e.toJson).toList(),
        'selectedVariants': item.selectedVariant.toJson
      };
      cartData.add(data);
    }
    storeData(cartData, 'cart');

  }


  void getItems() async{
    itemListController.updatedController.value = false;
    if(needUpdate){
      TEResponse response = await ItemsServices.getItemsByCategoryAndStore(category: categoriesModel.id, store:shopModel.id );
      try {
        itemListController.list = await response.response;
      }catch(e){
        print(e.toString());
      }
    }
    itemListController.updatedController.value = true;
  }


}
