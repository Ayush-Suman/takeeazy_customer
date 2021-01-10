import 'package:flutter_test/flutter_test.dart';
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/httpworker.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/takeeazyapis/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/takeeazyapis/categories/categoriesServices.dart';
import 'package:takeeazy_customer/model/takeeazyapis/containers/containerServices.dart';
import 'package:takeeazy_customer/model/takeeazyapis/containers/containersModel.dart';
import 'package:takeeazy_customer/model/takeeazyapis/meta/meta.dart';
import 'package:takeeazy_customer/model/takeeazyapis/meta/metamodel.dart';

void main()async {
  init();
  TestWidgetsFlutterBinding.ensureInitialized();
  test('custom http test', () async{
    print('test started');
    await request(URLRoutes.getMeta, call: CALLTYPE.GET, param: {'geo':'29.0000,77.700000'}).then((value) {print((value as MetaModel).city.cityName);});
    print('response fetched');
  }, skip: true);

  test('test Meta Info',() async{
    TEResponse response = await CategoriesServices.getCategoriesByContainer();
    await response.response;
    //print(containers[0].containerName);
  });


}