import 'package:flutter/material.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/components/itemCard.dart';

class Item extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: [
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
          ]),
          title: TEText(
            text: 'Category Name comes here',
          ),
        ),
        body: TabBarView(
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
        ),
      ),
    );
  }
}
