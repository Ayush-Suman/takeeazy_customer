import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/textcontroller.dart';

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
        this.maxLines});

  @override
  Widget build(BuildContext context) {
    assert(!(text!=null && controller!=null));

    return ChangeNotifierProvider.value(
      value: controller,
      builder: (_, a)=>
          Consumer<TextController>(
            builder: (_, cont, child)=>
                Text(
                    text??cont.text??"",
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        color: fontColor,
                        fontWeight: fontWeight,
                        fontSize: fontSize),
                    maxLines: maxLines),
          ),
    );
  }

}