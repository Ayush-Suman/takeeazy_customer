import 'package:flutter/material.dart';

import 'customtext.dart';

class ShopCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
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
            child: Image.asset(
              'assets/assistant.png',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      TEText(
                        text: 'ShopName',
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                        fontColor: Color(0xff3b6e9e),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      CircleAvatar(
                        radius: 9,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.star,
                          size: 13,
                          color: Color(0xff3b6e9e),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      TEText(
                        text: '3.8',
                        fontColor: Color(0xff3b6e9e),
                        fontSize: 11,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.pin_drop_outlined,
                        color: Color(0xffA19F9F),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      TEText(
                        text: '3 km',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.59,
                        fontColor: Color(0xffA19F9F),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      TEText(
                        text: 'Gandhi Nagar',
                        fontColor: Color(0xffA19F9F),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer,
                        color: Color(0xffA19F9F),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      TEText(
                        text: '40 mins',
                        fontWeight: FontWeight.w400,
                        fontSize: 14.06,
                        fontColor: Color(0xffA19F9F),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
