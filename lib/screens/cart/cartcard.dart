import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/cartcontroller.dart';
import 'package:takeeazy_customer/controller/textcontroller.dart';
import 'package:takeeazy_customer/model/takeeazyapis/cart/cartmodel.dart';
import 'package:takeeazy_customer/model/takeeazyapis/items/itemsModel.dart';
import 'package:takeeazy_customer/screens/components/customdropdown.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/components/servicesWidget.dart';

class CartCard extends StatelessWidget {
  final CartModel cartModel;
  final TextController quantity;
  final ValueNotifier<Variants> valueController;
  CartCard({this.cartModel, this.quantity, this.valueController});



  @override
  Widget build(BuildContext context) {

    CartController cartController = Provider.of<CartController>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundedImage(
              imageURL:cartModel.imageURL,
              width: 100,
              height: 100,
            ),
            SizedBox(width: 20),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TEText(
                    text: cartModel.name,
                    fontColor: Color(0xff3b6e9e),
                    fontSize: 16.59,
                    fontWeight: FontWeight.w400,
                  ),
                  cartModel.variants.length>1?
                      TEDropDown<Variants>(
                        valueController: valueController,
                        items: cartModel.variants.map((e) => DropdownMenuItem(child: TEText(text: e.variantName), value: e,)).toList(),
                        onChanged: (e) {
                          valueController.value = e;
                          cartModel.selectedVariant = e;
                          cartController.updateCart(cartModel, quantity.text);
                        } ,
                      )

                  /*DropdownButton(
                    value: cartModel.selectedVariant,
                      items: cartModel.variants.map((e) => DropdownMenuItem(child: TEText(text: e.variantName), value: e,)).toList(),
                      onChanged: (e){
                        cartModel.selectedVariant = e;
                        cartController.updateCart(cartModel, quantity.text);
                      })*/:Padding(padding: EdgeInsets.only(top: 5), child:TEText(text: cartModel.variants[0].variantName))
                ]),
            Expanded(child: Container(),),

            Row(
              mainAxisSize: MainAxisSize.min,
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
                    cartController.updateCart(cartModel, quantity.text);
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
                    cartController.updateCart(cartModel, quantity.text);
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
