import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/optioncontroller.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/values/colors.dart';

class Options extends StatelessWidget{
  Options({
    this.onTap, this.controller, this.title});
  final String title;
  final Function onTap;
  final OptionController controller;



  @override
  Widget build(BuildContext context) {
    final Size size = (TextPainter(
        text: TextSpan(text: "Hellog", style: TextStyle(fontSize: 12)),
        maxLines: 1,

        textScaleFactor: MediaQuery
            .of(context)
            .textScaleFactor,
        textDirection: TextDirection.ltr)
      ..layout())
        .size;

    final double width = MediaQuery.of(context).size.width;

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //color: Color(0xffeeeeee),
        ),
        margin: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20, horizontal: 10),
                child: TEText(
                  text: title,
                  fontColor: TakeEazyColors.gradient2Color,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              ChangeNotifierProvider.value(
                  value: controller,
                  builder: (_, a) =>
                      Consumer<OptionController>(
                          builder: (_, controller, child) =>

                              controller.updatedController.value ? GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            children: controller.list.map(
                                    (e) =>
                                    Padding(padding: EdgeInsets
                                        .symmetric(vertical: 5,
                                        horizontal: 5),
                                      child: GestureDetector(
                                          onTap: ()=>onTap(e),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(1, 5),
                                                    spreadRadius: -4,
                                                    blurRadius: 6,
                                                  ),
                                                ],
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            height: (width - 20) / 3 - 10,
                                            width: (width - 20) / 3 - 10,
                                            child: Column(
                                              children: [
                                                Container(
                                                    height: ((width - 20) / 3 - 10) - size.height - 20,
                                                    width: (width - 20) / 3 - 10,
                                                    child: Center(
                                                        child: e.imageURL!=null?CachedNetworkImage(
                                                          imageUrl: e.imageURL,
                                                          fit: BoxFit.fitWidth,):
                                                        Image.asset('assets/takeeazy_icon.png')
                                                    )),
                                                Center(
                                                    child: Padding(
                                                        padding: EdgeInsets
                                                            .all(
                                                            10),
                                                        child: FittedBox(
                                                            child: TEText(
                                                              text: e.name,
                                                              fontColor: TakeEazyColors.gradient2Color,
                                                              fontSize: 12,
                                                              maxLines: 1,
                                                              fontWeight: FontWeight.w700,))))
                                              ],
                                            ),
                                          )),
                                    )).toList(),
                          ) : Center(child: Padding(
                              padding: EdgeInsets.all(50),
                              child: CircularProgressIndicator()))))
            ]
        )
    );
  }
}