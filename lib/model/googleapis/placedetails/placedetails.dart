import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/googleapis/base/googleapiurl.dart';
import 'package:takeeazy_customer/model/googleapis/base/key.dart';
import 'package:takeeazy_customer/model/googleapis/geocoding/address.dart';

class PlaceDetails{

  static Future<TEResponse<Address>> getPlaceDetails(String placeID) async{
    Map<String, String> param  = {'place_id': placeID, 'key': APIKey, 'fields': 'address_component,geometry'};
    TEResponse<Address> response = await request<Address>(GoogleAPIURLRoutes.placedetails, call:  CALLTYPE.GET, param: param, isGoogleApi: true);
    return response;
  }
}