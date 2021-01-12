import 'package:flutter/material.dart';
import 'package:takeeazy_customer/screens/components/customsearchbar.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/nearbystores/shopCard.dart';
import 'package:takeeazy_customer/screens/components/subcategory.dart';

class Shop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TEText(
          text: 'Daily Groceries',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ShopCard(),
            ),
            //SearchBar(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromRGBO(196, 196, 196, 0.46),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    child: TEText(
                      text: 'Categories',
                      fontColor: Color(0xff3b6e9e),
                      fontWeight: FontWeight.w500,
                      fontSize: 18.96,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SubCategoryWidget(widgetName: 'Vegetables'),
                        SubCategoryWidget(widgetName: 'Fruits'),
                        SubCategoryWidget(widgetName: 'PlaceHolder'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
              child: TEText(
                text: 'Best Sellers',
                fontColor: Color(0xff3b6e9e),
                fontWeight: FontWeight.w500,
                fontSize: 18.96,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.5),
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[600],
                  ),
                ),
                itemCount: 9,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
