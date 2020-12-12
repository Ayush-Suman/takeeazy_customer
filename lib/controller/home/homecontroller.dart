import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:takeeazy_customer/model/meta/meta.dart';
import 'package:takeeazy_customer/model/meta/metamodel.dart';


class HomeController extends ChangeNotifier{
  String city;
  LocationStatus locationStatus = LocationStatus.Fetching;
  Position _position = Position(longitude: 0.0, latitude: 0.0);


  Future getLocationData() async{
    try{
      _position = await Geolocator.getCurrentPosition();
      List<Address> addresses = await Geocoder.local.findAddressesFromCoordinates(Coordinates(_position.latitude, _position.longitude));
      print(addresses);
      if(addresses.length>0){
        Address address = addresses[0];
        city = address.locality;
      }
      locationStatus = LocationStatus.Fetched;
    }catch(e){
      locationStatus = LocationStatus.Failed;
    }

    notifyListeners();
  }

  Future getMetaData() async{
    MetaModel metaModel = await Meta.getMetaInfo(longitude: _position.longitude, latitude: _position.latitude);
    city = metaModel.city.cityName;
    locationStatus = LocationStatus.Done;
    notifyListeners();
  }


}

enum LocationStatus{
  Fetched,
  Failed,
  Fetching,
  Done
}