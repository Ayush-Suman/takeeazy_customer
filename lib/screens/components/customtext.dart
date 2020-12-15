import 'package:flutter/cupertino.dart';

class TEText extends Text{
  TEText(
      String text,
      {
        Color fontColor,
        FontWeight
        fontWeight,
        double fontSize,
        int maxLines
      }):super(
      text,
      style: TextStyle(
          fontFamily: 'Rubik',
          color: fontColor,
          fontWeight: fontWeight,
          fontSize: fontSize),
      maxLines: maxLines
  );
}