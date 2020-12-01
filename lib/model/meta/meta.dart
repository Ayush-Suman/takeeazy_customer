import 'package:takeeazy_customer/model/base/URLRoutes.dart' as Routes;
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/meta/metamodel.dart';

class Meta {
  Future<MetaModel> getMetaInfo({double latitude=0.0, double longitude=0.0}) async{
    Map<String, String> param = {'geo': latitude.toString() + ',' + longitude.toString()};
    MetaModel metaModel = await request(Routes.getMeta, call: Routes.CALLTYPE.GET, param: param);
    return metaModel;
  }
}