import 'package:flutter/material.dart';
import 'customtext.dart';

class ServicesWidget extends StatelessWidget {
  final String widgetName;

  const ServicesWidget({
    this.widgetName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print(widgetName);
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1,5),
                spreadRadius: -4,
                blurRadius: 6,
              ),
            ],
            color: Colors.white,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child:ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
                'assets/' + widgetName + '.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => TEText(
                    text:
                    widgetName[0].toUpperCase() + widgetName.substring(1)),
              ),
            )
      ));
  }
}