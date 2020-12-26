import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/homecontroller.dart';
import 'package:takeeazy_customer/screens/components/categoryWidget.dart';
import 'package:takeeazy_customer/screens/components/customsearchbar.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/components/servicesWidget.dart';
import 'package:takeeazy_customer/screens/values/colors.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Provider.of<HomeController>(context, listen: false).updateValues();

    return Scaffold(
      body: Consumer<ServiceableArea>(
        builder: (_, serACont, child) => serACont.serviceableArea
            ? ListView(
                children: [
                  Consumer<HomeController>(
                      builder: (_, hcont, child) => Padding(
                          padding: EdgeInsets.all(20),
                          child: TEText(
                            controller: hcont.city,
                            fontSize: 20,
                            fontColor: TakeEazyColors.gradient2Color,
                            fontWeight: FontWeight.w700,
                          ))),
                  SearchBar(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ServicesWidget(widgetName: 'pickupanddrop'),
                        ServicesWidget(widgetName: 'assistant'),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromRGBO(196, 196, 196, 0.46),
                    ),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 14),
                          child: TEText(
                            text: 'Instant delivery to your doorstep',
                            fontColor: Color(0xff3b6e9e),
                            fontWeight: FontWeight.w500,
                            fontSize: 18.96,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CategoryWidget(
                                  widgetName: 'daily Groceries', type: true),
                              CategoryWidget(
                                  widgetName: 'fruits and Vegetables',
                                  type: true),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CategoryWidget(
                                  widgetName: 'meat and Fish', type: false),
                              CategoryWidget(
                                  widgetName: 'medicines', type: false),
                              CategoryWidget(
                                  widgetName: 'pet Care', type: false),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    child: TEText(
                      text: 'Top picks for you',
                      fontColor: Color(0xff3b6e9e),
                      fontWeight: FontWeight.w500,
                      fontSize: 18.96,
                    ),
                  ),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.5),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey,
                      ),
                    ),
                    itemCount: 9,
                  )
                ],
              )
            : Center(
                child: TEText(text: "We are not serviceable in your area"),
              ),
      ),
    );
  }
}
