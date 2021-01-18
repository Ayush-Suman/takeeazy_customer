import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/homecontroller.dart';
import 'package:takeeazy_customer/controller/optioncontroller.dart';
import 'package:takeeazy_customer/main.dart';
import 'package:takeeazy_customer/model/navigator/navigatorservice.dart';
import 'package:takeeazy_customer/screens/components/customsearchbar.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/components/options.dart';
import 'package:takeeazy_customer/screens/components/servicesWidget.dart';
import 'package:takeeazy_customer/screens/values/colors.dart';


class Home extends StatelessWidget {

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

    HomeController homeController = Provider.of<HomeController>(context, listen: false);

    homeController.updateValues();
    homeController.getContainers();

    return ChangeNotifierProvider.value(
        value: homeController.updatedController,
        builder: (_, a) =>
            Consumer<ValueNotifier<bool>>(builder: (_, uc, child) =>
            uc.value ? Scaffold(
                appBar: AppBar(
                  title: FlatButton(
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        NavigatorService.rootNavigator.popAndPushNamed(
                            TERoutes.map);
                      },
                      child: Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 8
                                ),
                                child: Icon(
                                  Icons.location_on,
                                  size: 30,
                                  color: TakeEazyColors.gradient2Color,
                                )
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: width * 0.5),
                              child: TEText(
                                controller: homeController.city,
                                fontColor: TakeEazyColors.gradient2Color,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                maxLines: 1,
                              ),),
                          ])
                  ),
                ),
                body:
                uc.value
                    ? ListView(
                  children: [
                    SearchBar(controller: homeController.search, focusNode: homeController.searchFocus,),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RoundedImage(imageAsset:'assets/pickupanddrop.png'),
                          RoundedImage(imageAsset:'assets/assistant.png'),
                        ],
                      ),
                    ),
                    Options(
                      controller: homeController.containerListController,
                      title: 'Instant Delivery to your doorstep',
                      onTap: (o){
                        homeController.openContainer(o);
                      },
                    ),
                    Container(
                        height: 192/315*(width-20),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors
                                .grey,
                            offset: Offset(
                                1, 5),
                            spreadRadius: -4,
                            blurRadius: 6,
                          ),
                        ],
                        //color: Color(0xffeeeeee),
                      ),
                      child: Row(
                        children:[
                          Padding(padding:EdgeInsets.all(20), child:Container(width: (width-80)/2-50,child:Image.asset('assets/takeeazy_icon.png'))),
                          Padding(padding:EdgeInsets.all(20), child:Container(width: (width-80)/2+10,child:Image.asset('assets/description.png', fit: BoxFit.contain,)))
                        ]
                      )
                    )
                  ],
                ): Center(
                  child: TEText(text: "We are not serviceable in your area"),
                )) : Scaffold(
              body: Center(child: CircularProgressIndicator()),)));
  }
}
