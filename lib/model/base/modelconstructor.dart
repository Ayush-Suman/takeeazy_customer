import 'package:takeeazy_customer/model/base/URLRoutes.dart' as Routes;
import 'package:takeeazy_customer/model/base/modelclassselector.dart';
import 'package:takeeazy_customer/model/meta/metamodel.dart';
import 'package:takeeazy_customer/model/stores/storesModel.dart';


class ClassSelector extends ModelClassSelector{
  dynamic classSelector(String type, Map<String, dynamic> map){
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
}