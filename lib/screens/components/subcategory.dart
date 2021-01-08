import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:takeeazy_customer/screens/item/item.dart';
import 'customtext.dart';

class SubCategoryWidget extends StatelessWidget {
  final String widgetName;

  const SubCategoryWidget({
    this.widgetName,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          // will be shifted to named routes
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Item(),
            ),
          );
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
              ),
            ],
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl:'https://ik.imagekit.io/dunzo/tr:w-488,h-360_home_icon/dunzo/icons/newHome/promoBanner/kitImageUrl/largeIcons/default_grocery_secondary2_1607672711525.png',
                  fit: BoxFit.contain,
                  height: height * 0.13,
                )
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 5, top: 2, right: 1, left: 1),
                child: TEText(
                  text: widgetName[0].toUpperCase() + widgetName.substring(1),
                  fontColor: Color(0xff3b6e9e),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
