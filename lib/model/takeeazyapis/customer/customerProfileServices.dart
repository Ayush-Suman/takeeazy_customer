import 'package:takeeazy_customer/model/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/customer/customerProfileModel.dart';

class CustomerProfileServices {
  static Future<CustomerProfileModel> getCustomerProfile() async {
    CustomerProfileModel customerProfileModel =
        await request<CustomerProfileModel>(URLRoutes.getCustomerProfile,
            call: CALLTYPE.GET, auth: true);

    return customerProfileModel;
  }
}
