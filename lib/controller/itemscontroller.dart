import 'package:takeeazy_customer/controller/optioncontroller.dart';
import 'package:takeeazy_customer/controller/textcontroller.dart';
import 'package:takeeazy_customer/model/base/caching.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/navigator/navigatorservice.dart';
import 'package:takeeazy_customer/model/takeeazyapis/categories/categoriesModel.dart';
import 'package:takeeazy_customer/model/takeeazyapis/items/itemsModel.dart';
import 'package:takeeazy_customer/model/takeeazyapis/items/itemsServices.dart';
import 'package:takeeazy_customer/model/takeeazyapis/options/optionsmodel.dart';
import 'package:takeeazy_customer/model/takeeazyapis/stores/storesModel.dart';
import 'package:takeeazy_customer/screens/bottomnav/bottonnav.dart';

class ItemsController {
  final OptionController itemListController = OptionController();
  final List<TextController> quantities = List();
  List<Map> cartData = List();
  ShopModel shopModel;
  CategoriesModel categoriesModel;

  void updateValues() {
    readData('cart').then((value) {
      cartData = value.cast<Map>();
      print(value);
    });
    itemListController.addListener(() {
      if (itemListController.list != null) {
        int diff = itemListController.list.length - quantities.length;
        if (diff > 0) {
          for (int i = 0; i < diff; i++) {
            quantities.add(TextController());
            quantities[quantities.length - 1].text = '0';
          }
        }
        for (int i = 0; i < itemListController.list.length; i++) {
          Map single;
          try {
            single = cartData.singleWhere((element) =>
                element['id'] == (itemListController.list[i]).id);
          } catch (e) {}
          if (single != null) {
            quantities[i].text = single['quan'];
          } else {
            quantities[i].text = '0';
          }
        }
      }
    });

    shopModel = NavigatorService.homeArgument[HomeNavigator.shop];
    categoriesModel = NavigatorService.homeArgument[HomeNavigator.items];
  }

  void updateCart(OptionsModel item, String quantity) async {
    if (cartData != null) {
      cartData.removeWhere((value) => (value['id'] == item.id));
    } else {
      cartData = List<Map>();
    }
    if (quantity != '0') {
      Map data = {
        'id': item.id,
        'name': item.name,
        'quan': quantity,
        'imageURL': item.imageURL,
        'shopName': shopModel.shopName,
      };
      cartData.add(data);
    }
    storeData(cartData, 'cart');
  }

  void getItems() async {
    itemListController.updatedController.value = false;
    TEResponse response = await ItemsServices.getItemsByCategoryAndStore(
        category: categoriesModel.id, store: shopModel.id);
    try {
      List<ItemsModel> itemsList = await response.response;
      List<OptionsModel> items = [];
      itemsList.forEach((e) {
        e.variants.forEach(
          (element) {
            items.add(
              OptionsModel(
                imageURL: e.imageURL,
                name: e.name.toString() + ' - ' + element.variantName,
                id: element.id,
              ),
            );
          },
        );
      });
      itemListController.list = items;
      itemListController.updatedController.value = true;
    } catch (e) {
      print(e.toString());
    }
  }
}
