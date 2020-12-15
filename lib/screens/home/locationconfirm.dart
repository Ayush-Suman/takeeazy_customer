import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/homecontroller.dart';
import 'package:takeeazy_customer/controller/locationcontroller.dart';
import 'package:takeeazy_customer/main.dart';
import 'package:takeeazy_customer/screens/components/custombutton.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/values/colors.dart';

class LocationConfirm extends StatelessWidget{
  final double height;
  final double width;
  LocationConfirm(this.height, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height*0.4,
      decoration: BoxDecoration(
          color: Colors.white ,
          borderRadius: BorderRadius.only(topRight:Radius.circular(20), topLeft:Radius.circular(20)),
          boxShadow: [BoxShadow(
              color:Colors.black,
              blurRadius: 10,
              spreadRadius: -5)]
      ),
      child: Column(
        children: [
          Row(
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
              Consumer<HomeController>(
                  builder: (_, homeCont, child)=>
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: width*0.5) ,
                        child:TEText(
                          homeCont.city??"City Name",
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
                      Navigator.pushNamed(context, TERoutes.map);
                    },
                    child: TEText("Change"),
                    color: Color(0xffeeeeee),
                  ))
            ],),
          Consumer<HomeController>(
              builder: (_, homeCont, child)=>
                  ConstrainedBox(
                      constraints:BoxConstraints(
                          maxWidth: width*0.8),
                      child:TEText(
                          homeCont.addressLine)
                  )
          ),
          Expanded(child: Container()),
          Padding(
            padding: EdgeInsets.all(20),
            child:TEButton(
                height: 50,
                width: width,
                text: TEText("CONFIRM LOCATION", fontWeight: FontWeight.w700, fontColor: Color(0xffffffff)),
                onPressed: (){
                  Provider.of<HomeController>(context, listen: false).getMetaData();
                  Navigator.pop(context);
                })
          )
        ],
      ),
    );
  }
}