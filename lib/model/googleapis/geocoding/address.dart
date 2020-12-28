import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class AddressResults{
  final List<Address> addresses;
  AddressResults(this.addresses);
  factory AddressResults.fromJSON(Map<String, dynamic> data){
    List<Address> tmp = [];
    print(data['results']);
    (data['results'] as List).forEach((element) { 
      List address_components = element['address_components'] as List;

      Map neighborhood;
      try {
        neighborhood = address_components.singleWhere((e) =>
            (e['types'] as List).contains('neighborhood'));
      } catch (e){
        neighborhood = {};
      }
      print(neighborhood);

      Map streetAddress;
      try {
        streetAddress = address_components.singleWhere((e) =>
            (e['types'] as List).contains('street_address'),
            orElse: () => address_components.singleWhere((e) =>
            (e['types'] as List).contains('routes')
            ));
      } catch (e){
        streetAddress = {};
      }
      print(streetAddress);

      Map subLocality;
      try {
        subLocality = address_components.singleWhere((e) =>

            (e['types'] as List).contains('sublocality_level_1'),
            orElse: () => address_components.singleWhere((e) =>
                (e['types'] as List).contains('sublocality')
            ));
      } catch (e){
        subLocality = {};
      }
      print(subLocality);

      Map town;
      try {
        town = address_components.singleWhere((e) =>

            (e['types'] as List).contains('locality'),
            orElse: () => address_components.singleWhere((e) =>
                (e['types'] as List).contains('colloquial_area'),
              orElse: ()=> address_components.singleWhere((e) =>
                  (e['types'] as List).contains('administrative_area_level_5'),
                  orElse: ()=> address_components.singleWhere((e) =>
                      (e['types'] as List).contains('administrative_area_level_4'),
                      orElse: ()=> address_components.singleWhere((e) =>
                          (e['types'] as List).contains('administrative_area_level_3')
                      )
                  )
              )
            ));
      } catch (e){
        town = {};
      }
      print(town);

      Map state;
      try{
        state = address_components.singleWhere((e)=>(e['types'] as List).contains('administrative_area_level_1'));
      } catch(e){
        state = {};
      }

      Map postalCode;
      try{
        postalCode = address_components.singleWhere((e)=>(e['types'] as List).contains('postal_code'));
      } catch(e){
        postalCode = {};
      }



      tmp.add(Address(
        formattedAddress: element['formatted_address'],
        neighbourhood: neighborhood['long_name'],
        streetAddress: streetAddress['long_name'],
        subLocality: subLocality['long_name'],
        town: town['long_name'],
        state: state['long_nmae'],
        postalCode: postalCode['long_name']
      ));
      
    });
    
    return AddressResults(tmp);
  }
}


class Address {
  final String formattedAddress;
  final String neighbourhood;
  final String streetAddress;
  final String subLocality;
  final String town;
  final String state;
  final String country;
  final String postalCode;
  LatLng latLng;
  
  Address({
   this.formattedAddress,
   this.neighbourhood,
   this.streetAddress,
   this.subLocality,
   this.town,
   this.state,
   this.country,
   this.postalCode 
});

}
