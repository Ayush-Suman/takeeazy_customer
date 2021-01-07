
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:takeeazy_customer/caching/caching.dart';
import 'package:takeeazy_customer/controller/serviceablearea.dart';
import 'package:takeeazy_customer/controller/textcontroller.dart';
import 'package:takeeazy_customer/main.dart';
import 'package:takeeazy_customer/model/base/exception.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/dialog/dialogservice.dart';
import 'package:takeeazy_customer/model/googleapis/geocoding/address.dart';
import 'package:takeeazy_customer/model/googleapis/geocoding/geocodingservices.dart';
import 'package:takeeazy_customer/model/googleapis/placeautocomplete/autocompservices.dart';
import 'package:takeeazy_customer/model/googleapis/placeautocomplete/places.dart';
import 'package:takeeazy_customer/model/googleapis/placedetails/placedetails.dart';
import 'package:takeeazy_customer/model/navigator/navigatorservice.dart';
import 'package:takeeazy_customer/model/takeeazyapis/meta/meta.dart';


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

class SearchController with ChangeNotifier{
  bool _isSearching=false;
  bool get isSearching=>_isSearching;
  set isSearching(bool s){
    if(s!=_isSearching){
      _isSearching = s;
      notifyListeners();
    }
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



class CustomFocusNode extends FocusNode{
  ListStatusController _listStatusController;
  set listStatusController(ListStatusController lsc){
    _listStatusController = lsc;
  }

  @override
  void requestFocus([FocusNode node]) {
    _listStatusController.listOpen=true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      super.requestFocus(node);
    });

  }
}


class LocationController{
  String currentAddress="";
  final _dialogService = DialogService();
  final TextController city = TextController();
  final TextEditingController addressLine = TextEditingController();
  final ListStatusController listStatusController = ListStatusController();
  final AddressListController listController = AddressListController();
  final PositionController positionController = PositionController();
  final LocationStatusController locationStatusController = LocationStatusController();
  final SearchController searchController = SearchController();

  final CustomFocusNode focusNode = CustomFocusNode();

  ServiceableArea serviceableArea = ServiceableArea();


  void reSyncValues(){
    print("Resyncing Values $currentAddress");
    addressLine.text = currentAddress;
  }


 void selectAddress(Places place) async{
    TEResponse<Address> response= await PlaceDetails.getPlaceDetails(place.id);
    locationStatusController._newLocationStatus = LocationStatus.Fetching;
    Address address = await response.response;
    positionController.position = Position(latitude: address.latLng.latitude , longitude: address.latLng.longitude);
    city.text = address.subLocality??address.town??address.state;
    listStatusController.listOpen = false;
    focusNode.unfocus();
 }


  TEResponse<Predictions> response;
  Future getLocationFromAddress() async{
    if(response!=null){
      response.dispose();
    }
    searchController.isSearching = true;
    if(positionController._position!=null){
      AutocompleteServices.getPlaces(addressLine.text, longitude: positionController._position.longitude, latitude: positionController._position.latitude).then((response) async{
        Predictions predictions = await response.response;
        if(predictions!=null) {
          listController.addresses = predictions.predictions;
          searchController.isSearching = false;
        }});
    }else{
      AutocompleteServices.getPlaces(addressLine.text).then((response) async{
        Predictions predictions = await response.response;
        if(predictions!=null) {
          listController.addresses = predictions.predictions;
          searchController.isSearching = false;
        }});
    }

  }

  Future getMetaData() async {
    print("Fetching Meta Info");
    locationStatusController._newLocationStatus = LocationStatus.Fetching;
    TEResponse response = await Meta.getMetaInfo(
        longitude: positionController.position.longitude,
        latitude: positionController.position.latitude);
    response.response.then((metaModel) {
      city.text = metaModel.city.cityName;
      serviceableArea.serviceAvailable = true;
      print("Serviceable Area");
      storeValues();
      NavigatorService.rootNavigator.popAndPushNamed(TERoutes.home);
      locationStatusController._newLocationStatus = LocationStatus.Fetched;
    }).catchError((e){
      print("ERROR " + e.toString());
      if (e is ResponseException) {
        print("NonServiceable Area");
        serviceableArea.serviceAvailable = false;
        storeValues();
        NavigatorService.rootNavigator.popAndPushNamed(TERoutes.home);
        locationStatusController._newLocationStatus = LocationStatus.Fetched;
      }
    });
    print("Fetched Meta Info");
  }

  Future getAddress() async {

    TEResponse<AddressResults> response = await GeocodingServices.getAddress(positionController.position.latitude, positionController.position.longitude);

      response.response.then((addressResults) {
        print(addressResults);
        print("Received address");
        print(addressResults.addresses);
        if(addressResults.addresses.length>0){
          print("Updating Values");
          city.text = addressResults.addresses[0].subLocality??addressResults.addresses[0].town??addressResults.addresses[0].state;
          addressLine.text = addressResults.addresses[0].formattedAddress;
          currentAddress = addressLine.text;
        }
        locationStatusController._newLocationStatus = LocationStatus.Fetched;
      }).catchError((e){
        print(e.toString());
        if(e is SocketException){
          _dialogService.openDialog(
              title: "No Internet Connection",
              content: "App needs internet connection to search locations",
              actions: [
                ActionHolder(title: "Okay", onPressed: (){})
              ]);
          locationStatusController._newLocationStatus = LocationStatus.Failed;
        }});
  }

  Future getLocationData() async {
    try {
      positionController.position = await Geolocator.getCurrentPosition();
      print(positionController.position.toString() + " getLocationData");
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
    print("Saving ${city.text} ${serviceableArea.serviceAvailable}");
   Caching.city = city.text;
   Caching.serviceableArea = serviceableArea.serviceAvailable;
 }

}


