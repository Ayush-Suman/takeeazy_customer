import 'package:flutter_test/flutter_test.dart';
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/takeeazyapis/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/takeeazyapis/base/meta/metamodel.dart';

void main()async {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('custom http test', () async{
    print('test started');
    await request(URLRoutes.getMeta, call: CALLTYPE.GET, param: {'geo':'29.0000,77.700000'}).then((value) {print((value as MetaModel).city.cityName);});
    print('response fetched');
  });
}