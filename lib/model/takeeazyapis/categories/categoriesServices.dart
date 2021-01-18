import 'package:takeeazy_customer/model/takeeazyapis/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/takeeazyapis/categories/categoriesModel.dart';

class CategoriesServices {
  static Future<TEResponse> getCategoriesByContainer({String containerId}) async {
    Map<String, String> param = {'container': containerId};

    TEResponse categoriesModel = await request<CategoriesModel>(
        URLRoutes.getCategories,
        call: CALLTYPE.GET,
        param: param);

    return categoriesModel;
  }
}
