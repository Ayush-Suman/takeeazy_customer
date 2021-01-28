import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/itemscontroller.dart';
import 'package:takeeazy_customer/controller/textcontroller.dart';
import 'package:takeeazy_customer/model/takeeazyapis/items/itemsModel.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/components/servicesWidget.dart';

class ItemCard extends StatelessWidget {
  final ItemsModel itemModel;
  final TextController quantity;
  ItemCard(this.itemModel, this.quantity);



  @override
  Widget build(BuildContext context) {

    ItemsController itemsController = Provider.of<ItemsController>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(5)
        ),// RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundedImage(
                imageURL:itemModel.imageURL,
                width: 100,
                height: 100,
              ),
            ),
            Column(
              children: [
                TEText(
                  text: itemModel.name,
                  fontColor: Color(0xff3b6e9e),
                  fontSize: 16.59,
                  fontWeight: FontWeight.w400,
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: new Icon(
                    Icons.remove,
                    color: Color(0xff3b6e9e),
                    size: 15.23,
                  ),
                  onPressed: () {
                    if(quantity.text!='0'){
                    quantity.text = (int.parse(quantity.text)-1).toString();
                    }
                    itemsController.updateCart(itemModel, quantity.text);
                  },
                ),
                TEText(
                  controller: quantity,
                  fontColor: Color(0xff3b6e9e),
                  fontSize: 14.06,
                  fontWeight: FontWeight.w400,
                ),
                IconButton(
                  icon: new Icon(
                    Icons.add,
                    color: Color(0xff3b6e9e),
                    size: 15.23,
                  ),
                  onPressed: () {
                    quantity.text = (int.parse(quantity.text)+1).toString();
                    itemsController.updateCart(itemModel, quantity.text);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
