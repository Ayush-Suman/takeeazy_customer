import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/homecontroller.dart';
import 'package:takeeazy_customer/main.dart';
import 'package:takeeazy_customer/model/navigator/navigatorservice.dart';
import 'package:takeeazy_customer/screens/components/customsearchbar.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/components/servicesWidget.dart';
import 'package:takeeazy_customer/screens/values/colors.dart';
import 'package:takeeazy_customer/screens/bottomnav/bottonnav.dart';


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
            Consumer<UpdatedController>(builder: (_, uc, child) =>
            uc.isUpdated ? Scaffold(
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
                homeController.serviceableAreaController.serviceAvailable
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
                    Container(
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
                                  text: 'Instant delivery to your doorstep',
                                  fontColor: TakeEazyColors.gradient2Color,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              ChangeNotifierProvider.value(
                                  value: homeController.containerListController,
                                  builder: (_, a) =>
                                      Consumer<ContainerListController>(
                                          builder: (_, clc, child) =>
                                          clc.containerUpdatedController
                                              .isUpdated ? GridView.count(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            crossAxisCount: 3,
                                            children: clc.containerList.map(
                                                    (e) =>
                                                    Padding(padding: EdgeInsets
                                                        .symmetric(vertical: 5,
                                                        horizontal: 5),
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            NavigatorService.homeNavigator.pushNamed(HomeNavigator.stores, arguments: e);
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey,
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
                                                                        child: CachedNetworkImage(
                                                                          imageUrl: e
                                                                              .imagePath,
                                                                          fit: BoxFit
                                                                              .fitWidth,))),
                                                                Center(
                                                                    child: Padding(
                                                                        padding: EdgeInsets
                                                                            .all(
                                                                            10),
                                                                        child: FittedBox(
                                                                            child: TEText(
                                                                              text: e
                                                                                  .containerName,
                                                                              fontColor: TakeEazyColors
                                                                                  .gradient2Color,
                                                                              fontSize: 12,
                                                                              maxLines: 1,
                                                                              fontWeight: FontWeight
                                                                                  .w700,))))
                                                              ],
                                                            ),
                                                          )),
                                                    )).toList(),
                                          ) : Center(child: Padding(
                                              padding: EdgeInsets.all(50),
                                              child: CircularProgressIndicator()))))
                            ]
                        )
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
