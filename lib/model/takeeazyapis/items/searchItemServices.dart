import 'package:takeeazy_customer/model/takeeazyapis/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/takeeazyapis/items/searchItemModel.dart';

class SearchItemServices {
  static Future<TEResponse> searchItem(
      {String store = '5f8facab45134c286cc5f46f'}) async {
    Map<String, String> param = {'store': store};

    TEResponse<SearchItemModel> searchItemModel = await request<SearchItemModel>(
        URLRoutes.searchItem,
        call: CALLTYPE.GET,
        param: param,
        auth: true);

    return searchItemModel;
  }

  static Future<TEResponse> searchItemInStore(
      {String store = '5f8facab45134c286cc5f46f', String q = 'aggi2'}) async {
    Map<String, String> param = {'store': store, 'q': q};

    TEResponse<SearchItemModel> searchItemModel = await request<SearchItemModel>(
        URLRoutes.searchItem,
        call: CALLTYPE.GET,
        param: param,
        auth: true);

    return searchItemModel;
  }
}
