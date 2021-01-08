import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:takeeazy_customer/model/base/httpworker.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/googleapis/geocoding/address.dart';
import 'package:takeeazy_customer/model/googleapis/geocoding/geocodingservices.dart';
import 'package:takeeazy_customer/model/googleapis/placeautocomplete/autocompservices.dart';
import 'package:takeeazy_customer/model/googleapis/placeautocomplete/places.dart';
import 'package:takeeazy_customer/model/googleapis/placedetails/placedetails.dart';

void main() async{
  init();

 test("Geocoding Response Test", () async{
   print("test started");

   WidgetsFlutterBinding.ensureInitialized();
   TEResponse response = await GeocodingServices.getAddress(37.0, -77.7);
   AddressResults addressResults = await response.response;
   print(addressResults);

   //await Future.delayed(Duration(seconds: 10));
   //print(respone);
 }, skip : true);

 test("Autocomplete Response Test", () async{
   print("Test Started");
   //WidgetsFlutterBinding.ensureInitialized();
   TEResponse response = await AutocompleteServices.getPlaces("D", latitude: 27.0, longitude: 77);
   response.dispose();
   TEResponse response2 = await AutocompleteServices.getPlaces("D/6, Kalyan Vihar, Ambedkar Path", latitude: 27.0, longitude: 77);
   await response2.response;
   Predictions predictions  = await response.response;
   print("Test "+predictions.toString());

 });

 test("Place Details Response Test", () async{
   TEResponse response = await PlaceDetails.getPlaceDetails("EltEZWxoaSAtIEphaXB1ciBFeHByZXNzd2F5LCBCbG9jayBCLCBNYWhpcGFscHVyIFZpbGxhZ2UsIE1haGlwYWxwdXIsIE5ldyBEZWxoaSwgRGVsaGksIEluZGlhIi4qLAoUChIJiSM9AHGybTkRX_MOYte_tfQSFAoSCU8GRFtAHA05EXKusdBd0CDx");
   LatLng latlng = await response.response;
   print(latlng);
 }, skip: true);
}