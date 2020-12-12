import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/home/homecontroller.dart';

class LocationConfirm extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height*0.5,
      decoration: BoxDecoration(
          color: Colors.white ,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [BoxShadow(
              color:Colors.black,
              blurRadius: 10,
              spreadRadius: -5)]
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.add_location_alt_sharp, size: 50,),
              Consumer<HomeController>(builder: (_, homeCont, child)=>Text(homeCont.city??"City Name")),
              FlatButton(onPressed: null, child: Text("Change"))
            ],),
          Text("Lorem Ipsum"),
          FlatButton(
              onPressed: null,
              child: Text("Confirm Location"))
        ],),
    );
  }
}