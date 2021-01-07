import 'package:takeeazy_customer/model/takeeazyapis/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/takeeazyapis/stores/storesModel.dart';

class StoresServices {
  static Future<TEResponse> getStoresByDistance(
      {double latitude = 0.0, double longitude = 0.0, double dist = 0}) async {
    Map<String, String> param = {
      'dist': dist.toString(),
      'geo': latitude.toString() + ',' + longitude.toString()
    };
    TEResponse<ShopModel> shopModel = await request<ShopModel>(URLRoutes.getShops,
        call: CALLTYPE.GET, param: param, auth: true);
    return shopModel;
  }

  static Future<TEResponse> getStoresByContainer(
      {String container = 'Groceries %26 Essentials'}) async {
    Map<String, String> param = {
      'container': container,
    };
    TEResponse<ShopModel> shopModel = await request<ShopModel>(URLRoutes.getShops,
        call: CALLTYPE.GET, param: param, auth: true);
    return shopModel;
  }

  static Future<TEResponse> getStoresByDistanceInAContainer(
      {String container = 'Groceries %26 Essentials',
      double latitude = 0.0,
      double longitude = 0.0,
      double dist = 0}) async {
    Map<String, String> param = {
      'dist': dist.toString(),
      'geo': latitude.toString() + ',' + longitude.toString(),
      'container': container
    };
    TEResponse<ShopModel> shopModel = await request<ShopModel>(URLRoutes.getShops,
        call: CALLTYPE.GET, param: param, auth: true);
    return shopModel;
  }
}
