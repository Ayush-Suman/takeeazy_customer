import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/model/caching/runtimecaching.dart';
import 'package:takeeazy_customer/screens/cart/cartcontroller.dart';
import 'package:takeeazy_customer/screens/controller/optioncontroller.dart';
import 'package:takeeazy_customer/model/takeeazyapis/cart/cartmodel.dart';
import 'package:takeeazy_customer/screens/cart/cartcard.dart';
import 'package:takeeazy_customer/screens/components/custombutton.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';

class Cart extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final CartController cartController = Provider.of<CartController>(
        context, listen: false);
    cartController.updateValues();

    return Scaffold(
        appBar: AppBar(
          title: TEText(
            text: 'Cart',
            fontWeight: FontWeight.w700,
          ),
        ),
        floatingActionButton: RuntimeCaching.serviceableArea ? Padding(
          padding: const EdgeInsets.all(10.0),
          child: ChangeNotifierProvider.value(
              value: cartController.cartListController,
              builder: (_, a) =>
                  Consumer<OptionController<CartModel>>(builder: (_, clc, c) =>
                      TEButton(
                          height: 50,
                          width: width,
                          colored: clc.list.isNotEmpty,
                          text: TEText(
                            text: "Order Now",
                            fontWeight: FontWeight.w700,
                            fontColor: clc.list.isNotEmpty
                                ? Color(0xffffffff)
                                : Color(0xfff5f5f5),),
                          onPressed: () async {
                            cartController.orderNow(clc.list.isNotEmpty);
                          }))),
        ) : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: RuntimeCaching.serviceableArea ? ChangeNotifierProvider.value(
            value: cartController.cartListController, builder: (_, a) =>
            Consumer<OptionController<CartModel>>(builder: (_, cc, child) =>
            cc.updatedController.value ? cc.list.length != 0 ? ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) =>
              index < cc.list.length
                  ? CartCard(cartModel: cc.list[index],
                  quantity: cartController.quantities[index],
                  valueController: cartController.valueControllers[index])
                  : Container(height: 70),
              itemCount: cc.list.length + 1,
            ) : Center(child: TEText(text: "No item in the cart",)) : Center(
                child: CircularProgressIndicator()),
            )) : Center(
          child: TEText(text: "We are not serviceable in your area"),));
  }
}
