import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/locationcontroller.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/map/locationconfirm.dart';
import 'package:takeeazy_customer/screens/map/mapwithmarker.dart';
import 'package:takeeazy_customer/screens/values/colors.dart';
import 'package:google_maps_flutter_platform_interface/src/types/marker_updates.dart';

class LocationSelect extends StatefulWidget{

  @override
  State<StatefulWidget> createState() =>_LocationSelectState();

}

class _LocationSelectState extends State<LocationSelect>{





@override
  Widget build(BuildContext context) {
  print("rebuilding map");

  final top = MediaQuery.of(context).padding.top;
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  final LocationController _locationController = Provider.of<LocationController>(context, listen: false);
  final PositionController _positionController = _locationController.positionController;
  GoogleMapController googleLocationController;

  final FocusNode focusNode = FocusNode();

  focusNode.addListener(() {
    print("Received Focus "+focusNode.hasFocus.toString());
    _locationController.listStatusController.openList(focusNode.hasFocus);
  });

  final Size size = (TextPainter(
      text: TextSpan(text: "Hellog"),
      maxLines: 1,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textDirection: TextDirection.ltr)
    ..layout())
      .size;






  return Scaffold(
      body: Stack(
          children: [
              Container(height: height,),
              MapWithMarker(height, width, _locationController),
            Positioned(
                bottom: 240+ size.height+20,
                right: 20,
                child: Container(
                  height:  50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                      boxShadow: [BoxShadow(blurRadius: 5, spreadRadius: -2, offset: Offset(2,2))],
                      borderRadius: BorderRadius.all(Radius.circular(25))
                      ),
                  child: FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                    onPressed: () async{
                      await _locationController.requestLocationAccess();
                    },
                    child:Icon(Icons.location_searching, color: TakeEazyColors.gradient2Color,),
                )
            )),

          Positioned(bottom: 0,
              child: ChangeNotifierProvider.value(
                  value: _locationController.listStatusController,
                  builder:(_,a)=>LocationConfirm(
                      width:width,
                      height:height
                  )
              )
          )]
      )
    );
  }


}