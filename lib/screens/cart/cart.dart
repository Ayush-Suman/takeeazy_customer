import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/cartcontroller.dart';
import 'package:takeeazy_customer/controller/textcontroller.dart';
import 'package:takeeazy_customer/model/takeeazyapis/items/itemsModel.dart';
import 'package:takeeazy_customer/model/takeeazyapis/stores/storesModel.dart';
import 'package:takeeazy_customer/screens/cart/cartcard.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/item/itemcard.dart';

class Cart extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final CartController cartController = Provider.of<CartController>(context, listen: false);
    cartController.updateValues();

    return Scaffold(
      appBar: AppBar(
        title: TEText(
          text: 'Cart',
          fontWeight: FontWeight.w700,
        ),
      ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TEButton(
              height: 50,
              width: width,
              text: TEText(
                  text: "ORDER NOW",
                  fontWeight: FontWeight.w700,
                  fontColor: Color(0xffffffff)),
              onPressed: () async {
                cartController.orderNow();
              }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ChangeNotifierProvider.value(value: cartController.cartListController, builder: (_,a)=>Consumer<CartListController>(builder: (_, cc, child)=>cc.updatedController.value?cc.list.length!=0?ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) => CartCard(cc.list[index], cartController.quantities[index]),
        itemCount: cc.list.length,
      ):Center(child:TEText(text: "No item in the cart",)):Center(child: CircularProgressIndicator()),
    )));
  }
}
