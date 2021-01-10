import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/components/shopCard.dart';
import 'package:takeeazy_customer/screens/shop/shop.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TEText(
          text: 'Daily Groceries',
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //SearchBar(),
        /*  Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
            ),
          ),*/
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
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                child: ShopCard(),
                onTap: () {
                  // will be shifted to named routes later
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Shop(),
                    ),
                  );
                },
              ),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
