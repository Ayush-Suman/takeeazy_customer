import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeeazy_customer/screens/values/colors.dart';

class BottomNav extends StatelessWidget{
  final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      key:globalKey,
      body: Container(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xffEEEDED)
        ),
        child: Row(
          children: [
            FlatButton(minWidth: width/3, padding: EdgeInsets.zero, onPressed: (){}, child: Icon(Icons.shop, color: TakeEazyColors.gradient2Color)),
            FlatButton(minWidth: width/3, padding: EdgeInsets.zero, onPressed: (){}, child: Icon(Icons.home, color: TakeEazyColors.gradient2Color)),
            FlatButton(minWidth: width/3, padding: EdgeInsets.zero, onPressed: (){}, child: Icon(Icons.shopping_cart, color: TakeEazyColors.gradient2Color))
          ],
        ),
      ),
    );
  }
}