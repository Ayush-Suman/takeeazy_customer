import 'package:takeeazy_customer/model/takeeazyapis/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/takeeazyapis/stores/searchStoreModel.dart';

class SearchStoreServices {
  static Future<TEResponse> searchByQuery({String query = 'mall'}) async {
    Map<String, String> param = {'q': query};

    TEResponse<SearchStoreModel> searchStoreModel = await request<SearchStoreModel>(
        URLRoutes.searchStore,
        call: CALLTYPE.GET,
        param: param,
        auth: true);

    return searchStoreModel;
  }
}
