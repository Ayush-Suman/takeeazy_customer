import 'package:flutter/material.dart';

import 'customtext.dart';

class SubCategoryWidget extends StatelessWidget {
  final String widgetName;

  const SubCategoryWidget({
    this.widgetName,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {},
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
                  'assets/pet Care.png',
                  fit: BoxFit.contain,
                  height: height * 0.13,
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
