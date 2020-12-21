import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/homecontroller.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/values/colors.dart';


class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Provider.of<HomeController>(context, listen:  false).updateValues();

    return Scaffold(
      body:
      Consumer<ServiceableArea>(
          builder: (_, serACont, child)=>serACont.serviceableArea
              ? ListView(
        children: [
          Consumer<HomeController>(builder: (_, hcont, child)=>
              Padding(
                  padding: EdgeInsets.all(20),
                  child:TEText(
                    controller: hcont.city,
                    fontSize: 20,
                    fontColor: TakeEazyColors.gradient2Color,
                    fontWeight: FontWeight.w700,
                  ))),
          Padding(padding: EdgeInsets.all(10), child: Container(
            height: 50,
            width: width*0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Color(0xffeeeeee)
            ),
            child: Row(
              children: [
                Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none
                  )))),
                  Container(
                    height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                  child:FlatButton(
                    padding: EdgeInsets.zero,
                      onPressed: (){}, 
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                      child:Padding(padding: EdgeInsets.all(5),child: Icon(Icons.search, size: 40,color: Color(0xffaaaaaa),)))
                  )]))),
          Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Row(children: [
            SizedBox(width: 0.1,),
            Container(
              color: Color(0xffeeeeee),
              height: 100,
              width: 0.35,
              child: Image.asset('assets/pickupanddrop.png', fit: BoxFit.fitWidth,),
            ),
            SizedBox(width: 0.1),
            Container(
                color: Color(0xffeeeeee),
              height: 100,
                width: 0.35,
                child: Image.asset('assets/assistant.png', fit: BoxFit.fitWidth)
            ),
            SizedBox(width: 0.1,)
          ])),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
            )
          )
              ],
            )
              : Center(child: TEText(text: "We are not serviceable in your area")))
    );
  }

}