import 'package:takeeazy_customer/model/takeeazyapis/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/takeeazyapis/items/listedItemModel.dart';

class ListedItemServices {
  static Future<TEResponse> getListedItem() async {
    TEResponse listedItemModel = await request<ListedItemModel>(
        URLRoutes.getListedItem,
        call: CALLTYPE.GET);
    return listedItemModel;
  }
}
