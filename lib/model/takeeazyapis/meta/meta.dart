
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/takeeazyapis/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/takeeazyapis/meta/metamodel.dart';

class Meta {


  static Future<TEResponse> getMetaInfo({double latitude=29.0, double longitude=77.7}) async{

    Map<String, String> param = {'geo': latitude.toString() + ',' + longitude.toString()};

    TEResponse metaModel = await request<MetaModel>(URLRoutes.getMeta, call: CALLTYPE.GET, param: param);
    return metaModel;

  }
}