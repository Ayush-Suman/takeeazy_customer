import 'package:takeeazy_customer/model/base/URLRoutes.dart' as Routes;
import 'package:takeeazy_customer/model/stores/storesModel.dart';

dynamic createClass(String type, Map<String, dynamic> map){
  switch(type){
    case Routes.getShops:
      ShopModel.fromJSON(map);
      break;
    default: return null;
  }
}