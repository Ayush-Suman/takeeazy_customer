import 'package:flutter/material.dart';
import 'package:takeeazy_customer/screens/category/category.dart';

import 'customtext.dart';

class CategoryWidget extends StatelessWidget {
  final String widgetName;
  final bool type;

  const CategoryWidget({
    this.widgetName,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          //will be shifted to named routes
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Category(),
            ),
          );
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
              ),
            ],
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/' + widgetName + '.png',
                  fit: BoxFit.contain,
                  height: type ? height * 0.16 : height * 0.13,
                  errorBuilder: (context, error, stackTrace) => TEText(
                      text: widgetName[0].toUpperCase() +
                          widgetName.substring(1)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 5, top: 2, right: 1, left: 1),
                child: TEText(
                  text: widgetName[0].toUpperCase() + widgetName.substring(1),
                  fontColor: Color(0xff3b6e9e),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
