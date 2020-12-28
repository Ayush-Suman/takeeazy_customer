import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/values/colors.dart';
import 'package:takeeazy_customer/controller/locationcontroller.dart';

class TEButton extends StatelessWidget{
  final double height;
  final double width;
  final TEText text;
  final Function onPressed;
  final bool colored;
  final bool rounded;

  TEButton({this.height=50, this.width=100, this.text, this.onPressed, this.colored=true, this.rounded=true});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        child: FlatButton(
          shape: rounded?RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))):null,
            onPressed: onPressed,
            child: text,
        ),
        decoration: BoxDecoration(
          color: colored?null:Color(0xffaaaaaa),
            borderRadius: rounded?BorderRadius.all(Radius.circular(8)):null,
            gradient: colored?LinearGradient(
                begin:  Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  TakeEazyColors.gradient1Color,
                  TakeEazyColors.gradient2Color,
                  TakeEazyColors.gradient3Color,
                  TakeEazyColors.gradient4Color
                ]
            ):null
        )
    );
  }
}