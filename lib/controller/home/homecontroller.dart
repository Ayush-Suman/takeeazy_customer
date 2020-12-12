import 'package:flutter/cupertino.dart';
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