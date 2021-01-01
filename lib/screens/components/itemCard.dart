import 'package:flutter/material.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';

class ItemCard extends StatelessWidget {
  final bool isCart;

  const ItemCard({this.isCart});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/assistant.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                TEText(
                  text: 'itemName',
                  fontColor: Color(0xff3b6e9e),
                  fontSize: 16.59,
                  fontWeight: FontWeight.w400,
                ),
                isCart
                    ? TEText(
                        text: 'itemName',
                        fontColor: Color(0xff3b6e9e),
                        fontSize: 16.59,
                        fontWeight: FontWeight.w400,
                      )
                    : Container(),
              ],
            ),
            Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: new Icon(
                    Icons.remove,
                    color: Color(0xff3b6e9e),
                    size: 15.23,
                  ),
                  onPressed: () {},
                ),
                TEText(
                  text: '1',
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
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
