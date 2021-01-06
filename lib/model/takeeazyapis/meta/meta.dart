
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/takeeazyapis/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/takeeazyapis/meta/metamodel.dart';

class Meta {


  static Future<TEResponse<MetaModel>> getMetaInfo({double latitude=0.0, double longitude=0.0}) async{

    Map<String, String> param = {'geo': latitude.toString() + ',' + longitude.toString()};

    TEResponse<MetaModel> metaModel = await request<MetaModel>(URLRoutes.getMeta, call: CALLTYPE.GET, param: param);
    return metaModel;

  }
}