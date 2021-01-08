import 'package:flutter/material.dart';
import 'package:takeeazy_customer/screens/values/colors.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: Color(0xffeeeeee),
          filled: true,
          prefixIcon: Icon(
            Icons.search,
            color: TakeEazyColors.gradient2Color,
          ),
          suffixIcon: IconButton(
            iconSize: 20,
            icon: Icon(
              Icons.close,
              color: TakeEazyColors.gradient2Color,
            ),
            onPressed: () {},
          ),
          hintText: 'Search for a store/item',
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
