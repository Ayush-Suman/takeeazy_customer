import 'package:takeeazy_customer/model/profile/profileModel.dart';

import '../base/networkcall.dart' as network;
import '../base/URLRoutes.dart' as Routes;

class ProfileServices {

  Future<Profile> getProfile() async{
    network.request(Routes.getProfile, call: network.CALLTYPE.GET);
  }

}git