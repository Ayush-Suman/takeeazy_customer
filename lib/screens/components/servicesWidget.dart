import 'package:flutter/material.dart';

import 'customtext.dart';

class ServicesWidget extends StatelessWidget {
  final String widgetName;

  const ServicesWidget({
    this.widgetName});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          print(widgetName);
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                'assets/' + widgetName + '.png',
                fit: BoxFit.contain,
                height: height * 0.16,
                errorBuilder: (context, error, stackTrace) => TEText(
                    text:
                    widgetName[0].toUpperCase() + widgetName.substring(1)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}