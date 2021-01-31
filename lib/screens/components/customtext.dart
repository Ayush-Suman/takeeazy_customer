import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/screens/controller/textcontroller.dart';

class TEText extends StatelessWidget{
  final TextController controller;
  final String text;
  final Color fontColor;
  final FontWeight fontWeight;
  final double fontSize;
  final int maxLines;

  TEText({this.controller,
        this.text,
        this.fontColor,
        this.fontWeight,
        this.fontSize,
        this.maxLines}):assert(!(text!=null && controller!=null));

  @override
  Widget build(BuildContext context) {

    return controller!=null
        ? ChangeNotifierProvider.value(
      value: controller,
      builder: (_, a)=>
          Consumer<TextController>(
            builder: (_, cont, child)=>
                Text(
                    cont.text??"",
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        color: fontColor,
                        fontWeight: fontWeight,
                        fontSize: fontSize),
                    maxLines: maxLines),
          ),
    )
    : Text(
        text??"",
        style: TextStyle(
            fontFamily: 'Rubik',
            color: fontColor,
            fontWeight: fontWeight,
            fontSize: fontSize),
        maxLines: maxLines);
  }

}