import 'package:flutter/material.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/components/itemCard.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TEText(
          text: 'Cart',
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) => ItemCard(
          isCart: true,
        ),
        itemCount: 10,
      ),
    );
  }
}
