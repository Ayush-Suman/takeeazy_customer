
import 'package:flutter/cupertino.dart';
import 'package:takeeazy_customer/model/dialog/dialogservice.dart';
import 'package:takeeazy_customer/screens/controller/optioncontroller.dart';
import 'package:takeeazy_customer/screens/controller/textcontroller.dart';
import 'package:takeeazy_customer/model/base/caching.dart';
import 'package:takeeazy_customer/model/navigator/navigatorservice.dart';
import 'package:takeeazy_customer/model/takeeazyapis/cart/cartmodel.dart';
import 'package:takeeazy_customer/model/takeeazyapis/items/itemsModel.dart';
import 'package:takeeazy_customer/screens/bottomnav/bottonnav.dart';

class CartController {

  final OptionController<CartModel> cartListController = OptionController()..list=List();
  final List<TextController> quantities = List();
  List<Map> cartData = List();

  final List<ValueNotifier<Variants>> valueControllers = List();

  void updateValues() {
      readData('cart').then((value) {
        cartData = value.cast<Map>();
        print(value);
        cartListController.list = cartData.map((e) =>
            CartModel(id: e['id'],
                name: e['name'],
                quantity: int.parse(e['quan']),
                imageURL: e['imageURL'],
                variants: (e['variants'] as List).map((m) =>
                    Variants.fromJSON(m)).toList().cast<Variants>(),
                selectedVariant: Variants.fromJSON(e['selectedVariants'])
            )).toList();
        cartListController.updatedController.value = true;
      }).catchError((onError){
        print("No cart item");
        cartListController.updatedController.value = true;

      });
    cartListController.addListener(() {
      quantities.removeWhere((element) => true);
      valueControllers.removeWhere((element) => true);
      if (cartListController.list != null) {
        for (int i = 0; i < cartListController.list.length; i++) {
          Map single = cartData.singleWhere((element) =>
          element['id'] == cartListController.list[i].id);
          quantities.add(TextController());
          quantities[i].text = single['quan'];
          valueControllers.add(
              ValueNotifier(Variants.fromJSON(single['selectedVariants'])));
        }
      }
    });
  }

  void updateCart(CartModel item, String quantity) async{
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

  void orderNow(bool containItem) {
    if(containItem){
    NavigatorService.cartArgument.addAll({CartNavigator.cart: cartData});
    NavigatorService.cartNavigator.pushNamed(CartNavigator.orders);
    }else{
      DialogService()
          .openDialog(
          title: "No Item in the Cart",
          content: "Continue shopping before proceeding to order",
          actions: [ActionHolder(title: "Continue shopping", onPressed: (){})]);
    }
  }

}
