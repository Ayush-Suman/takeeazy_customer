import 'package:takeeazy_customer/controller/optioncontroller.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/navigator/navigatorservice.dart';
import 'package:takeeazy_customer/model/takeeazyapis/categories/categoriesModel.dart';
import 'package:takeeazy_customer/model/takeeazyapis/items/itemsServices.dart';
import 'package:takeeazy_customer/model/takeeazyapis/stores/storesModel.dart';
import 'package:takeeazy_customer/screens/bottomnav/bottonnav.dart';

class ItemsController{
  final OptionController itemListController = OptionController();

  ShopModel shopModel;
  CategoriesModel categoriesModel;

  void updateValues(){
    shopModel = NavigatorService.homeArgument[HomeNavigator.shop];
    categoriesModel = NavigatorService.homeArgument[HomeNavigator.items];
  }

  void getItems() async{
    itemListController.updatedController.value = false;
      TEResponse response = await ItemsServices.getItemsByCategoryAndStore(category: categoriesModel.name, store:shopModel.id );
      try {
        itemListController.list = await response.response;
        itemListController.updatedController.value = true;
      }catch(e){
        print(e.toString());
      }
  }


}
