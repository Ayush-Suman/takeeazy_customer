import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapWithMarker extends StatefulWidget {
  final height;
  final width;
  final locationController;
  MapWithMarker(this.height,this.width, this.locationController);
  @override
  _MapWithMarkerState createState() => _MapWithMarkerState();
}

class _MapWithMarkerState extends State<MapWithMarker>{

  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController googleLocationController;
  List<Marker> marker = [];



  @override
  Widget build(BuildContext context) {
    final _positionController = widget.locationController.positionController;


    final Size size = (TextPainter(
        text: TextSpan(text: "Hellog"),
        maxLines: 1,
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
        textDirection: TextDirection.ltr)
      ..layout())
        .size;

    _positionController.addListener(() async{
      googleLocationController = await _controller.future;
      setState(() {
      marker = [];
      marker.add(Marker(markerId: MarkerId("SelectedLocation"), position: LatLng(_positionController.position.latitude, _positionController.position.longitude)));
    });
     // print("HELLO "+_positionController.position.toString());
      googleLocationController.animateCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(
                      _positionController.position.latitude,
                      _positionController.position.longitude
                  ),
                  zoom: 17
              )
          )
      );
      widget.locationController.getAddress();
    });

    return Container(
        height:widget.height - (240 + size.height )+ 20,
        width: widget.width,
        child:GoogleMap(
          padding: EdgeInsets.only(bottom: 30),
          initialCameraPosition: CameraPosition(
              target: _positionController.position==null
                  ? LatLng(21.5937, 81.9629)
                  : LatLng(_positionController.position.latitude, _positionController.position.longitude),
              zoom: _positionController.position==null?4:12
          ),
          zoomControlsEnabled: false,
          onTap: (ll){
            _positionController.position = Position(longitude: ll.longitude, latitude: ll.latitude);
          },
          markers: Set.from(marker),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ));
  }
}
