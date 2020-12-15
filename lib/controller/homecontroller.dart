import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:takeeazy_customer/controller/locationcontroller.dart';
import 'package:takeeazy_customer/model/base/exception.dart';
import 'package:takeeazy_customer/model/meta/meta.dart';
import 'package:takeeazy_customer/model/meta/metamodel.dart';


class HomeController with ChangeNotifier{
  String city;
  String addressLine;
  final locationController = LocationController();
  bool serviceAvailable;
  final CurrentLocation currentLocation;
  HomeController(this.currentLocation);


  Future getLocationData() async{
    try{
      currentLocation.position = await Geolocator.getCurrentPosition();
      print(currentLocation.position.toString());
      List<Address> addresses = await Geocoder.local.findAddressesFromCoordinates(Coordinates(currentLocation.position.latitude, currentLocation.position.longitude));
      print(addresses);
      if(addresses.length>0){
        Address address = addresses[0];
        city = address.locality;
        addressLine = address.addressLine;
        notifyListeners();
      }
      locationController._newLocationStatus = LocationStatus.Fetched;
    }catch(e){
      print("Failed "+e.toString());
      locationController._newLocationStatus = LocationStatus.Failed;
    }
  }


  Future getMetaData() async{
    print("Fetching Meta Info");
    try {
      MetaModel metaModel = await Meta.getMetaInfo(
          longitude: currentLocation.position.longitude, latitude: currentLocation.position.latitude);
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