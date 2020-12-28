import 'package:flutter/material.dart';

class HamBurgerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: () {},
        icon: Image.asset(
          'assets/hamburger.png',
          width: 40,
          height: 40,
        ),
      ),
    );
  }
}
