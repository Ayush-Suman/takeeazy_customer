import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/locationcontroller.dart';
import 'package:takeeazy_customer/screens/components/custombutton.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/values/colors.dart';


class LocationConfirm extends StatefulWidget{
  LocationConfirm({this.height, this.width});

  final double height;
  final double width;

  @override
  State<StatefulWidget> createState() {
    return _LocationConfirmState(height: height, width: width);
  }
}

class _LocationConfirmState extends State{
  final double height;
  final double width;
  _LocationConfirmState({@required this.height, @required this.width});

  LocationController _locationController;

  @override
  void initState() {
     _locationController = Provider.of<LocationController>(context, listen: false);
     _locationController.focusNode.listStatusController = _locationController.listStatusController;
     _locationController.focusNode.addListener(() {
       _locationController.addressLine.selection = TextSelection(baseOffset: 0, extentOffset: _locationController.addressLine.text.length);
     });
     if(_locationController.liveLocationRequired) {_locationController.getLocationData();} else {_locationController.positionController.notify();}
     Timer timer = Timer(Duration(seconds: 1), (){print("Timer Ended");});
     _locationController.addressLine.addListener((){
       timer.cancel();
       timer = Timer(Duration(seconds: 1), (){
         print("Getting Address suggestions for "+_locationController.addressLine.text);
         _locationController.getLocationFromAddress();
       });
     });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;

    final Size size = (TextPainter(
        text: TextSpan(text: "Hellog"),
        maxLines: 1,
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
        textDirection: TextDirection.ltr)
      ..layout())
        .size;


    return Container(child:Consumer<ListStatusController>(builder:(_, lscont, child)=>
        Stack(children:[

          // AddressList
          lscont.listOpen
              ? Container(
            width: width,
              height: height-top,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [BoxShadow(
                  blurRadius: 10,
                  offset: Offset(0, 2)
                )],
                color:Colors.white
              ),
                child: Column(
                    children:[
                      Stack(children:[
                      Center(child:Padding(
                          padding: EdgeInsets.only(top:12),
                          child:FlatButton(child:Icon(
                            Icons.keyboard_arrow_down,
                            size: 40,
                          ),
                            onPressed: (){
                              lscont.listOpen = false;
                              _locationController.focusNode.unfocus();
                              _locationController.reSyncValues();
                              },
                          )
                      )),
                      Positioned(
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child:ChangeNotifierProvider.value(
                                value: _locationController.searchController,
                               builder:(_, a)=>
                                   Consumer<SearchController>(
                                     builder: (_, sc, child){
                                        print(sc.isSearching.toString());
                                        return _locationController.searchController.isSearching?child:Container();
                                       },
                                       child:CircularProgressIndicator(),))
                        ),
                        right: 10,)
                      ]),
                      Container(
                        width: width,
                        height: height-top-60,
                        child:ChangeNotifierProvider.value(
                        value: _locationController.listController,
                        builder: (_, a) =>
                            Consumer<AddressListController>(builder: (_, lcont, child)=>
                                ListView.builder(
                                  itemBuilder: (_, pos)=>FlatButton(onPressed: (){
                                    _locationController.selectAddress(lcont.addresses[pos]);
                                  },
                                      child: TEText(text: lcont.addresses[pos].main+" "+lcont.addresses[pos].secondary,)),
                                  itemCount: lcont.addresses.length,
                                ),
                            )
                    ),)
                ])
          ) : Container(height: 0,),

          // BottomSheet
          lscont.listOpen?Positioned(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 25,
              child: child):
                    Container(
                width: width,
                height: 240+size.height,
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
                             if(
                             locstatCont.locationStatus == LocationStatus.Fetched
                                 || locstatCont.locationStatus == LocationStatus.Failed
                                 || locstatCont.locationStatus == LocationStatus.Done){
                                  return Column(
                                children: [Row(
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
                                              ConstrainedBox(
                                                constraints: BoxConstraints(maxWidth: width*0.5) ,
                                                child:TEText(
                                                  controller: _locationController.city,
                                                  fontColor: TakeEazyColors.gradient2Color,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 24,
                                                    maxLines: 1,
                                                  ),),
                                        Expanded(child: Container()),
                                        Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 20),
                                            child:FlatButton(
                                              onPressed: (){
                                                  _locationController.focusNode.requestFocus();
                                              },
                                              child: TEText(text: "Change"),
                                              color: Color(0xffeeeeee),
                                            ))
                                      ],),
                                    child,
                                    Expanded(child: Container()),
                                   Padding(
                                      padding: EdgeInsets.all(20),
                                      child:TEButton(
                                          height: 50,
                                          width: width,
                                          text: TEText(text: "CONFIRM LOCATION", fontWeight: FontWeight.w700, fontColor: Color(0xffffffff)),
                                          onPressed: () async{
                                            _locationController.getMetaData();
                                          })
                                    ),
                                  ],
                                );
                             } else if(locstatCont.locationStatus == LocationStatus.Fetching){
                               return Center(child: CircularProgressIndicator());
                             } else{
                                 return Center(child: TEText(text: "Something Went Wrong"));
                              }
                          })))

        ]),
      child: ConstrainedBox(
                  constraints:BoxConstraints(
                      maxHeight: 70,
                      maxWidth: width - 50),
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