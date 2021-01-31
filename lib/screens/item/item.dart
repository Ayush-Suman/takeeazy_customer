import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/screens/item/itemscontroller.dart';
import 'package:takeeazy_customer/screens/controller/optioncontroller.dart';
import 'package:takeeazy_customer/model/takeeazyapis/items/itemsModel.dart';
import 'package:takeeazy_customer/screens/bottomnav/bottonnav.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/item/itemcard.dart';


class Item extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemState();
}

class _ItemState extends State<Item>{

  @override
  Widget build(BuildContext context) {
    ItemsController itemsController = Provider.of<ItemsController>(context);
    itemsController.updateValues();
    itemsController.getItems();


    return  Scaffold(
        appBar: AppBar(
          /*bottom: TabBar(tabs: [
            TEText(
              text: 'Bread',
              fontColor: Colors.black,
            ),
            TEText(
              text: 'Oil',
              fontColor: Colors.black,
            ),
            TEText(
              text: 'View All',
              fontColor: Colors.black,
            ),
          ])*/
          title: TEText(
            text: itemsController.categoriesModel.name,
          ),
        ),
        body: ChangeNotifierProvider.value(value: itemsController.itemListController,builder:(_,a)=>Consumer<OptionController<ItemsModel>>(builder: (_, oc, child)=>oc.updatedController.value?ListView.builder(
            itemBuilder: (_, pos)=> ItemCard(itemModel: oc.list[pos], quantity:itemsController.quantities[pos], valueController: itemsController.valueControllers[pos]),
          itemCount: oc.list.length,
        ):Center(child: CircularProgressIndicator(),)))

        /*TabBarView(
          children: [
            ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) => ItemCard(isCart: false,),
              itemCount: 10,
            ),
            ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: 10,
              itemBuilder: (context, index) => ItemCard(isCart: false,),
            ),
            ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: 10,
              itemBuilder: (context, index) => ItemCard(isCart: false,),
            ),
          ],
        )*/
      );
  }



  @override
  void dispose() {
    HomeNavigator.currentPageIndex=2;
    super.dispose();
  }
}
