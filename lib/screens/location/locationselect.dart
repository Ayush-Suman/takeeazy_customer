import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class LocationSelect extends StatelessWidget{
  Completer<GoogleMapController> _controller = Completer();
  Position _position;
  LocationSelect(this._position);

@override
  Widget build(BuildContext context) {
  final CameraPosition _cameraPosition = CameraPosition(
      target: _position==null?LatLng(0, 0):LatLng(_position.latitude, _position.longitude),
      zoom: 15
  );

  final top = MediaQuery.of(context).padding.top;
  final width = MediaQuery.of(context).size.width;
  final _textController = TextEditingController();

    return Scaffold(
      body: Stack(
          children: [
            Column(children: [
              Expanded(child:GoogleMap(
                initialCameraPosition: _cameraPosition,
                onMapCreated: (GoogleMapController controller){
                  _controller.complete(controller);
                },
              )),
              Container(
                      height: 50,
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: FlatButton(
                          onPressed: null,
                          child: Text("Use Current Location")
                      )
                  ),
            ],),
          Positioned(
              top: top+10,
              child: Container(
                  height: 40,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: TextField(
                    controller: _textController,
                    onChanged: null,
                  )
              )
          ),

          ]
      )
    );
  }
}