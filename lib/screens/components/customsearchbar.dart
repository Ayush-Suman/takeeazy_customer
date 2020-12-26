import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          fillColor: Color(0xfff3f2f2),
          filled: true,
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xff3b6e9e),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.cancel_outlined,
              color: Color(0xff3b6e9e),
              size: 20,
            ),
            onPressed: () {},
          ),
          hintText: ' Search for a store/item',
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
