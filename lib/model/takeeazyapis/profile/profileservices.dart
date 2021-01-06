
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/takeeazyapis/base/URLRoutes.dart';




class ProfileServices {

  Future getProfile() async{
    request(URLRoutes.getProfile, call: CALLTYPE.GET);
  }

}