
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/takeeazyapis/base/URLRoutes.dart';


class ContainerServices {

  getContainers() async{
    request(URLRoutes.getContainers, call: CALLTYPE.GET);
  }
}