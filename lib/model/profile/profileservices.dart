import 'package:takeeazy_customer/model/profile/profileDAO.dart';

import '../base/networkcall.dart' as network;
import '../base/URLRoutes.dart' as Routes;

class ProfileServices {

  Future<Profile> getProfile() async{
    network.GET(Routes.getProfile);
  }

}