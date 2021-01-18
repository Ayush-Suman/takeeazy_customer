import 'package:flutter/material.dart';
import 'package:takeeazy_customer/controller/optioncontroller.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/navigator/navigatorservice.dart';
import 'package:takeeazy_customer/model/takeeazyapis/categories/categoriesModel.dart';
import 'package:takeeazy_customer/model/takeeazyapis/stores/storesModel.dart';
import 'package:takeeazy_customer/model/takeeazyapis/categories/categoriesServices.dart';
import 'package:takeeazy_customer/screens/bottomnav/bottonnav.dart';

class ShopController {
  final OptionController categoriesController = OptionController();

  ShopModel shopModel;

  void updateValues(){
    shopModel  = NavigatorService.homeArgument[HomeNavigator.shop];
  }

  void getCategories() async{
    categoriesController.updatedController.value = false;
    TEResponse response =  await CategoriesServices.getCategoriesByContainer();
    try {
      List<CategoriesModel> categories = await response.response;
      List<String> ids = shopModel.categories.map((e) => e.categoryId).toList();
      categoriesController.list = categories.where((element) { print('Ids: ' + ids.toString()); return ids.contains(element.id);}).toList();
      categoriesController.updatedController.value = true;
    }catch(e){
      print(e.toString());
    }

  }

  openCategory(CategoriesModel c){
    NavigatorService.homeArgument.addAll({HomeNavigator.items: c});
    NavigatorService.homeNavigator.pushNamed(HomeNavigator.items);
  }


}



