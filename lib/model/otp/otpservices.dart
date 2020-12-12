import 'package:takeeazy_customer/model/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';



class OTPServices {
  void sendOTP(String phoneNumber) {
    request(URLRoutes.sendOTP, call: CALLTYPE.POST, body: {'phone': phoneNumber},);
  }

  void verfiyOTP({String phoneNumber, String OTP, String session_id}){
    request(URLRoutes.verifyOTP, call: CALLTYPE.POST,
        body: {'phone':phoneNumber, 'otp': OTP, 'session_id': session_id},);
  }
}