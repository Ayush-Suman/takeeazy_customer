import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/locationcontroller.dart';
import 'package:takeeazy_customer/main.dart';
import 'package:takeeazy_customer/screens/components/custombutton.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/values/colors.dart';

class LocationConfirm extends StatelessWidget{
  final double height;
  final double width;
  LocationConfirm({@required this.height, @required this.width});

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    final LocationController _locationController = Provider.of<LocationController>(context, listen: false);
    _locationController.getLocationData().then((value) => print("Rebuilt Bottom Sheet"));
    Timer timer = Timer(Duration(seconds: 1), (){print("Timer Ended");});

    _locationController.addressLine.addListener((){
      timer.cancel();
      timer = Timer(Duration(seconds: 1), (){
        print("Getting Address suggestions for "+_locationController.addressLine.text);
        _locationController.getLocationFromAddress(_locationController.addressLine.text);
      });

    });

    _locationController.focusNode.addListener(() {
      _locationController.listStatusController.openList(true);
    });

    final Size size = (TextPainter(
        text: TextSpan(text: "Hellog"),
        maxLines: 1,
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
        textDirection: TextDirection.ltr)
      ..layout())
        .size;

    return Container(child:Consumer<ListStatusController>(builder:(_, lscont, child)=>
        Column(children:[
          lscont.listOpen
              ? Container(
            width: width,
              height: height-size.height-60,
              color: Colors.white,
              child:Padding(
                padding: EdgeInsets.only(top: top),
                child: ChangeNotifierProvider.value(
                    value: _locationController.listController,
                    builder: (_, a) =>
                        Consumer<AddressListController>(builder: (_, lcont, child)=>
                            ListView.builder(
                              itemBuilder: (_, pos)=>FlatButton(onPressed: (){
                                lscont.openList(false);
                                _locationController.selectAddress(lcont.addresses[pos]);
                              },
                                  // TODO: Change address to self implemented Place API parsed class
                                  child: TEText(text: lcont.addresses[pos].addressLine,)),
                              itemCount: lcont.addresses.length,
                            ),
                        )
                )
            )
          ) : Container(height: 0,),

          Container(
      width: width,
      height: lscont.listOpen
          ? size.height+60
          : 240+size.height,
      decoration: BoxDecoration(
          color: Colors.white ,
          borderRadius: BorderRadius.only(
              topRight:Radius.circular(20),
              topLeft:Radius.circular(20)),
          boxShadow: [BoxShadow(
              color:Colors.black,
              blurRadius: 10,
              spreadRadius: -5)]
      ),
      child: ChangeNotifierProvider.value(
          value: _locationController.locationStatusController,
          builder: (_, a)=>
              Consumer<LocationStatusController>(
                builder: (_, locstatCont, c){
                    switch(locstatCont.locationStatus){

                      case LocationStatus.Fetched:
                        return Column(
                      children: [
                        lscont.listOpen
                            ? Container()
                            : Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 12),
                                child: Icon(
                                  Icons.location_on,
                                  size: 40,
                                  color: TakeEazyColors.gradient2Color,
                                )
                            ),
                            Consumer<LocationController>(
                                builder: (_, locCont, child)=>
                                    ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: width*0.5) ,
                                      child:TEText(
                                        controller: locCont.city,
                                        fontColor: TakeEazyColors.gradient2Color,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24,
                                          maxLines: 1,
                                        ),)),
                              Expanded(child: Container()),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child:FlatButton(
                                    onPressed: (){
                                      _locationController.listStatusController.openList(true);
                                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                        _locationController.focusNode.requestFocus();
                                      });

                                    },
                                    child: TEText(text: "Change"),
                                    color: Color(0xffeeeeee),
                                  ))
                            ],),
                          child,
                          Expanded(child: Container()),
                          lscont.listOpen
                              ? Container()
                              : Padding(
                            padding: EdgeInsets.all(20),
                            child:TEButton(
                                height: 50,
                                width: width,
                                text: TEText(text: "CONFIRM LOCATION", fontWeight: FontWeight.w700, fontColor: Color(0xffffffff)),
                                onPressed: () async{
                                  await Provider.of<LocationController>(context, listen: false).getMetaData();
                                  Provider.of<LocationController>(context, listen: false).storeValues();
                                  Navigator.popAndPushNamed(context, TERoutes.home);
                                })
                          ),
                        ],
                      );

                      case LocationStatus.Fetching:
                        return Center(child: CircularProgressIndicator());

                      case LocationStatus.Denied:
                        return Column(
                          children: [
                            lscont.listOpen
                                ? Container()
                                : Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20,
                                        horizontal: 12),
                                    child: Icon(
                                      Icons.location_on,
                                      size: 40,
                                      color: TakeEazyColors.gradient2Color,
                                    )
                                ),
                                Consumer<LocationController>(
                                    builder: (_, locCont, child)=>
                                        ConstrainedBox(
                                          constraints: BoxConstraints(maxWidth: width*0.5) ,
                                          child:TEText(
                                            controller: locCont.city,
                                            fontColor: TakeEazyColors.gradient2Color,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24,
                                            maxLines: 1,
                                          ),)),
                                Expanded(child: Container()),
                                Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child:FlatButton(
                                      onPressed: (){
                                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                          _locationController.focusNode.requestFocus();
                                        });

                                      },
                                      child: TEText(text: "Change"),
                                      color: Color(0xffeeeeee),
                                    ))
                              ],),
                            child,
                            Expanded(child: Container()),
                            lscont.listOpen
                                ? Container()
                                : Padding(
                                padding: EdgeInsets.all(20),
                                child:TEButton(
                                    height: 50,
                                    width: width,
                                    text: TEText(text: "CONFIRM LOCATION", fontWeight: FontWeight.w700, fontColor: Color(0xffffffff)),
                                    onPressed: ()async{
                                      await Provider.of<LocationController>(context, listen: false).getMetaData();
                                      Provider.of<LocationController>(context, listen: false).storeValues();
                                      Navigator.popAndPushNamed(context, TERoutes.home);
                                    })
                            ),
                          ],
                        );
                      default: return Center(child: TEText(text: "Something Went Wrong"));
                    }
                })))

        ]),
      child: ConstrainedBox(
                  constraints:BoxConstraints(
                      maxHeight: 70,
                      maxWidth: width*0.8),
                  child:Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffeeeeee),
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child:TextField(
                        focusNode: _locationController.focusNode,
                        decoration: InputDecoration(
                          hintText: "Enter Address",
                          border: InputBorder.none,
                        ),
                        controller : _locationController.addressLine)
              ))
      ),
       ));
  }
}