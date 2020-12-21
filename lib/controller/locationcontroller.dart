import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:takeeazy_customer/caching/caching.dart';
import 'package:takeeazy_customer/controller/textcontroller.dart';
import 'package:takeeazy_customer/model/base/exception.dart';
import 'package:takeeazy_customer/model/dialog/dialogservice.dart';
import 'package:takeeazy_customer/model/meta/meta.dart';
import 'package:takeeazy_customer/model/meta/metamodel.dart';


enum LocationStatus{
  Fetched,
  Failed,
  Fetching,
  Denied,
  Done
}

class PositionController with ChangeNotifier{
  Position _position;
  get position=>_position;
  set position(p){
    if(_position != p){
      _position = p;
      notifyListeners();
    }
  }
}

class ListStatusController with ChangeNotifier{
  bool listOpen = false;
  void openList(bool open){
    listOpen = open;
    notifyListeners();
  }
}


// TODO: Change Location to self implemented Place API parsed class
class AddressListController with ChangeNotifier {
  List<Location> _addresses = List();
  get addresses => _addresses;
  set addresses(List<Location> a) {
    _addresses = a;
    notifyListeners();
  }
}

class LocationStatusController with ChangeNotifier {
  LocationStatus locationStatus = LocationStatus.Fetching;

  set _newLocationStatus(v){
    if(v!=locationStatus){
      locationStatus = v;
      notifyListeners();
    }
  }
}


class LocationController with ChangeNotifier{
  final _dialogService = DialogService();
  final TextController city = TextController();
  final TextEditingController addressLine = TextEditingController();
  final ListStatusController listStatusController = ListStatusController();
  final AddressListController listController = AddressListController();
  final PositionController positionController = PositionController();
  final LocationStatusController locationStatusController = LocationStatusController();

  final FocusNode focusNode = FocusNode();


  bool serviceAvailable;

  // TODO: Change to use self implemented Place API parsed class
 void selectAddress(Location address){
    positionController.position = Position(latitude: address.latitude, longitude: address.longitude);
    city.text = address.latitude as String;
    addressLine.text = address.longitude as String;
    focusNode.unfocus();
 }

 // TODO: Call Place API for autocompletion
  Future getLocationFromAddress(String query) async{
    listController.addresses = await locationFromAddress(query);
  }

  Future getMetaData() async {
    print("Fetching Meta Info");
    locationStatusController._newLocationStatus = LocationStatus.Fetching;
    try {
      MetaModel metaModel = await Meta.getMetaInfo(
          longitude: positionController.position.longitude,
          latitude: positionController.position.latitude);
      city.text = metaModel.city.cityName;
      serviceAvailable = true;
      locationStatusController._newLocationStatus = LocationStatus.Fetched;
          notifyListeners();
    } catch (e) {
      if (e is ResponseException) {
        if (e.msg == "We are not available in your city yet.") {
          serviceAvailable = true;
          locationStatusController._newLocationStatus = LocationStatus.Fetched;
          notifyListeners();
        }else{
          locationStatusController._newLocationStatus = LocationStatus.Failed;
        }

      }
    }
    locationStatusController._newLocationStatus = LocationStatus.Done;
    print("Fetched Meta Info");

  }

  Future getAddress() async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(
          positionController.position.latitude,
          positionController.position.longitude);
      print("Get Address "+listController.addresses.toString());
      if (listController.addresses.length > 0) {
        Placemark address = listController.addresses[0];
        city.text = address.locality;
        addressLine.text = address.name;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      _dialogService.openDialog(
          title: "No Internet Connection",
          content: "App needs internet connection to search locations",
          actions: [
            ActionHolder(title: "Okay", onPressed: (){})
          ]);
      locationStatusController._newLocationStatus = LocationStatus.Failed;
    }
  }

  Future getLocationData() async {
    try {
      positionController.position = await Geolocator.getCurrentPosition();
      print(positionController.position.toString() + " getLocationData");
      await getAddress();
      locationStatusController._newLocationStatus = LocationStatus.Fetched;
    } catch (e) {
      print("Failed " + e.toString());
      locationStatusController._newLocationStatus = LocationStatus.Denied;
    }
  }

  Future requestLocationAccess() async {
   listStatusController.openList(false);
    print("Requesting Access");
    if ((await Geolocator.checkPermission()) ==
        LocationPermission.deniedForever) {
      await _dialogService.openDialog(
          title: "Grant location permissions",
          content: "App needs location permissions to get the current location",
          actions: [
            ActionHolder(title: "Cancel", onPressed: (){}),
            ActionHolder(title: "Open Settings",
                onPressed: Geolocator.openLocationSettings)
          ]
      );
    } else {
      LocationPermission result = await Geolocator.requestPermission();
      if (result == LocationPermission.always ||
          result == LocationPermission.whileInUse) {
        locationStatusController._newLocationStatus = LocationStatus.Fetching;
        await getLocationData();
        locationStatusController._newLocationStatus = LocationStatus.Fetched;
      }
    }
  }

  void storeValues(){
   Caching.city = city.text;
   Caching.serviceableArea = serviceAvailable;
 }

}


