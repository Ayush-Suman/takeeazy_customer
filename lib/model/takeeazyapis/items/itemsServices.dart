import 'package:flutter/rendering.dart';
import 'package:takeeazy_customer/model/takeeazyapis/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/takeeazyapis/items/itemsModel.dart';

class ItemsServices {
  static Future<TEResponse> getItemsByStore(
      {String store = '5f8facab45134c286cc5f46f'}) async {
    Map<String, String> param = {'store': store};

    TEResponse itemsModel = await request<ItemsModel>(URLRoutes.getShopItems,
        call: CALLTYPE.GET, param: param, auth: true);

    return itemsModel;
  }

  static Future<TEResponse> getItemsByCategoryAndStore(
      {String category = 'Groceries',
      String store = '5f8facab45134c286cc5f46f'}) async {
    Map<String, String> param = {'category': category, 'store': store};

    TEResponse itemsModel = await request<ItemsModel>(URLRoutes.getShopItems,
        call: CALLTYPE.GET, param: param, auth: true);

    return itemsModel;
  }
}
