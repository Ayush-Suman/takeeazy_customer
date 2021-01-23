import 'package:flutter/cupertino.dart';
import 'package:takeeazy_customer/controller/textcontroller.dart';
import 'package:takeeazy_customer/model/base/caching.dart';
import 'package:takeeazy_customer/model/navigator/navigatorservice.dart';
import 'package:takeeazy_customer/model/takeeazyapis/cart/cartmodel.dart';
import 'package:takeeazy_customer/screens/bottomnav/bottonnav.dart';

class CartController {

  final CartListController cartListController = CartListController();
  final List<TextController> quantities = List();
  List<Map> cartData = List();

  void updateValues() {
    readData('cart').then((value) {
      cartData = value.cast<Map>();
      print(value);
      cartListController.list = cartData.map((e) => CartModel(id: e['id'], name: e['name'], quantity: int.parse(e['quan']), imageURL: e['imageURL'])).toList();
      cartListController.updatedController.value=true;
    });
    cartListController.addListener(() {
      if(cartListController.list!=null) {
        int diff = cartListController.list.length - quantities.length;
        if (diff > 0) {
          for (int i = 0; i < diff; i++) {
            quantities.add(TextController());
            quantities[quantities.length - 1].text = '0';
          }
        }
        for (int i = 0; i < cartListController.list.length; i++) {
          Map single;
          try{
            single = cartData.singleWhere((element) => element['id']==cartListController.list[i].id);
          }catch(e){

          }
          if(single!=null){
            quantities[i].text = single['quan'];
          }else {
            quantities[i].text = '0';
          }
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
        'imageURL': item.imageURL
      };
      cartData.add(data);
    }
    storeData(cartData, 'cart');

  }

  void orderNow(){
    NavigatorService.cartNavigator.pushNamed(CartNavigator.orders);
  }
}

class CartListController with ChangeNotifier{
  final ValueNotifier<bool> updatedController = ValueNotifier(false);

  List<CartModel> _list;
  List<CartModel> get list => _list;
  set list(List<CartModel> list){
    if(list!=_list){
      _list = list;
      notifyListeners();
    }
  }

}