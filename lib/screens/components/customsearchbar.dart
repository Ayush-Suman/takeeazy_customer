import 'package:flutter/material.dart';
import 'package:takeeazy_customer/screens/values/colors.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  SearchBar({@required this.controller, @required this.focusNode});



  @override
  Widget build(BuildContext context) {
    final Size size = (TextPainter(
        text: TextSpan(text: "Hellog"),
        maxLines: 1,
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
        textDirection: TextDirection.ltr)
      ..layout())
        .size;

    final double width = MediaQuery.of(context).size.width;

    return Container(width: width, child:Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Row(children:[Expanded(child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
          ),
          fillColor: Color(0xffeeeeee),
          filled: true,
          prefixIcon: Icon(
            Icons.search,
            color: TakeEazyColors.gradient2Color,
          ),
          hintText: 'Search for items',
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        )),
      ),
        Container(
          height: size.height+43,
          decoration: BoxDecoration(
            color:Color(0xffeeeeee),
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          child:IconButton(
          iconSize: 20,
          icon: Icon(
            Icons.close,
            color: TakeEazyColors.gradient2Color,
          ),
          onPressed: () {
            print("Closing Search");
            controller.text = "";
            focusNode.unfocus();
          },
        ),)
      ]))
    );
  }
}
