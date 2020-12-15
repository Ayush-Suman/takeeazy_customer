import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:takeeazy_customer/model/base/exception.dart';
import 'package:takeeazy_customer/model/meta/meta.dart';
import 'package:takeeazy_customer/model/meta/metamodel.dart';


class HomeController with ChangeNotifier{
  String city;
  String addressLine;
  final locationController = LocationController();
  bool serviceAvailable;
  Position _position = Position(longitude: 0.0, latitude: 0.0);


  Future getLocationData() async{
    try{
      _position = await Geolocator.getCurrentPosition();
      List<Address> addresses = await Geocoder.local.findAddressesFromCoordinates(Coordinates(_position.latitude, _position.longitude));
      print(addresses);
      if(addresses.length>0){
        Address address = addresses[0];
        city = address.locality;
        addressLine = address.addressLine;
        notifyListeners();
      }
      locationController._newLocationStatus = LocationStatus.Fetched;
    }catch(e){
      locationController._newLocationStatus = LocationStatus.Failed;
    }
  }


  Future getMetaData() async{
    print("Fetching Meta Info");
    try {
      MetaModel metaModel = await Meta.getMetaInfo(
          longitude: _position.longitude, latitude: _position.latitude);
      city = metaModel.city.cityName;
      notifyListeners();
    }catch(e){
      if(e is ResponseException){
        if(e.msg=="We are not available in your city yet."){
          serviceAvailable=false;
          notifyListeners();
        }
      }
    }
    locationController._newLocationStatus = LocationStatus.Done;
    print("Fetched Meta Info");
  }

}


class LocationController with ChangeNotifier{
  LocationStatus locationStatus = LocationStatus.Fetching;

  set _newLocationStatus(v){
    if(v!=locationStatus){
      locationStatus = v;
      notifyListeners();
    }
  }

}

enum LocationStatus{
  Fetched,
  Failed,
  Fetching,
  Done
}