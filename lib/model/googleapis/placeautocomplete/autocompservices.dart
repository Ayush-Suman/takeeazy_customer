import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/googleapis/base/googleapiurl.dart';
import 'package:takeeazy_customer/model/googleapis/base/key.dart';
import 'package:takeeazy_customer/model/googleapis/placeautocomplete/places.dart';

class AutocompleteServices{
  static Future<TEResponse> getPlaces(String query, {double longitude, double latitude}) async{
    Map<String, String> param = {'input': query,'types': 'address', 'key': APIKey};
    if(longitude!=null || latitude != null){
      assert(longitude!=null && latitude != null);
      print("Biased Search");
      param.addAll({
        'location': '$latitude,$longitude',
        'radius': '50000'
      });
    }

    print("Requesting");
    TEResponse response =  await  request<Predictions>(GoogleAPIURLRoutes.placeautocomplete, call: CALLTYPE.GET, isGoogleApi: true, param: param);
    return response;
  }
}