import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/googleapis/base/googleapiurl.dart';
import 'package:takeeazy_customer/model/googleapis/base/key.dart';
import 'package:takeeazy_customer/model/googleapis/geocoding/address.dart';

class GeocodingServices{

  static Future<TEResponse> getAddress(double latitude, double longitude) async {
    Map<String, String> param = {'latlng': '${latitude},${longitude}', 'key':APIKey};
    print(param.toString());
    TEResponse response = await request<AddressResults>(GoogleAPIURLRoutes.geocoding, call: CALLTYPE.GET, isGoogleApi: true, param: param);
    //response.dispose();
    return response;
  }

}

