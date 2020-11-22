import 'package:takeeazy_customer/model/base/URLRoutes.dart' as Routes;

import '..//base/networkcall.dart' as network;

class OTPServices {
  void sendOTP(String phoneNumber) {
    network.POST(Routes.sendOTP, body: {'phone': phoneNumber}, auth: false);
  }

  void verfiyOTP({String phoneNumber, String OTP, String session_id}){
    network.POST(Routes.verifyOTP, body: {'phone':phoneNumber, 'otp': OTP, 'session_id': session_id}, auth:false);
  }
}