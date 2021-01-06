import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressResults{
  final List<Address> addresses;
  AddressResults(this.addresses);
  factory AddressResults.fromJSON(Map<String, dynamic> data){

    List<Address> tmp = [];
    print(data['results']);
    (data['results'] as List).forEach((element) {
      tmp.add(Address.fromJSON(element));
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
   @required this.formattedAddress,
   @required this.neighbourhood,
   @required this.streetAddress,
   @required this.subLocality,
   @required this.town,
   @required this.state,
   @required this.country,
   @required this.postalCode,
    this.latLng
});


  factory Address.fromJSON(Map data){
    List address_components;
    double latitude;
    double longitude;
    if(data.containsKey('result')){
      print('place details');
      address_components = data['result']['address_components'];
      latitude = data['result']['geometry']['location']['lat'];
      longitude = data['result']['geometry']['location']['lng'];
      print(latitude);
    }else{
    address_components = data['address_components'] as List;
    }


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
      print("Inside Sublocality" + address_components.toString());
    } catch (e){
      subLocality = {};
    }
    print(subLocality);

    Map town;
    try {
      print("Inside locality" + address_components.toString());
      town = address_components.singleWhere((e) {
        print("locality");
        return (e['types'] as List).contains('locality');},
          orElse: () => address_components.singleWhere((e) {
            print('colloquial_area');
            return (e['types'] as List).contains('colloquial_area');},
              orElse: ()=> address_components.singleWhere((e) {
                print('admin_area_5');
                return (e['types'] as List).contains('administrative_area_level_5');},
                  orElse: ()=> address_components.singleWhere((e) {
                    print('admin_area_4');
                    return (e['types'] as List).contains('administrative_area_level_4');},
                      orElse: ()=> address_components.singleWhere((e) {
                        print('admin_area_3');
                        return (e['types'] as List).contains('administrative_area_level_3');}
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

    Map country;
    try{
      country = address_components.singleWhere((e) => (e['types'] as List).contains('country'));
    }catch(e){
      country={};
    }

    return Address(
        formattedAddress: data['formatted_address'],
        neighbourhood: neighborhood['long_name'],
        streetAddress: streetAddress['long_name'],
        subLocality: subLocality['long_name'],
        town: town['long_name'],
        state: state['long_name'],
        country: country['long_name'],
        postalCode: postalCode['long_name'],
      latLng: _getLatLng(latitude, longitude)
    );

  }

}

LatLng _getLatLng(double latitude, double longitude){
  if(latitude==null || longitude==null){
    return null;
  }
  return LatLng(latitude, longitude);
}