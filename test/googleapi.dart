import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:takeeazy_customer/model/base/httpworker.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/googleapis/geocoding/geocodingservices.dart';
import 'package:takeeazy_customer/model/googleapis/placeautocomplete/autocompservices.dart';
import 'package:takeeazy_customer/model/googleapis/placeautocomplete/places.dart';

void main() async{
  init();

 test("Geocoding Response Test", () async{
   print("test started");

   WidgetsFlutterBinding.ensureInitialized();
   await GeocodingServices.getAddress(37.0, -77.7);

   //await Future.delayed(Duration(seconds: 10));
   //print(respone);
 });

 test("Autocomplete Response Test", () async{
   print("Test Started");
   //WidgetsFlutterBinding.ensureInitialized();
   TEResponse<Predictions> response = await AutocompleteServices.getPlaces("De", latitude: 27.0, longitude: 77);
   Predictions predictions = await response.response;
   //print(predictions.predictions[0].id);
 },);

}