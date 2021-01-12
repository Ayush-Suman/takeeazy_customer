import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/nearbystorescontroller.dart';
import 'package:takeeazy_customer/model/navigator/navigatorservice.dart';
import 'package:takeeazy_customer/model/takeeazyapis/containers/containersModel.dart';
import 'package:takeeazy_customer/screens/components/customsearchbar.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/nearbystores/shopCard.dart';
import 'package:takeeazy_customer/screens/bottomnav/bottonnav.dart';

class NearbyStores extends StatelessWidget {

  @override
  Widget build(BuildContext context) {;

    final NearbyStoresController nearbyStoresController = Provider.of<NearbyStoresController>(context, listen: false);

    nearbyStoresController.updateValues();
    nearbyStoresController.getStoresNearby();

    return Scaffold(
      appBar: AppBar(
        title: TEText(
          text: nearbyStoresController.container.containerName,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchBar(controller: nearbyStoresController.search, focusNode: nearbyStoresController.searchFocus),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            child: TEText(
              text: 'Stores Nearby',
              fontColor: Color(0xff3b6e9e),
              fontWeight: FontWeight.w500,
              fontSize: 18.96,
            ),
          ),
          Expanded(
            child: ChangeNotifierProvider.value(value: nearbyStoresController.storesListController, builder: (_,a)=>Consumer<StoresListController>(builder: (_, slc, child)=>slc.updatedController.value?slc.shops.length>0?ListView.builder(
              padding: const EdgeInsets.all(8.0),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                child: ShopCard(shopModel: slc.shops[index],),
                onTap: () {
                  nearbyStoresController.openShop(slc.shops[index]);
                }),
              itemCount: slc.shops.length,
              ):Center(child:TEText(text: 'No Stores Found',)):Center(child: CircularProgressIndicator(),),
            ),
          )),
        ],
      ),
    );
  }

}
