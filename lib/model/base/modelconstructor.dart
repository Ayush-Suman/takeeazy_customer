import 'package:takeeazy_customer/model/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/base/exception.dart';
import 'package:takeeazy_customer/model/base/modelclassselector.dart';
import 'package:takeeazy_customer/model/containers/containersModel.dart';
import 'package:takeeazy_customer/model/meta/metamodel.dart';
import 'package:takeeazy_customer/model/stores/storesModel.dart';


class ClassSelector extends ModelClassSelector{
  dynamic classSelector(String type, Map<String, dynamic> map){
    if(map['message'] != null) {
      throw ResponseException(map['message'] as String);
    }
    switch(type){
      case URLRoutes.getShops:
        return ShopModel.fromJSON(map);
        break;
      case URLRoutes.getMeta:
        return MetaModel.fromJSON(map);
        break;
      case URLRoutes.getContainers:
        return ContainerModel.fromJSON(map);
      default: return map;
    }
  }
}