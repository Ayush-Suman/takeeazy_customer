import 'package:takeeazy_customer/model/base/URLRoutes.dart' as Routes;
import 'package:takeeazy_customer/model/base/networkcall.dart';



class OTPServices {
  void sendOTP(String phoneNumber) {
    request(Routes.sendOTP, call: CALLTYPE.POST, body: {'phone': phoneNumber}, auth: false);
  }

  void verfiyOTP({String phoneNumber, String OTP, String session_id}){
    request(Routes.verifyOTP, call: CALLTYPE.POST, body: {'phone':phoneNumber, 'otp': OTP, 'session_id': session_id}, auth:false);
  }
}