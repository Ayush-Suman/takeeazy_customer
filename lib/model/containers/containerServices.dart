import 'package:takeeazy_customer/model/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';


class ContainerServices {
  getContainers() async{
    request(URLRoutes.getContainers, call: CALLTYPE.GET);
  }
}