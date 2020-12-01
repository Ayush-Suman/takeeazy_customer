import 'package:takeeazy_customer/model/base/URLRoutes.dart' as Routes;
import 'package:takeeazy_customer/model/meta/metamodel.dart';
import 'package:takeeazy_customer/model/stores/storesModel.dart';

dynamic createClass(String type, Map<String, dynamic> map){
  print('constructor'+type);
  switch(type){
    case Routes.getShops:
      return ShopModel.fromJSON(map);
      break;
    case Routes.getMeta:
      return MetaModel.fromJSON(map);
      break;
    default: return map;
  }
}