import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:takeeazy_customer/model/base/exception.dart';
import 'package:takeeazy_customer/model/base/modelclassselector.dart';
import 'package:takeeazy_customer/model/googleapis/base/googleapiurl.dart';
import 'package:takeeazy_customer/model/googleapis/geocoding/address.dart';
import 'package:takeeazy_customer/model/googleapis/placeautocomplete/places.dart';


class GoogleClassSelector extends ModelClassSelector{

  GoogleClassSelector():super("maps.googleapis.com");

  dynamic classSelector(String route, Map<String, dynamic> map){
    print(route);
    if(map['message'] != null) {
      throw ResponseException(map['message'] as String);
    }
    switch(route){
      case GoogleAPIURLRoutes.placeautocomplete:
        print("Autocomplete");
        return Predictions.fromJSON(map);
        break;
      case GoogleAPIURLRoutes.geocoding:
        print("Geocoding");
         AddressResults addressResults = AddressResults.fromJSON(map);
         print(addressResults);
        return addressResults;
        break;
      case GoogleAPIURLRoutes.placedetails:
        return Address.fromJSON(map);
        break;
      default: return map;
    }
  }
}