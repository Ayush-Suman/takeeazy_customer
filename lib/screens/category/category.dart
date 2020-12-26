import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(),
          SliverFillRemaining(
            child: Column(
              children: listOfElements(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> listOfElements() {
    List<String> names = ['Widget 1', 'Widget 2'];
    List<Widget> children = [];
    children = names
        .map((text) =>
        Container(
          height: 40,
          margin: EdgeInsets.symmetric(vertical: 10),
          color: Colors.grey[300],
          alignment: Alignment.center,
          child: Text('$text item'),
        ))
        .toList();
    children.insert(
        0,
        Container(
            child: Text(
              'Widget 3',
            )));

    return children;
  }
}
