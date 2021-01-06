import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:takeeazy_customer/caching/caching.dart';
import 'package:takeeazy_customer/controller/textcontroller.dart';
import 'package:takeeazy_customer/model/base/exception.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/dialog/dialogservice.dart';
import 'package:takeeazy_customer/model/googleapis/geocoding/address.dart';
import 'package:takeeazy_customer/model/googleapis/geocoding/geocodingservices.dart';
import 'package:takeeazy_customer/model/googleapis/placeautocomplete/autocompservices.dart';
import 'package:takeeazy_customer/model/googleapis/placeautocomplete/places.dart';
import 'package:takeeazy_customer/model/googleapis/placedetails/placedetails.dart';
import 'package:takeeazy_customer/model/takeeazyapis/meta/meta.dart';
import 'package:takeeazy_customer/model/takeeazyapis/meta/metamodel.dart';


enum LocationStatus{
  Fetched,
  Failed,
  Fetching,
  Denied,
  Done
}

class PositionController with ChangeNotifier{
  Position _position;
  get position => _position;
  set position(p){
    if(_position != p){
      _position = p;
      notifyListeners();
    }
  }
}

class ListStatusController with ChangeNotifier{
  bool _listOpen = false;
  bool get listOpen => _listOpen;
  set listOpen(bool open){
    _listOpen = open;
    notifyListeners();
  }
}


class AddressListController with ChangeNotifier {
  List<Places> _addresses = List();

  List<Places> get addresses => _addresses;

  set addresses(List<Places> a) {
    _addresses = a;
    notifyListeners();
  }
}

class LocationStatusController with ChangeNotifier {
  LocationStatus _locationStatus = LocationStatus.Fetching;

  get locationStatus => _locationStatus;

  set _newLocationStatus(v){
    if(v!=_locationStatus){
      _locationStatus = v;
      notifyListeners();
    }
  }
}

class ServiceableArea with ChangeNotifier{
  bool _serviceAvailable;
  bool get serviceAvailable =>_serviceAvailable;
  set serviceAvailable(bool s){
    if(s!=_serviceAvailable){
      _serviceAvailable = s;
      notifyListeners();
    }
  }
}


class LocationController{
  final _dialogService = DialogService();
  final TextController city = TextController();
  final TextEditingController addressLine = TextEditingController();
  final ListStatusController listStatusController = ListStatusController();
  final AddressListController listController = AddressListController();
  final PositionController positionController = PositionController();
  final LocationStatusController locationStatusController = LocationStatusController();

  final FocusNode focusNode = FocusNode();

  ServiceableArea serviceableArea = ServiceableArea();



  // TODO: Change to use self implemented Place API parsed class
 void selectAddress(Places place) async{
    TEResponse<Address> response= await PlaceDetails.getPlaceDetails(place.id);
    Address address = await response.response;
    positionController.position = Position(latitude: address.latLng.latitude , longitude: address.latLng.longitude);
    city.text = address.subLocality??address.town??address.state;
    addressLine.text = place.main+" "+ place.secondary;
    focusNode.unfocus();
 }


  TEResponse<Predictions> response;
  Future getLocationFromAddress(String query) async{
    if(response!=null){
      response.dispose();
    }
    AutocompleteServices.getPlaces(query, longitude: positionController._position.longitude, latitude: positionController._position.latitude).then((response) async{
    Predictions predictions = await response.response;
    if(predictions!=null) {
      listController.addresses = predictions.predictions;
    }});
  }

  Future getMetaData() async {
    print("Fetching Meta Info");
    locationStatusController._newLocationStatus = LocationStatus.Fetching;
    try {
      TEResponse response = await Meta.getMetaInfo(
        longitude: positionController.position.longitude,
        latitude: positionController.position.latitude);
      MetaModel metaModel = await response.response;
      city.text = metaModel.city.cityName;
      serviceableArea.serviceAvailable = true;
      locationStatusController._newLocationStatus = LocationStatus.Fetched;
    } catch (e) {
      if (e is ResponseException) {
        if (e.msg == "We are not available in your city yet.") {
          serviceableArea.serviceAvailable = true;
          locationStatusController._newLocationStatus = LocationStatus.Fetched;
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
      TEResponse<AddressResults> response = await GeocodingServices.getAddress(positionController.position.latitude, positionController.position.longitude);
      // print("Reading response "+ (await response.response));
      AddressResults addressResults = await response.response;
      print(addressResults);
      print("Received address");
      print(addressResults.addresses);
      if(addressResults.addresses.length>0){
        print("Updating Values");
        city.text = addressResults.addresses[0].subLocality??addressResults.addresses[0].town??addressResults.addresses[0].state;
        addressLine.text = addressResults.addresses[0].formattedAddress;
      }
      locationStatusController._newLocationStatus = LocationStatus.Fetched;
    } catch (e) {
      print(e.toString());
      if(e is SocketException){
      _dialogService.openDialog(
          title: "No Internet Connection",
          content: "App needs internet connection to search locations",
          actions: [
            ActionHolder(title: "Okay", onPressed: (){})
          ]);
      locationStatusController._newLocationStatus = LocationStatus.Failed;
    }}
  }

  Future getLocationData() async {
    try {
      positionController.position = await Geolocator.getCurrentPosition();
      print(positionController.position.toString() + " getLocationData");
      locationStatusController._newLocationStatus = LocationStatus.Fetched;
    } catch (e) {
      print("Failed " + e.toString());
      locationStatusController._newLocationStatus = LocationStatus.Denied;
    }
  }

  Future requestLocationAccess() async {
   listStatusController.listOpen = false;
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
      //LocationPermission result = await Geolocator.requestPermission();
    //  if (result == LocationPermission.always ||
      //    result == LocationPermission.whileInUse) {
        locationStatusController._newLocationStatus = LocationStatus.Fetching;
        await getLocationData();
        locationStatusController._newLocationStatus = LocationStatus.Fetched;
      }
    //}
  }

  void storeValues(){
   Caching.city = city.text;
   Caching.serviceableArea = serviceableArea.serviceAvailable;
 }

}


