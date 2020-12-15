import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/locationcontroller.dart';
import 'package:takeeazy_customer/screens/components/custombutton.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';


class LocationSelect extends StatelessWidget{
  final Completer<GoogleMapController> _controller = Completer();


@override
  Widget build(BuildContext context) {
  Position _position = Provider.of<CurrentLocation>(context, listen: false).position;

  final CameraPosition _cameraPosition = CameraPosition(
      target: _position==null?LatLng(21.5937, 81.9629):LatLng(_position.latitude, _position.longitude),
      zoom: _position==null?4:12
  );

  final top = MediaQuery.of(context).padding.top;
  final width = MediaQuery.of(context).size.width;
  final _textController = TextEditingController();

    return Scaffold(
      body: Stack(
          children: [
              GoogleMap(
                initialCameraPosition: _cameraPosition,
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller){
                  _controller.complete(controller);
                },
                markers: _position==null?null:{Marker(markerId: MarkerId("Current Location"), position: LatLng(_position.latitude, _position.longitude))},
              ),
          Positioned(bottom: 10,
            right: width*0.05,
            child:Row(children:[
              TEButton(
                  height: 50,
                  width: width*0.425,
                  text: TEText("Use Live Location", fontColor: Colors.white,fontWeight: FontWeight.w700, fontSize: 14),
                  colored: false
              ),
              SizedBox(width: width*0.05),
              TEButton(
                height: 50,
                width: width*0.425,
                text: TEText("Save", fontColor: Colors.white,fontWeight: FontWeight.w700, fontSize: 14, ),
              )])),
          Positioned(
              top: top+10,
              child: Container(
                  height: 50,
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