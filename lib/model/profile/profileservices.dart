import 'package:takeeazy_customer/model/base/URLRoutes.dart' as Routes;
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/profile/profileModel.dart';




class ProfileServices {

  Future<Profile> getProfile() async{
    request(Routes.getProfile, call: Routes.CALLTYPE.GET);
  }

}