import 'package:takeeazy_customer/model/takeeazyapis/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/takeeazyapis/customer/customerProfileModel.dart';

class CustomerProfileServices {
  static Future<TEResponse> getCustomerProfile() async {
    TEResponse customerProfileModel =
        await request<CustomerProfileModel>(URLRoutes.getCustomerProfile,
            call: CALLTYPE.GET, auth: true);

    return customerProfileModel;
  }
}
