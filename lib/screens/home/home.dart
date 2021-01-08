import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/homecontroller.dart';
import 'package:takeeazy_customer/main.dart';
import 'package:takeeazy_customer/model/navigator/navigatorservice.dart';
import 'package:takeeazy_customer/screens/components/customsearchbar.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/components/hamburgerButton.dart';
import 'package:takeeazy_customer/screens/components/servicesWidget.dart';
import 'package:takeeazy_customer/screens/values/colors.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    HomeController homeController = Provider.of<HomeController>(
        context, listen: false);
    homeController.updateValues();
    homeController.getContainers();

    return ChangeNotifierProvider.value(
        value: homeController.updatedController,
        builder: (_, a) =>
            Consumer<UpdatedController>(builder: (_, uc, child)=>uc.isUpdated?Scaffold(
                appBar: AppBar(
                  title: FlatButton(
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: (){NavigatorService.rootNavigator.popAndPushNamed(TERoutes.map);},
                      child:Row(
                          children:[
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
                              constraints: BoxConstraints(maxWidth: width*0.5) ,
                              child:TEText(
                                controller: homeController.city,
                                fontColor: TakeEazyColors.gradient2Color,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                maxLines: 1,
                              ),),])
                  ),
                  actions: [
                    HamBurgerButton(),
                  ],
                ),
                body:
                homeController.serviceableAreaController.serviceAvailable
                    ? ListView(
                  children: [
                    SearchBar(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ServicesWidget(widgetName: 'pickupanddrop'),
                          ServicesWidget(widgetName: 'assistant'),
                        ],
                      ),
                    ),
                    ChangeNotifierProvider.value(
                          value: homeController.containerListController,
                          builder: (_,a)=>Consumer<ContainerListController>(
                        builder:(_,clc, child)=> Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffeeeeee),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                            Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          child: TEText(
                            text: 'Instant delivery to your doorstep',
                            fontColor: TakeEazyColors.gradient2Color,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                                  clc.containerUpdatedController.isUpdated?GridView.count(
                                    shrinkWrap:true,
                                      crossAxisCount: 3,
                                    children: clc.containerList.map(
                                            (e) => Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                                child: Container(
                                                  height: ((width-20)/3-40)/2,
                                              width: (width-20)/3-40,
                                              child: Column(
                                                children: [
                                                  CachedNetworkImage(imageUrl: e.imagePath, fit:BoxFit.fitWidth,),
                                                  TEText(text: e.containerName,)
                                                ],
                                              ),
                                            )),
                                    ).toList(),
                                  ):Center(child:Padding(padding: EdgeInsets.all(50),child:CircularProgressIndicator()))
                                ])
                        ))
                    ),

                    /*Padding(
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
                      itemBuilder: (context, index) =>
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[600],
                            ),
                          ),
                      itemCount: 9,
                    ),*/
                  ],
                )
                    : Center(
                  child: TEText(text: "We are not serviceable in your area"),
                )):Scaffold(body: Center(child: CircularProgressIndicator()),)));
  }
}
