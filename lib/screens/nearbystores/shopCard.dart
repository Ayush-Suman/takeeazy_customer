import 'package:flutter/material.dart';
import 'package:takeeazy_customer/model/caching/runtimecaching.dart';
import 'package:takeeazy_customer/model/takeeazyapis/stores/storesModel.dart';
import 'package:takeeazy_customer/screens/components/servicesWidget.dart';
import 'package:takeeazy_customer/screens/values/colors.dart';
import '../components/customtext.dart';

class ShopCard extends StatelessWidget {
  final ShopModel shopModel;
  ShopCard({this.shopModel});


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final Size size = (TextPainter(
        text: TextSpan(text: "3.8", style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal, fontFamily: 'Rubik')),
        maxLines: 1,
        textScaleFactor: MediaQuery
            .of(context)
            .textScaleFactor,
        textDirection: TextDirection.ltr)
      ..layout())
        .size;


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [RoundedImage(imageURL: null, height: width*0.25, width: width*0.25),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: width*0.75-100-size.width
                          ),
                          child:TEText(
                        text: shopModel.shopName,
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                        maxLines: 1,
                        fontColor: Color(0xff3b6e9e),
                      )),
                      const SizedBox(
                        width: 12,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 9,
                        child: Icon(
                          Icons.star,
                          size: 13,
                          color: TakeEazyColors.gradient2Color,
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
                        text: RuntimeCaching.city,
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
