import 'package:flutter_test/flutter_test.dart';
import 'package:takeeazy_customer/model/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/meta/metamodel.dart';

void main(){

test('custom http test', () async{
  TestWidgetsFlutterBinding.ensureInitialized();
  print('test started');
  networkInit();
  MetaModel metaModel = await request(getMeta, call: CALLTYPE.GET, param: {'geo':'29.0000,77.700000'});
  print('response fetched');
});
}