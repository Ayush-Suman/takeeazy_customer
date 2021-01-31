import 'package:takeeazy_customer/screens/controller/optioncontroller.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/navigator/navigatorservice.dart';
import 'package:takeeazy_customer/model/takeeazyapis/categories/categoriesModel.dart';
import 'package:takeeazy_customer/model/takeeazyapis/stores/storesModel.dart';
import 'package:takeeazy_customer/model/takeeazyapis/categories/categoriesServices.dart';
import 'package:takeeazy_customer/screens/bottomnav/bottonnav.dart';


class ShopController {
  final OptionController categoriesController = OptionController();

  ShopModel shopModel;
  bool needUpdate;

  void updateValues(){
    HomeNavigator.currentPageIndex=3;
    if(shopModel!=NavigatorService.homeArgument[HomeNavigator.shop]){
      shopModel  = NavigatorService.homeArgument[HomeNavigator.shop];
      needUpdate=true;
    }else{
      needUpdate=false;
    }

  }

  void getCategories() async{
    categoriesController.updatedController.value = false;
    if(needUpdate) {
      TEResponse response = await CategoriesServices.getCategoriesByContainer();
      try {
        List<CategoriesModel> categories = await response.response;
        List<String> ids = shopModel.categories.map((e) => e.categoryId)
            .toList();
        categoriesController.list = categories.where((element) {
          print('Ids: ' + ids.toString());
          return ids.contains(element.id);
        }).toList();

      } catch (e) {
        print(e.toString());
      }
    }
    categoriesController.updatedController.value = true;
  }

  openCategory(CategoriesModel c){
    NavigatorService.homeArgument.addAll({HomeNavigator.items: c});
    NavigatorService.homeNavigator.pushNamed(HomeNavigator.items);
  }


}
