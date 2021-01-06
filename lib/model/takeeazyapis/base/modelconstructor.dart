
import 'package:takeeazy_customer/model/base/exception.dart';
import 'package:takeeazy_customer/model/base/modelclassselector.dart';
import 'package:takeeazy_customer/model/takeeazyapis/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/takeeazyapis/meta/metamodel.dart';
import 'package:takeeazy_customer/model/takeeazyapis/stores/storesModel.dart';
import 'package:takeeazy_customer/model/takeeazyapis/containers/containersModel.dart';




class ClassSelector extends ModelClassSelector{
  ClassSelector():super("takeeazy-backend.herokuapp.com");

  dynamic classSelector(String route, Map<String, dynamic> map){
    if(map['message'] != null) {
      throw ResponseException(map['message'] as String);
    }
    switch(route){
      case URLRoutes.getShops:
        return ShopModel.fromJSON(map);
        break;
      case URLRoutes.getMeta:
        return MetaModel.fromJSON(map);
        break;
      case URLRoutes.getContainers:
        return ContainerModel.fromJSON(map);
      case URLRoutes.getShops:
        return ShopModel.fromJSON(map);
      default: return map;
    }
  }
}